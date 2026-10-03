import Foundation

enum GameplayError: Error, Equatable {
    case invalidConfiguration
    case invalidState
    case rejectedOutcome
}

/// Foundation error boundary. Associated repository details remain internal
/// and are never used directly as user-facing copy.
enum ApplicationError: Error, Equatable {
    case content(ContentRepositoryError)
    case gameplay(GameplayError)
    case temporarilyUnavailable

    var code: String {
        switch self {
        case .content(.missingResource): return "content.missing_resource"
        case .content(.malformedContent): return "content.malformed"
        case .content(.invalidContent): return "content.invalid"
        case .content(.itemNotFound): return "content.item_not_found"
        case .gameplay(.invalidConfiguration): return "gameplay.invalid_configuration"
        case .gameplay(.invalidState): return "gameplay.invalid_state"
        case .gameplay(.rejectedOutcome): return "gameplay.rejected_outcome"
        case .temporarilyUnavailable: return "application.temporarily_unavailable"
        }
    }
}

enum RecoveryAction: Equatable {
    case retry
    case returnToStory
}

struct UserFacingError: Error, Equatable {
    let title: String
    let message: String
    let actions: [RecoveryAction]
}

extension ApplicationError {
    var userFacingError: UserFacingError {
        switch self {
        case .content(.missingResource), .content(.itemNotFound):
            return UserFacingError(
                title: "Content unavailable",
                message: "This part of the adventure is unavailable right now.",
                actions: [.retry, .returnToStory]
            )
        case .content(.malformedContent), .content(.invalidContent):
            return UserFacingError(
                title: "Content unavailable",
                message: "This part of the adventure cannot be shown right now.",
                actions: [.returnToStory]
            )
        case .gameplay:
            return UserFacingError(
                title: "Activity unavailable",
                message: "This activity cannot continue right now.",
                actions: [.retry, .returnToStory]
            )
        case .temporarilyUnavailable:
            return UserFacingError(
                title: "Adventure unavailable",
                message: "The adventure is unavailable right now. Please try again.",
                actions: [.retry]
            )
        }
    }
}

enum LogLevel: String, Equatable { case info, warning, error }
enum LogCategory: String, Equatable { case application, content, gameplay }
enum LogOperation: String, Equatable {
    case contentLoad
    case contentDecode
    case storyStart
    case activityResult
}

struct LogContext: Equatable {
    let storyID: StoryID?
    let contentIdentifier: String?

    init(storyID: StoryID? = nil, contentIdentifier: String? = nil) {
        self.storyID = storyID
        self.contentIdentifier = contentIdentifier
    }
}

struct StructuredLogEvent: Equatable {
    let level: LogLevel
    let category: LogCategory
    let code: String
    let operation: LogOperation
    let metadata: [String: String]
}

protocol StructuredLogWriting {
    func write(_ event: StructuredLogEvent)
}

enum LoggingMode: Equatable { case development, production }

/// Emits allow-listed diagnostic fields only. There is no free-form message,
/// user content, answer, Scripture text, or external telemetry dependency.
struct FoundationLogger {
    let mode: LoggingMode
    let writer: any StructuredLogWriting

    func record(
        _ error: ApplicationError,
        operation: LogOperation,
        context: LogContext = LogContext()
    ) {
        var metadata: [String: String] = [:]
        if let storyID = context.storyID {
            metadata["story_id"] = storyID.rawValue
        }
        if mode == .development, let contentIdentifier = context.contentIdentifier {
            metadata["content_id"] = contentIdentifier
        }

        writer.write(StructuredLogEvent(
            level: .error,
            category: error.category,
            code: error.code,
            operation: operation,
            metadata: metadata
        ))
    }
}

private extension ApplicationError {
    var category: LogCategory {
        switch self {
        case .content: return .content
        case .gameplay: return .gameplay
        case .temporarilyUnavailable: return .application
        }
    }
}

/// Converts repository failures into safe presentation errors while retaining
/// useful structured diagnostics behind the injected logging boundary.
struct RecoverableContentHandler {
    let logger: FoundationLogger

    func resolve<Value>(
        _ result: Result<Value, ContentRepositoryError>,
        operation: LogOperation,
        context: LogContext = LogContext()
    ) -> Result<Value, UserFacingError> {
        switch result {
        case .success(let value):
            return .success(value)
        case .failure(let repositoryError):
            let error = ApplicationError.content(repositoryError)
            logger.record(error, operation: operation, context: context)
            return .failure(error.userFacingError)
        }
    }
}
