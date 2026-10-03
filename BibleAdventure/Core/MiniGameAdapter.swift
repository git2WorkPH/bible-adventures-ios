import Foundation

struct MiniGameConfiguration: Equatable {
    let id: String
    let allowsRetry: Bool
}

enum MiniGameResult: Equatable {
    case completed
    case failed

    var outcome: StoryActivityOutcome {
        switch self {
        case .completed: return .success
        case .failed: return .failure
        }
    }
}

/// A presentation-neutral owner of one engine and mini-game attempt. Views
/// retain the returned attempt ID and send it back with their result.
struct MiniGameAdapter {
    let configuration: MiniGameConfiguration
    private(set) var engine: StoryEngine
    private(set) var state: MiniGameState
    private(set) var attemptID: UUID?
    private var sourceStepIndex: Int?

    init(configuration: MiniGameConfiguration, engine: StoryEngine) {
        self.configuration = configuration
        self.engine = engine
        state = MiniGameState(miniGameID: configuration.id)
    }

    /// Engine must already be at the configured activity. Choosing the view
    /// and associating its configuration with that step is the caller's job.
    mutating func start() -> UUID? {
        guard !configuration.id.isEmpty, state.status == .inactive,
              engine.currentStep != nil else { return nil }
        sourceStepIndex = engine.currentStepIndex
        state = MiniGameState(miniGameID: configuration.id, status: .active)
        let token = UUID()
        attemptID = token
        return token
    }

    /// Duplicate, stale and pre-start callbacks cannot advance the engine.
    @discardableResult
    mutating func receive(_ result: MiniGameResult, attempt: UUID) -> StoryProgressionResult {
        guard state.status == .active, attemptID == attempt,
              engine.currentStepIndex == sourceStepIndex,
              engine.currentStep != nil else { return .rejected }
        state = MiniGameState(miniGameID: configuration.id,
                             status: result == .completed ? .completed : .failed)
        attemptID = nil
        return engine.apply(outcome: result.outcome)
    }

    /// Retry creates a fresh attempt only if failure left the story at the
    /// same step. A configured failure branch cannot be retried at its target.
    mutating func retry() -> UUID? {
        guard configuration.allowsRetry, state.status == .failed,
              engine.currentStep != nil,
              engine.currentStepIndex == sourceStepIndex else { return nil }
        guard engine.apply(outcome: .retry) == .retrying else { return nil }
        state = MiniGameState(miniGameID: configuration.id, status: .active)
        let token = UUID()
        attemptID = token
        return token
    }
}
