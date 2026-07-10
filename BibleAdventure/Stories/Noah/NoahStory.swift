import Foundation

struct NoahStory {

    static func build() -> Story {

        Story(
            id: .noah,
            title: "Noah's Ark",
            description: "Build the ark before the rain begins.",
            steps: [

                .dialogue(
                    DialoguePage(
                        speaker: .God,
                        text: "I have decided to put an end to all people, for the earth is filled with violence because of them. I am surely going to destroy both them and the earth.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 6,
                            startVerse: 13,
                            endVerse: nil
                        )
                    )
                ),
                            
                .objective(
                        Objective(
                            id: "listen_to_god",
                            title: "Listen to GOD",
                            instruction: "Read Genesis 6:13 before continuing.",
                            hint: "Answer the question after reading.",
                            type: .readScripture,
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 13,
                                endVerse: nil
                            ),

                            scripture: """
                    So God said to Noah, “I am going to put an end to all people, for the earth is filled with violence because of them. I am surely going to destroy both them and the earth.
                    """,

                            questionId: "listen_to_god", storyId: .noah
                        )
                ),
                
                .dialogue(
                    DialoguePage(
                        speaker: .God,
                        text: "So make yourself an ark of cypress wood; make rooms in it and coat it with pitch inside and out.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 6,
                            startVerse: 14,
                            endVerse: nil
                        )
                    )
                ),
                
                .dialogue(
                    DialoguePage(
                        speaker: .God,
                        text: "This is how you are to build it: The ark is to be three hundred cubits long, fifty cubits wide and thirty cubits high.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 6,
                            startVerse: 15,
                            endVerse: nil
                        )
                    )
                ),

                    .miniGame(.woodSelection),
//
//                .dialogue(
//                    DialoguePage(
//                        speaker: .narrator,
//                        text: "Noah did everything just as GOD commanded him.",
//                        reference: BibleReference(
//                            book: .genesis,
//                            chapter: 6,
//                            startVerse: 22,
//                            endVerse: nil
//                        )
//                    )
//                ),
                
//                .dialogue(
//                        DialoguePage(
//                            speaker: .God,
//                            text: "Build an ark using cypress wood.",
//                            reference: BibleReference(
//                                book: .genesis,
//                                chapter: 6,
//                                startVerse: 14,
//                                endVerse: nil
//                            )
//                        )
//                    ),



                .dialogue(
                        DialoguePage(
                            speaker: .noah,
                            text: "I found the wood and will begin building.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 22,
                                endVerse: nil
                        )
                    )
                )
            ]
        )
    }
}
