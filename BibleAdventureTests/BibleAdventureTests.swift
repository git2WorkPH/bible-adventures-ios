//
//  BibleAdventureTests.swift
//  BibleAdventureTests
//
//  Created by jc on 6/7/2026.
//

import Foundation
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
    func storyRepositoryReturnsRecoverableMissingStoryError() {
        let repository = StoryRepository(stories: [genericStoryFixture()])

        guard case .success(let story) = repository.story(for: .moses) else {
            Issue.record("Expected the configured story.")
            return
        }
        #expect(story.id == .moses)

        guard case .failure(let error) = repository.story(for: .david) else {
            Issue.record("Expected a missing-story error.")
            return
        }
        #expect(error == .itemNotFound("story:david"))
    }

    @Test
    func questionRepositoryDecodesAndValidatesExternalQuestionContent() {
        let repository = QuestionRepository(
            dataSource: InMemoryContentDataSource(data: validQuestionData)
        )

        guard case .success(let question) = repository.question(for: "generic-question") else {
            Issue.record("Expected the configured question.")
            return
        }
        #expect(question.question == "Which answer is correct?")

        guard case .failure(let error) = repository.question(for: "missing") else {
            Issue.record("Expected a missing-question error.")
            return
        }
        #expect(error == .itemNotFound("question:missing"))
    }

    @Test
    func questionRepositoryReturnsRecoverableMalformedAndInvalidContentErrors() {
        let malformedRepository = QuestionRepository(
            dataSource: InMemoryContentDataSource(data: Data("[".utf8))
        )
        let invalidRepository = QuestionRepository(
            dataSource: InMemoryContentDataSource(data: invalidQuestionData)
        )

        guard case .failure(let malformedError) = malformedRepository.questions() else {
            Issue.record("Expected malformed content to be rejected.")
            return
        }
        #expect(malformedError == .malformedContent("questions"))

        guard case .failure(let invalidError) = invalidRepository.questions() else {
            Issue.record("Expected invalid content to be rejected.")
            return
        }
        #expect(invalidError == .invalidContent("questions"))
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

        func story(for storyID: StoryID) -> Result<Story, ContentRepositoryError> {
            guard let story = stories.first(where: { $0.id == storyID }) else {
                return .failure(.itemNotFound("story:\(storyID.rawValue)"))
            }

            return .success(story)
        }
    }

    private struct InMemoryContentDataSource: ContentDataLoading {
        let data: Data

        func loadData() -> Result<Data, ContentRepositoryError> {
            .success(data)
        }
    }

    private var validQuestionData: Data {
        Data(
            """
            [{
              "id": "generic-question",
              "question": "Which answer is correct?",
              "options": ["First", "Second"],
              "correctAnswerIndex": 0,
              "hint": "Choose the first answer."
            }]
            """.utf8
        )
    }

    private var invalidQuestionData: Data {
        Data(
            """
            [{
              "id": "generic-question",
              "question": "Which answer is correct?",
              "options": ["Only answer"],
              "correctAnswerIndex": 1,
              "hint": "Choose carefully."
            }]
            """.utf8
        )
    }

    private struct InMemoryStoryProgressionLoader: StoryProgressionLoading {
        let progressions: [StoryID: StoryProgression]

        func progression(for story: Story) -> StoryProgression {
            progressions[story.id] ?? .sequential(forStepCount: story.steps.count)
        }
    }

}
