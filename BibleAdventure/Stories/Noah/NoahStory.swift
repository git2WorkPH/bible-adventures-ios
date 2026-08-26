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
                        text: "And God said to Noah, l“I have determined to make an end of all flesh,3 for the earth is filled with violence through them. Behold, I will destroy them with the earth.",
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
                            instruction: "Read Genesis 6:9 - 8:22 before continuing. (ESV)",
                            hint: "Answer the question after reading.",
                            type: .readScripture,
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 6,
                                startVerse: 13,
                                endVerse: nil
                            ),

                            scripture: """
                    And God said to Noah, l“I have determined to make an end of all flesh,3 for the earth is filled with violence through them. Behold, I will destroy them with the earth.
                    """,

                            questionId: "listen_to_god", storyId: .noah
                        )
                ),
                
                .dialogue(
                    DialoguePage(
                        speaker: .God,
                        text: "Make yourself an ark of gopher wood.4 Make rooms in the ark, and cover it inside and out with pitch.",
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
                        text: "This is how you are to make it: the length of the ark 300 cubits,5 its breadth 50 cubits, and its height 30 cubits.",
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
                            text: "Build an ark using gopher (cypress) wood.",
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
                        text: "Noah did this; he did all that God commanded him.",
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
                            text: "Noah did this; he did all that God commanded him.",
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
                            text: "Also take with you every sort of food that is eaten, and store it up. It shall serve as food for you and for them.",
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
                            text: "Take with you seven pairs of all rclean animals,1 the male and his mate, and a pair of the animals that are not clean, the male and his mate, 3 and seven pairs2 of the birds of the heavens also, male and female, to keep their offspring alive on the face of all the earth. ",
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
                            text: "Then the Lord said to Noah, p“Go into the ark, you and all your household, for I have seen that qyou are righteous before me in this generation. ",
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
                            text: "But God dremembered Noah and all the beasts and all the livestock that were with him in the ark. And eGod made a wind blow over the earth, and the waters subsided.",
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
                            text: " I have set cmy bow in the cloud, and it shall be a sign of the covenant between me and the earth.",
                            reference: BibleReference(
                                book: .genesis,
                                chapter: 9,
                                startVerse: 13,
                                endVerse: nil
                            )
                        )
                    ),

                    .miniGame(.buildRainbow),

                    .dialogue(
                        DialoguePage(
                            speaker: .narrator,
                            text: "When the bow is in the clouds, I will see it and remember ethe everlasting covenant between God and every living creature of all flesh that is on the earth.” God said to Noah, “This is the sign of the covenant that I have established between me and all flesh that is on the earth.”",
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
