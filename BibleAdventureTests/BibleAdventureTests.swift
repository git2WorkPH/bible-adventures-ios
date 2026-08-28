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
