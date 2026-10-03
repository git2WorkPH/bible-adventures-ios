import Testing
@testable import BibleAdventure

struct ErrorHandlingTests {
    final class LogWriter: StructuredLogWriting {
        var events: [StructuredLogEvent] = []
        func write(_ event: StructuredLogEvent) { events.append(event) }
    }

    @Test func missingContentReturnsSafeRecoveryAndUsefulLog() {
        let writer = LogWriter()
        let handler = RecoverableContentHandler(logger: FoundationLogger(mode: .development, writer: writer))
        let internalName = "fixture-private-resource.json"
        let result: Result<String, UserFacingError> = handler.resolve(
            .failure(.missingResource(internalName)),
            operation: .contentLoad,
            context: LogContext(storyID: .moses, contentIdentifier: "fixture-content")
        )

        #expect(result == .failure(UserFacingError(
            title: "Content unavailable",
            message: "This part of the adventure is unavailable right now.",
            actions: [.retry, .returnToStory]
        )))
        #expect(!result.failureDescription.contains(internalName))
        #expect(writer.events == [StructuredLogEvent(
            level: .error,
            category: .content,
            code: "content.missing_resource",
            operation: .contentLoad,
            metadata: ["story_id": "moses", "content_id": "fixture-content"]
        )])
    }

    @Test func malformedContentDoesNotExposeDecoderDetails() {
        let writer = LogWriter()
        let handler = RecoverableContentHandler(logger: FoundationLogger(mode: .development, writer: writer))
        let details = "Unexpected token at byte 412"
        let result: Result<Int, UserFacingError> = handler.resolve(
            .failure(.malformedContent(details)), operation: .contentDecode
        )

        #expect(!result.failureDescription.contains(details))
        #expect(result.failureValue?.actions == [.returnToStory])
        #expect(writer.events.first?.code == "content.malformed")
    }

    @Test func productionLoggingOmitsContentIdentifier() {
        let writer = LogWriter()
        let logger = FoundationLogger(mode: .production, writer: writer)
        logger.record(
            .content(.itemNotFound("private-item")),
            operation: .contentLoad,
            context: LogContext(storyID: .noah, contentIdentifier: "private-item")
        )

        #expect(writer.events.first?.metadata == ["story_id": "noah"])
        #expect(writer.events.first?.code == "content.item_not_found")
    }

    @Test func successPassesThroughWithoutLoggingAndGameplayHasRecovery() {
        let writer = LogWriter()
        let handler = RecoverableContentHandler(logger: FoundationLogger(mode: .production, writer: writer))
        let result: Result<Int, UserFacingError> = handler.resolve(.success(7), operation: .contentLoad)
        #expect(result == .success(7))
        #expect(writer.events.isEmpty)

        let gameplay = ApplicationError.gameplay(.invalidState).userFacingError
        #expect(gameplay.actions == [.retry, .returnToStory])
        #expect(gameplay.message == "This activity cannot continue right now.")
    }
}

private extension Result where Failure == UserFacingError {
    var failureValue: UserFacingError? {
        guard case .failure(let error) = self else { return nil }
        return error
    }

    var failureDescription: String {
        failureValue.map { "\($0.title) \($0.message)" } ?? ""
    }
}
