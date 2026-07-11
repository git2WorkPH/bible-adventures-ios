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

                
                .dialogue(
                        DialoguePage(
                            speaker: .God,
                            text: "Build an ark using cypress wood.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 14,
                                endVerse: nil
                            )
                        )
                    ),



                .miniGame(.measureArk),
                
                .dialogue(
                    DialoguePage(
                        speaker: .narrator,
                        text: "Noah did everything just as GOD commanded him.",
                        reference: BibleReference(
                            book: .genesis,
                            chapter: 6,
                            startVerse: 22,
                            endVerse: nil
                        )
                    )
                ),
                
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
                ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .noah,
                            text: "We have the wood and the measurements GOD gave me. Now it is time to build the ark.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 22,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.buildArk),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Noah did everything just as GOD commanded him.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 22,
                                endVerse: nil
                            )
                        )
                    ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .God,
                            text: "You are to take every kind of food that is to be eaten and store it away as food for you and for them.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 21,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.gatherFood),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "The food was gathered and stored. Noah continued preparing for what GOD had told him.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 21,
                                endVerse: nil
                            )
                        )
                    ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .God,
                            text: "You are to bring into the ark the animals GOD instructed Noah to take.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 2,
                                endVerse: 3
                            )
                        )
                    ),

                    .dialogue(
                        DialoguePage(
                            speaker: .noah,
                            text: "The ark is ready and the food is stored. Help me gather the animals.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 7,
                                endVerse: 9
                            )
                        )
                    ),

                    .miniGame(.gatherAnimals),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "The animals came to Noah and entered the ark.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 8,
                                endVerse: 9
                            )
                        )
                    ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .God,
                            text: "Go into the ark, you and your whole family.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 1,
                                endVerse: nil
                            )
                        )
                    ),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Noah and his family prepared to enter the ark.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 13,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.enterArk),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Then GOD shut Noah in. The rain began to fall upon the earth.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 7,
                                startVerse: 16,
                                endVerse: 17
                            )
                        )
                    ),
            
                    .miniGame(.floodJourney),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "But GOD remembered Noah and all the animals that were with him in the ark.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 1,
                                endVerse: nil
                            )
                        )
                    ),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "GOD sent a wind over the earth, and the waters began to recede.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 1,
                                endVerse: 3
                            )
                        )
                    ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Noah sent out a dove to see if the water had receded from the surface of the ground.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 8,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.sendDove),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Noah knew that the water had receded from the earth.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 11,
                                endVerse: 12
                            )
                        )
                    ),
                
                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Noah came out of the ark with his family and the animals.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 18,
                                endVerse: 19
                            )
                        )
                    ),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "Then Noah built an altar to GOD.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 8,
                                startVerse: 20,
                                endVerse: nil
                            )
                        )
                    ),

                    .dialogue(
                        DialoguePage(
                            speaker: .God,
                            text: "I have set my rainbow in the clouds as the sign of the covenant.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 9,
                                startVerse: 13,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.buildRainbow),
                
                    .miniGame(.rainbowCovenant),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "The rainbow was the sign of the covenant GOD established with Noah and every living creature.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 9,
                                startVerse: 16,
                                endVerse: 17
                            )
                        )
                    )
            ]
        )
    }
}
