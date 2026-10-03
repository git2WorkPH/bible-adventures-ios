import Foundation

/// A typed result returned by an activity to the Story Engine.
enum StoryActivityOutcome: Hashable {
    case success
    case failure
    case retry
    case condition(String)
}

/// The result of asking the Story Engine to apply an activity outcome.
enum StoryProgressionResult: Equatable {
    case advanced(toStepIndex: Int)
    case completed
    case retrying
    case rejected
}

/// A configured destination for a story-step transition.
enum StoryTransitionDestination: Equatable {
    case step(Int)
    case complete
}

/// A data-defined transition from one story-step index for a typed outcome.
struct StoryTransition: Equatable {
    let sourceStepIndex: Int
    let outcome: StoryActivityOutcome
    let destination: StoryTransitionDestination
}

/// A reusable, data-defined progression map for one story.
struct StoryProgression: Equatable {
    let transitions: [StoryTransition]

    /// Creates the default sequential success-only progression for a story.
    static func sequential(forStepCount stepCount: Int) -> StoryProgression {
        guard stepCount > 0 else {
            return StoryProgression(transitions: [])
        }

        let transitions = (0..<stepCount).map { index in
            StoryTransition(
                sourceStepIndex: index,
                outcome: .success,
                destination: index == stepCount - 1 ? .complete : .step(index + 1)
            )
        }

        return StoryProgression(transitions: transitions)
    }

    func transition(
        from stepIndex: Int,
        for outcome: StoryActivityOutcome
    ) -> StoryTransition? {
        transitions.first {
            $0.sourceStepIndex == stepIndex && $0.outcome == outcome
        }
    }

    func isValid(forStepCount stepCount: Int) -> Bool {
        guard stepCount > 0 else {
            return false
        }

        var keys = Set<TransitionKey>()

        for transition in transitions {
            guard (0..<stepCount).contains(transition.sourceStepIndex),
                  keys.insert(
                    TransitionKey(
                        sourceStepIndex: transition.sourceStepIndex,
                        outcome: transition.outcome
                    )
                  ).inserted
            else {
                return false
            }

            if case .step(let destinationIndex) = transition.destination,
               !(0..<stepCount).contains(destinationIndex) {
                return false
            }
        }

        return true
    }

    private struct TransitionKey: Hashable {
        let sourceStepIndex: Int
        let outcome: StoryActivityOutcome
    }
}

/// Supplies progression configuration without coupling the Story Engine to a
/// repository or to story-specific content.
protocol StoryProgressionLoading {
    func progression(for story: Story) -> StoryProgression
}

/// The default progression configuration: each successful step leads to the
/// next configured step, and the final successful step completes the story.
struct SequentialStoryProgressionLoader: StoryProgressionLoading {
    func progression(for story: Story) -> StoryProgression {
        StoryProgression.sequential(forStepCount: story.steps.count)
    }
}
