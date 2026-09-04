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

}
