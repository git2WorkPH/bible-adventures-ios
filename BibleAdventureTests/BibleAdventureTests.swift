//
//  BibleAdventureTests.swift
//  BibleAdventureTests
//
//  Created by jc on 6/7/2026.
//

import Testing
@testable import BibleAdventure

struct BibleAdventureTests {

    @Test
    func storyEngineLoadsStartsAndExposesGenericStoryConfiguration() {
        let story = genericStoryFixture()
        var engine = StoryEngine(loader: InMemoryStoryLoader(stories: [story]))

        #expect(engine.start(storyID: .moses))
        #expect(engine.currentStory == story)
        #expect(engine.gameState == .active(
            ActiveGameState(story: StoryState(storyID: .moses))
        ))

        guard case .dialogue(let step) = engine.currentStep else {
            Issue.record("Expected the configured first step.")
            return
        }
        #expect(step.text == "First generic step.")
    }

    @Test
    func storyEngineCompletesAndRestartsWithoutProgressionRules() {
        let story = genericStoryFixture()
        var engine = StoryEngine(loader: InMemoryStoryLoader(stories: [story]))

        #expect(engine.start(storyID: .moses))
        #expect(engine.complete())
        #expect(engine.isCompleted)
        #expect(engine.currentStep == nil)
        #expect(!engine.complete())

        #expect(engine.restart())
        #expect(!engine.isCompleted)
        #expect(engine.currentStory == story)

        guard case .dialogue(let step) = engine.currentStep else {
            Issue.record("Expected restart to expose the first configured step.")
            return
        }
        #expect(step.text == "First generic step.")
    }

    @Test
    func storyEngineAdvancesSequentiallyOnlyAfterSuccess() {
        let story = genericStoryFixture()
        var engine = StoryEngine(loader: InMemoryStoryLoader(stories: [story]))

        #expect(engine.start(storyID: .moses))
        #expect(engine.apply(outcome: .success) == .advanced(toStepIndex: 1))
        #expect(engine.currentStepIndex == 1)
        #expect(engine.apply(outcome: .success) == .completed)
        #expect(engine.isCompleted)
    }

    @Test
    func storyEngineRejectsUnconfiguredFailureWithoutChangingProgression() {
        let story = genericStoryFixture()
        var engine = StoryEngine(loader: InMemoryStoryLoader(stories: [story]))

        #expect(engine.start(storyID: .moses))
        #expect(engine.apply(outcome: .failure) == .rejected)
        #expect(engine.currentStepIndex == 0)
        #expect(!engine.isCompleted)
    }

    @Test
    func storyEngineRepresentsRetryWithoutChangingProgression() {
        let story = genericStoryFixture()
        var engine = StoryEngine(loader: InMemoryStoryLoader(stories: [story]))

        #expect(engine.start(storyID: .moses))
        #expect(engine.apply(outcome: .retry) == .retrying)
        #expect(engine.currentStepIndex == 0)
        #expect(!engine.isCompleted)
    }

    @Test
    func storyEngineUsesDataDefinedFailureAndConditionalTransitions() {
        let story = genericStoryFixture()
        let progression = StoryProgression(
            transitions: [
                StoryTransition(
                    sourceStepIndex: 0,
                    outcome: .failure,
                    destination: .step(1)
                ),
                StoryTransition(
                    sourceStepIndex: 1,
                    outcome: .condition("ready-to-finish"),
                    destination: .complete
                )
            ]
        )
        var engine = StoryEngine(
            loader: InMemoryStoryLoader(stories: [story]),
            progressionLoader: InMemoryStoryProgressionLoader(
                progressions: [.moses: progression]
            )
        )

        #expect(engine.start(storyID: .moses))
        #expect(engine.apply(outcome: .failure) == .advanced(toStepIndex: 1))
        #expect(engine.apply(outcome: .condition("ready-to-finish")) == .completed)
        #expect(engine.isCompleted)
    }

    @Test
    func storyEngineRejectsInvalidProgressionConfiguration() {
        let story = genericStoryFixture()
        let invalidProgression = StoryProgression(
            transitions: [
                StoryTransition(
                    sourceStepIndex: 0,
                    outcome: .success,
                    destination: .step(99)
                )
            ]
        )
        var engine = StoryEngine(
            loader: InMemoryStoryLoader(stories: [story]),
            progressionLoader: InMemoryStoryProgressionLoader(
                progressions: [.moses: invalidProgression]
            )
        )

        #expect(!engine.start(storyID: .moses))
        #expect(engine.gameState == .inactive)
        #expect(engine.currentStepIndex == nil)
    }

    @Test
    func storyEngineRejectsMissingOrConcurrentStartsAndSupportsNoahContent() {
        let genericStory = genericStoryFixture()
        var engine = StoryEngine(
            loader: InMemoryStoryLoader(stories: [genericStory, NoahStory.build()])
        )

        #expect(!engine.start(storyID: .david))
        #expect(engine.start(storyID: .noah))
        #expect(!engine.start(storyID: .moses))
        #expect(engine.currentStory?.id == .noah)
    }

    @Test
    func gameStateRepresentsInactiveAndGenericActiveSessions() {
        let story = StoryState(storyID: .moses)
        let activeSession = ActiveGameState(story: story)

        #expect(GameState.inactive == .inactive)
        #expect(GameState.active(activeSession) == .active(activeSession))
        #expect(activeSession.story.storyID == .moses)
        #expect(activeSession.objective == nil)
        #expect(activeSession.miniGame == nil)
    }

    @Test
    func gameStateAllowsOnlyInactiveAndActiveTransitions() {
        let active = GameState.active(
            ActiveGameState(story: StoryState(storyID: .david))
        )

        #expect(GameState.inactive.transitioned(to: active) == active)
        #expect(active.transitioned(to: .inactive) == .inactive)
        #expect(GameState.inactive.transitioned(to: .inactive) == nil)
        #expect(active.transitioned(to: active) == nil)
    }

    @Test
    func storyStateAllowsOnlyCompletionFromActive() {
        let active = StoryState(storyID: .moses)
        let completed = StoryState(storyID: .moses, status: .completed)

        #expect(active.transitioned(to: .completed) == completed)
        #expect(active.transitioned(to: .active) == nil)
        #expect(completed.transitioned(to: .active) == nil)
        #expect(completed.transitioned(to: .completed) == nil)
    }

    @Test
    func objectiveStateEnforcesItsLifecycle() {
        let inactive = ObjectiveState(objectiveID: "generic-objective")
        let active = ObjectiveState(objectiveID: "generic-objective", status: .active)
        let completed = ObjectiveState(
            objectiveID: "generic-objective",
            status: .completed
        )

        #expect(inactive.transitioned(to: .active) == active)
        #expect(active.transitioned(to: .completed) == completed)
        #expect(active.transitioned(to: .failed)?.status == .failed)
        #expect(inactive.transitioned(to: .completed) == nil)
        #expect(completed.transitioned(to: .active) == nil)
    }

    @Test
    func miniGameStateEnforcesItsLifecycleWithoutStorySpecificContent() {
        let inactive = MiniGameState(miniGameID: "generic-mini-game")
        let active = MiniGameState(
            miniGameID: "generic-mini-game",
            status: .active
        )
        let failed = MiniGameState(
            miniGameID: "generic-mini-game",
            status: .failed
        )

        #expect(inactive.transitioned(to: .active) == active)
        #expect(active.transitioned(to: .failed) == failed)
        #expect(active.transitioned(to: .completed)?.status == .completed)
        #expect(inactive.transitioned(to: .failed) == nil)
        #expect(failed.transitioned(to: .active) == nil)
    }

    @Test
    func storyModelPreservesIdentityMetadataAndStepOrder() {
        let story = genericStoryFixture()

        #expect(story.id == .moses)
        #expect(story.title == "Test Story")
        #expect(story.description == "A reusable story-model fixture.")
        #expect(story.steps.count == 2)

        guard case .dialogue(let firstStep) = story.steps[0] else {
            Issue.record("Expected the first fixture step to be dialogue.")
            return
        }
        #expect(firstStep.text == "First generic step.")

        guard case .dialogue(let secondStep) = story.steps[1] else {
            Issue.record("Expected the second fixture step to be dialogue.")
            return
        }
        #expect(secondStep.text == "Second generic step.")
    }

    @Test
    func noahStoryRemainsRepresentableByReusableStoryModel() {
        let story = NoahStory.build()

        #expect(story.id == .noah)
        #expect(story.title == "Noah's Ark")
        #expect(!story.description.isEmpty)
        #expect(!story.steps.isEmpty)
    }

    private func genericStoryFixture() -> Story {
        Story(
            id: .moses,
            title: "Test Story",
            description: "A reusable story-model fixture.",
            steps: [
                .dialogue(
                    DialoguePage(
                        speaker: .narrator,
                        text: "First generic step.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 1,
                            startVerse: 1,
                            endVerse: nil
                        )
                    )
                ),
                .dialogue(
                    DialoguePage(
                        speaker: .narrator,
                        text: "Second generic step.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 1,
                            startVerse: 2,
                            endVerse: nil
                        )
                    )
                )
            ]
        )
    }

    private struct InMemoryStoryLoader: StoryLoading {
        let stories: [Story]

        func story(for storyID: StoryID) -> Story? {
            stories.first { $0.id == storyID }
        }
    }

    private struct InMemoryStoryProgressionLoader: StoryProgressionLoading {
        let progressions: [StoryID: StoryProgression]

        func progression(for story: Story) -> StoryProgression {
            progressions[story.id] ?? .sequential(forStepCount: story.steps.count)
        }
    }

}
