import Foundation

struct NoahStory {
    static let contentVersion = "noah-2"
    // One complete verse. Checked against esv.org/Genesis+6/ on 2026-10-03.
    static let woodScripture = "Make yourself an ark of gopher wood. Make rooms in the ark, and cover it inside and out with pitch."

    static func reference(_ chapter: Int, _ verse: Int, _ end: Int? = nil) -> BibleReference {
        BibleReference(book: .genesis, chapter: chapter, startVerse: verse, endVerse: end)
    }

    static let reflection = ReflectionContent(
        id: "noah-reflection",
        prompt: "Read Genesis 6–9 in your Bible. Think about the violence described before the flood, Noah's response to GOD, and GOD's covenant with living creatures. What questions would you like to explore with a trusted adult?",
        scriptureReference: reference(9, 8, 17)
    )

    static func makeRuntime(storage: any ProgressDataStoring = LocalProgressStorage.application) -> StoryRuntimeCoordinator {
        var selectedStorage = storage
        #if DEBUG
        if ProcessInfo.processInfo.environment["BIBLE_ADVENTURE_UI_TEST"] == "1" {
            selectedStorage = LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent("noah-ui-progress.json"))
        }
        #endif
        return StoryRuntimeCoordinator(storyID: .noah, loader: StoryRepository(stories: [build()]),
                                questionLookup: NoahQuestionRepository.question(for:),
                                scriptureLookup: NoahScriptureRepository().scripture(for:),
                                reflectionContent: reflection, contentVersion: contentVersion, storage: selectedStorage)
    }

    private static func explanation(_ text: String, _ chapter: Int, _ verse: Int, _ end: Int? = nil) -> StoryStep {
        .dialogue(DialoguePage(speaker: .narrator, text: text, reference: reference(chapter, verse, end), kind: .interpretation))
    }

    private static func blueprintObjective(_ id: String, title: String, instruction: String) -> StoryStep {
        .objective(Objective(id: id, title: title, instruction: instruction,
                            hint: "Read Genesis 6:14–16 in your Bible, then answer the question.",
                            type: .readScripture, reference: reference(6, id == "ark_pitch" ? 14 : 16),
                            scripture: id == "ark_pitch" ? woodScripture : "", questionId: id, storyId: .noah))
    }

    static func build() -> Story {
        Story(id: .noah, title: "Noah's Ark", description: "Explore Genesis 6–9, prepare the ark, and reflect on GOD's covenant.", steps: [
            explanation("Genesis describes a world filled with violence. GOD told Noah about the coming flood and instructed him to prepare an ark. Read the account in your Bible as you explore this adventure.", 6, 9, 22),
            .dialogue(DialoguePage(speaker: .God, text: woodScripture, reference: reference(6, 14), kind: .scripture)),
            .objective(Objective(id: "ark_wood", title: "Read the ark instructions", instruction: "Read Genesis 6:14. What wood does the quoted verse name?", hint: "Use the word in the passage.", type: .readScripture, reference: reference(6, 14), scripture: woodScripture, questionId: "ark_wood", storyId: .noah)),
            explanation("The quoted text says gopher wood. Its precise identity is uncertain. The wood pictures in this activity are imagined illustrations, not an identification of the Biblical tree.", 6, 14),
            .miniGame(.woodSelection),
            explanation("The ark instructions give a length of 300 cubits, a breadth of 50 cubits and a height of 30 cubits. A cubit is a historical unit of length; this activity compares the stated dimensions.", 6, 15),
            .miniGame(.measureArk),
            blueprintObjective("ark_pitch", title: "Ark blueprint: covering", instruction: "Choose the covering specified for the ark."),
            blueprintObjective("ark_door", title: "Ark blueprint: door", instruction: "Choose the door location stated in the passage. The text does not specify left or right."),
            blueprintObjective("ark_decks", title: "Ark blueprint: decks", instruction: "Choose the number of decks described in Genesis 6:16."),
            explanation("The passage describes rooms, a roof, a side door and three decks. Assemble the illustrated pieces in the construction puzzle. These shapes are a game representation, not a historical blueprint.", 6, 14, 16),
            .miniGame(.buildArk),
            explanation("Genesis records Noah carrying out GOD's instructions. It also describes gathering food for the people and animals. The pictured foods are game examples, not a Biblical food list.", 6, 21, 22),
            .miniGame(.gatherFood),
            explanation("Genesis 7 distinguishes seven pairs of clean animals and birds from a pair of animals that are not clean. The matching game shows example pairs and does not represent the complete animal count or identify every Biblical kind.", 7, 2, 3),
            .miniGame(.gatherAnimals),
            explanation("Noah entered with his wife, his three sons and their wives. The clothing and faces in this game are imagined. Read Genesis 7 to see who entered and what happened next.", 7, 7, 16),
            .miniGame(.enterArk),
            explanation("The account describes the LORD shutting Noah in, forty days and nights of rain, and waters prevailing for 150 days. Game stages condense the account; they are not a day-by-day timeline.", 7, 16, 24),
            .miniGame(.floodJourney),
            explanation("Genesis says GOD remembered Noah and the animals. A wind blew and the waters subsided. Noah sent a raven before the dove; the next activity focuses on the dove's three journeys.", 8, 1, 12),
            .miniGame(.sendDove),
            explanation("After leaving the ark, Noah built an altar. Read Genesis 8:18–22 and consider how Noah responded. The story continues with GOD's covenant.", 8, 18, 22),
            explanation("GOD's covenant concerns living creatures and the promise about a flood destroying all flesh. The bow in the clouds is its sign. This color-building activity illustrates a rainbow; Scripture does not give a required color order.", 9, 8, 17),
            .miniGame(.buildRainbow),
            explanation("Return to Genesis 6–9 in your Bible. Consider GOD's judgment, Noah's response, and the covenant. Completing activities is an opportunity to reflect and keep reading.", 9, 8, 17)
        ])
    }
}
