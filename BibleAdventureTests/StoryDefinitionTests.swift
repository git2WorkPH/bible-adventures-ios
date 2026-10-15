import Foundation
import Testing
@testable import BibleAdventure

struct StoryDefinitionTests {
    struct Source: ContentDataLoading {
        let data: Data
        func loadData() -> Result<Data, ContentRepositoryError> { .success(data) }
    }

    private func fixture(_ id: StoryID) -> StoryDefinition {
        let reference = BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: nil)
        let objective = Objective(id: "choose", title: "Choose an item", instruction: "Synthetic test activity", hint: nil, type: .quiz, reference: reference, scripture: "", questionId: "q", storyId: id)
        return StoryDefinition(schemaVersion: 1, contentVersion: "fixture-1", story: Story(id: id, title: "Fixture \(id.rawValue)", description: "Test only", steps: [.dialogue(DialoguePage(speaker: .narrator, text: "Synthetic test content", reference: reference)), .objective(objective)]), presentation: .generic, reflection: ReflectionContent(id: "reflect", prompt: "Synthetic reflection fixture", scriptureReference: reference), scripture: [], questions: [QuizQuestion(id: "q", question: "Select one", options: ["One", "Two"], correctAnswerIndex: 0, hint: "One")])
    }

    @Test func twoDefinitionsLoadAndCompleteThroughTheSameRuntime() throws {
        for id in [StoryID.moses, .david] {
            let definition = fixture(id)
            let repository = StoryDefinitionRepository(dataSource: Source(data: try JSONEncoder().encode(definition)))
            let decoded = try repository.result.get()
            #expect(decoded.story.id == id)
            let store = LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathComponent("save.json"))
            defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
            let runtime = StoryRuntimeCoordinator(storyID: id, loader: repository, questionLookup: decoded.question(for:), reflectionContent: decoded.reflection, contentVersion: decoded.contentVersion, storage: store, presentation: decoded.presentation)
            #expect(runtime.startNew())
            #expect(!runtime.presentation.reflectionTitle.contains("Noah"))
            runtime.advanceDialogue(token: runtime.stepToken)
            runtime.submitAnswer(0)
            runtime.completeObjective(token: runtime.stepToken)
            #expect(runtime.engine.isCompleted)
            runtime.finishReflection()
            #expect(runtime.reflectionCompleted)
            #expect(runtime.resume())
        }
    }

    @Test func malformedUnknownAndUnsupportedDefinitionsRecover() throws {
        let encoded = try JSONEncoder().encode(fixture(.david))
        let original = try JSONSerialization.jsonObject(with: encoded) as! [String: Any]
        var variants = [[String: Any]]()
        var unsupported = original; unsupported["schemaVersion"] = 2; variants.append(unsupported)
        var invalidURL = original
        var presentation = invalidURL["presentation"] as! [String: Any]; presentation["readingURL"] = "https://example.com/"; invalidURL["presentation"] = presentation; variants.append(invalidURL)
        for field in ["activity", "kind"] {
            var unknown = original; var story = unknown["story"] as! [String: Any]
            story["steps"] = [["kind": field == "kind" ? "unknown" : "miniGame", "activity": "unknown"]]; unknown["story"] = story; variants.append(unknown)
        }
        var invalidReference = original; var reflection = invalidReference["reflection"] as! [String: Any]
        var reference = reflection["scriptureReference"] as! [String: Any]; reference["chapter"] = 0; reflection["scriptureReference"] = reference; invalidReference["reflection"] = reflection; variants.append(invalidReference)
        var brokenQuestions = original; brokenQuestions["questions"] = []; variants.append(brokenQuestions)
        var conflictingPayload = original; var conflictingStory = original["story"] as! [String: Any]
        var steps = conflictingStory["steps"] as! [[String: Any]]; steps[0]["activity"] = "gatherAnimals"; conflictingStory["steps"] = steps
        conflictingPayload["story"] = conflictingStory; variants.append(conflictingPayload)
        var duplicateQuestions = original; duplicateQuestions["questions"] = (original["questions"] as! [[String: Any]]) + (original["questions"] as! [[String: Any]]); variants.append(duplicateQuestions)
        for variant in variants {
            let repository = StoryDefinitionRepository(dataSource: Source(data: try JSONSerialization.data(withJSONObject: variant)))
            if case .success = repository.result { Issue.record("Invalid document accepted") }
            var engine = StoryEngine(loader: repository)
            let started = engine.start(storyID: .david)
            #expect(!started)
        }
        let malformed = StoryDefinitionRepository(dataSource: Source(data: Data("{".utf8)))
        #expect(malformed.result.failure != nil)
    }

    @Test func bundledNoahPreservesReviewedContentAndBoundaryIdentity() throws {
        let definition = try StoryCatalogue.entries[0].repository().result.get()
        let original = NoahStory.build()
        #expect(definition.story.id == original.id)
        #expect(definition.contentVersion == "noah-2")
        let encoder = JSONEncoder(); encoder.outputFormatting = [.sortedKeys]
        #expect(try encoder.encode(definition.story) == encoder.encode(original))
        #expect(definition.reflection == NoahStory.reflection)
        #expect(try definition.quotation(for: NoahStory.reference(6, 14)).get().text == NoahStory.woodScripture)
        for question in definition.questions {
            let reviewed = try NoahQuestionRepository.question(for: question.id).get()
            #expect(try encoder.encode(question) == encoder.encode(reviewed))
        }
        #expect(StoryCatalogue.entries.map(\.id) == [.noah, .david])
    }

    @Test func switchingFixturesRetainsOtherStoryProgress() throws {
        let store = LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathComponent("save.json"))
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        func runtime(_ id: StoryID) throws -> StoryRuntimeCoordinator {
            let definition = fixture(id)
            let repository = StoryDefinitionRepository(dataSource: Source(data: try JSONEncoder().encode(definition)))
            return StoryRuntimeCoordinator(storyID: id, loader: repository, questionLookup: definition.question(for:), reflectionContent: definition.reflection, contentVersion: definition.contentVersion, storage: store, presentation: definition.presentation)
        }
        let first = try runtime(.moses)
        #expect(first.startNew())
        first.advanceDialogue(token: first.stepToken)
        let second = try runtime(.david)
        #expect(second.startNew())
        let resumedFirst = try runtime(.moses)
        #expect(resumedFirst.resume())
        #expect(resumedFirst.engine.currentStepIndex == 1)
        #expect(resumedFirst.progress.story(.david)?.currentStepIndex == 0)
        #expect(resumedFirst.startNew())
        let resumedSecond = try runtime(.david)
        #expect(resumedSecond.resume())
        #expect(resumedSecond.progress.story(.moses)?.currentStepIndex == 0)
    }
}

private extension Result {
    var failure: Failure? { if case .failure(let error) = self { return error }; return nil }
}
