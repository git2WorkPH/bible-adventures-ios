import Foundation

struct StoryEngine {

    static let noah = Story(
        id: "noah",
        title: "Noah's Ark",
        description: "Build the ark before the rain begins.",

        dialoguePages: [

            DialoguePage(
                speaker: "God",
                text: "I have decided to put an end to all people, for the earth is filled with violence.",
                reference: "Genesis 6:13"
            ),

            DialoguePage(
                speaker: "God",
                text: "Build an ark using cypress wood and cover it inside and out with pitch.",
                reference: "Based on Genesis 6:14"
            ),

            DialoguePage(
                speaker: "God",
                text: "The ark should have lower, middle, and upper decks.",
                reference: "Based on Genesis 6:16"
            ),

            DialoguePage(
                speaker: "Narrator",
                text: "Noah obeyed and did everything just as God commanded him.",
                reference: "Genesis 6:22"
            )
        ]
    )

}
