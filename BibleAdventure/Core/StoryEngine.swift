import Foundation

/// Provides story definitions to `StoryEngine` without coupling the engine to
/// a story-specific repository or content implementation.
protocol StoryLoading {
    func story(for storyID: StoryID) -> Story?
}

/// A reusable boundary for loading and managing one configured story session.
///
/// This engine owns session start, completion, and restart state only. Step
/// advancement, conditional progression, activity results, persistence, and
/// presentation integration remain outside this contract.
struct StoryEngine {
    private let loader: any StoryLoading

    private(set) var gameState: GameState = .inactive
    private(set) var currentStory: Story?

    init(loader: any StoryLoading) {
        self.loader = loader
    }

    /// The first configured step for the active story. Progression rules will
    /// determine later steps in a separately approved task.
    var currentStep: StoryStep? {
        guard case .active(let activeSession) = gameState,
              activeSession.story.status == .active
        else {
            return nil
        }

        return currentStory?.steps.first
    }

    var isCompleted: Bool {
        guard case .active(let activeSession) = gameState else {
            return false
        }

        return activeSession.story.status == .completed
    }

    /// Loads and starts a story from an inactive game session.
    @discardableResult
    mutating func start(storyID: StoryID) -> Bool {
        guard gameState == .inactive,
              let story = loader.story(for: storyID)
        else {
            return false
        }

        currentStory = story
        gameState = .active(
            ActiveGameState(story: StoryState(storyID: story.id))
        )
        return true
    }

    /// Marks the active story complete without advancing or executing content.
    @discardableResult
    mutating func complete() -> Bool {
        guard case .active(let activeSession) = gameState,
              let completedStory = activeSession.story.transitioned(to: .completed)
        else {
            return false
        }

        gameState = .active(
            ActiveGameState(
                story: completedStory,
                objective: activeSession.objective,
                miniGame: activeSession.miniGame
            )
        )
        return true
    }

    /// Reloads the current story as a new active session without adding retry
    /// or progression behavior.
    @discardableResult
    mutating func restart() -> Bool {
        guard case .active(let activeSession) = gameState,
              let story = loader.story(for: activeSession.story.storyID)
        else {
            return false
        }

        currentStory = story
        gameState = .active(
            ActiveGameState(story: StoryState(storyID: story.id))
        )
        return true
    }
}
