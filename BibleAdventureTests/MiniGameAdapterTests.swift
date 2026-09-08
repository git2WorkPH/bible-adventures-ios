import Foundation
import Testing
@testable import BibleAdventure

struct MiniGameAdapterTests {
    struct Loader: StoryLoading {
        func story(for id: StoryID) -> Result<Story, ContentRepositoryError> {
            let page = DialoguePage(speaker: .narrator, text: "Fixture",
                reference: BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: nil))
            return .success(Story(id: id, title: "Fixture", description: "Generic",
                                  steps: [.dialogue(page), .dialogue(page)]))
        }
    }
    struct FakeMiniGame {
        let attempt: UUID
        func finish(_ result: MiniGameResult, adapter: inout MiniGameAdapter) -> StoryProgressionResult {
            adapter.receive(result, attempt: attempt)
        }
    }
    func adapter(retry: Bool = true) -> MiniGameAdapter {
        var engine = StoryEngine(loader: Loader())
        engine.start(storyID: .moses)
        return MiniGameAdapter(configuration: MiniGameConfiguration(id: "fixture", allowsRetry: retry),
                               engine: engine)
    }

    @Test func fakeGameCompletesOnceThroughEngine() throws {
        var value = adapter()
        let token = value.start()
        let game = FakeMiniGame(attempt: try #require(token))
        let result = game.finish(.completed, adapter: &value)
        #expect(result == .advanced(toStepIndex: 1))
        #expect(value.state.status == .completed)
        let duplicate = game.finish(.completed, adapter: &value)
        #expect(duplicate == .rejected)
        #expect(value.engine.currentStepIndex == 1)
        let retry = value.retry()
        #expect(retry == nil)
    }

    @Test func failedAttemptRetriesAndRejectsOldCallbacks() throws {
        var value = adapter()
        let first = value.start()
        let token = try #require(first)
        let failure = value.receive(.failed, attempt: token)
        #expect(failure == .rejected) // No configured failure branch.
        #expect(value.state.status == .failed)
        #expect(value.engine.currentStepIndex == 0)
        let next = value.retry()
        let newToken = try #require(next)
        #expect(newToken != token)
        let stale = value.receive(.completed, attempt: token)
        #expect(stale == .rejected)
        let success = value.receive(.completed, attempt: newToken)
        #expect(success == .advanced(toStepIndex: 1))
    }

    @Test func invalidLifecycleAndDisabledRetryAreSafe() throws {
        var value = adapter(retry: false)
        let early = value.receive(.completed, attempt: UUID())
        #expect(early == .rejected)
        let token = value.start()
        let repeated = value.start()
        #expect(repeated == nil)
        value.receive(.failed, attempt: try #require(token))
        let retry = value.retry()
        #expect(retry == nil)
        #expect(value.engine.currentStepIndex == 0)
    }

    @Test func failureBranchPreventsRetryAtAnotherStep() throws {
        struct Branch: StoryProgressionLoading {
            func progression(for story: Story) -> StoryProgression {
                StoryProgression(transitions: [StoryTransition(sourceStepIndex: 0,
                    outcome: .failure, destination: .step(1))])
            }
        }
        var engine = StoryEngine(loader: Loader(), progressionLoader: Branch())
        engine.start(storyID: .moses)
        var value = MiniGameAdapter(configuration: MiniGameConfiguration(id: "fixture", allowsRetry: true),
                                    engine: engine)
        let token = value.start()
        let result = value.receive(.failed, attempt: try #require(token))
        #expect(result == .advanced(toStepIndex: 1))
        let retry = value.retry()
        #expect(retry == nil)
    }
}
