import Foundation

/// Provides story definitions to `StoryEngine` without coupling the engine to
/// a story-specific repository or content implementation.
protocol StoryLoading {
    func story(for storyID: StoryID) -> Result<Story, ContentRepositoryError>
}

/// A reusable boundary for loading and managing one configured story session.
///
/// This engine owns session start, configured progression, completion, and
/// restart state. Persistence and presentation integration remain outside this
/// contract.
struct StoryEngine {
    private let loader: any StoryLoading
    private let progressionLoader: any StoryProgressionLoading

    private(set) var gameState: GameState = .inactive
    private(set) var currentStory: Story?
    private(set) var currentStepIndex: Int?
    private var progression: StoryProgression?

    init(
        loader: any StoryLoading,
        progressionLoader: any StoryProgressionLoading = SequentialStoryProgressionLoader()
    ) {
        self.loader = loader
        self.progressionLoader = progressionLoader
    }

    /// The configured current step for the active story.
    var currentStep: StoryStep? {
        guard case .active(let activeSession) = gameState,
              activeSession.story.status == .active,
              let currentStepIndex
        else {
            return nil
        }

        return currentStory?.steps[currentStepIndex]
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
              case .success(let story) = loader.story(for: storyID),
              !story.steps.isEmpty
        else {
            return false
        }

        let progression = progressionLoader.progression(for: story)
        guard progression.isValid(forStepCount: story.steps.count) else {
            return false
        }

        currentStory = story
        currentStepIndex = 0
        self.progression = progression
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
        currentStepIndex = nil
        return true
    }

    /// Applies a typed outcome through the configured progression map. The
    /// engine is the sole owner of any change to the current step.
    @discardableResult
    mutating func apply(outcome: StoryActivityOutcome) -> StoryProgressionResult {
        guard case .active(let activeSession) = gameState,
              activeSession.story.status == .active,
              let currentStepIndex,
              let progression
        else {
            return .rejected
        }

        if outcome == .retry {
            return .retrying
        }

        guard let transition = progression.transition(
            from: currentStepIndex,
            for: outcome
        ) else {
            return .rejected
        }

        switch transition.destination {
        case .step(let destinationIndex):
            self.currentStepIndex = destinationIndex
            return .advanced(toStepIndex: destinationIndex)

        case .complete:
            return complete() ? .completed : .rejected
        }
    }

    /// Reloads the current story as a new active session without adding retry
    /// or progression behavior.
    @discardableResult
    mutating func restart() -> Bool {
        guard case .active(let activeSession) = gameState,
              case .success(let story) = loader.story(
                for: activeSession.story.storyID
              ),
              !story.steps.isEmpty
        else {
            return false
        }

        let progression = progressionLoader.progression(for: story)
        guard progression.isValid(forStepCount: story.steps.count) else {
            return false
        }

        currentStory = story
        currentStepIndex = 0
        self.progression = progression
        gameState = .active(
            ActiveGameState(story: StoryState(storyID: story.id))
        )
        return true
    }
}
