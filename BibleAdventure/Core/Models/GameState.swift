import Foundation

/// The state hierarchy for a single game session.
///
/// `GameState` owns an optional active session. An active session always owns a
/// `StoryState`; objective and mini-game state are optional phases within that
/// story. These domain contracts deliberately do not own progression behavior,
/// persistence, or presentation state.
enum GameState: Equatable {
    case inactive
    case active(ActiveGameState)

    /// Returns the requested game state only when the top-level lifecycle
    /// transition is legal.
    func transitioned(to state: GameState) -> GameState? {
        switch (self, state) {
        case (.inactive, .active), (.active, .inactive):
            return state
        default:
            return nil
        }
    }
}

/// The state held while one story session is active.
struct ActiveGameState: Equatable {
    let story: StoryState
    let objective: ObjectiveState?
    let miniGame: MiniGameState?

    init(
        story: StoryState,
        objective: ObjectiveState? = nil,
        miniGame: MiniGameState? = nil
    ) {
        self.story = story
        self.objective = objective
        self.miniGame = miniGame
    }
}

/// Lifecycle state for the active story in a game session.
struct StoryState: Equatable {
    enum Status: Equatable {
        case active
        case completed
    }

    let storyID: StoryID
    let status: Status

    init(storyID: StoryID, status: Status = .active) {
        self.storyID = storyID
        self.status = status
    }

    /// Legal transition: `active → completed`.
    func transitioned(to status: Status) -> StoryState? {
        guard self.status == .active, status == .completed else {
            return nil
        }

        return StoryState(storyID: storyID, status: status)
    }
}

/// A generic identity for an objective state. It intentionally does not encode
/// story content or presentation behavior.
struct ObjectiveState: Equatable {
    enum Status: Equatable {
        case inactive
        case active
        case completed
        case failed
    }

    let objectiveID: String
    let status: Status

    init(objectiveID: String, status: Status = .inactive) {
        self.objectiveID = objectiveID
        self.status = status
    }

    /// Legal transitions: `inactive → active`, `active → completed`, and
    /// `active → failed`. Completed and failed states are terminal until a
    /// future reset/retry requirement defines a new contract.
    func transitioned(to status: Status) -> ObjectiveState? {
        guard isLegalTransition(to: status) else {
            return nil
        }

        return ObjectiveState(objectiveID: objectiveID, status: status)
    }

    private func isLegalTransition(to status: Status) -> Bool {
        switch (self.status, status) {
        case (.inactive, .active), (.active, .completed), (.active, .failed):
            return true
        default:
            return false
        }
    }
}

/// A generic identity for a mini-game state. It deliberately does not use a
/// story-content enum.
struct MiniGameState: Equatable {
    enum Status: Equatable {
        case inactive
        case active
        case completed
        case failed
    }

    let miniGameID: String
    let status: Status

    init(miniGameID: String, status: Status = .inactive) {
        self.miniGameID = miniGameID
        self.status = status
    }

    /// Legal transitions: `inactive → active`, `active → completed`, and
    /// `active → failed`. Completed and failed states are terminal until a
    /// future reset/retry requirement defines a new contract.
    func transitioned(to status: Status) -> MiniGameState? {
        guard isLegalTransition(to: status) else {
            return nil
        }

        return MiniGameState(miniGameID: miniGameID, status: status)
    }

    private func isLegalTransition(to status: Status) -> Bool {
        switch (self.status, status) {
        case (.inactive, .active), (.active, .completed), (.active, .failed):
            return true
        default:
            return false
        }
    }
}
