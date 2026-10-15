import Foundation
import Testing
@testable import BibleAdventure

struct DavidStoryTests {
    private func storage() -> LocalProgressStorage {
        LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathComponent("progress.json"))
    }

    private func definition() throws -> StoryDefinition {
        let entry = try #require(StoryCatalogue.entry(for: .david))
        return try entry.repository().result.get()
    }

    private func advance(_ runtime: StoryRuntimeCoordinator, definition: StoryDefinition) throws {
        switch runtime.engine.currentStep {
        case .dialogue:
            runtime.advanceDialogue(token: runtime.stepToken)
        case .objective(let objective):
            let question = try definition.question(for: objective.questionId).get()
            runtime.submitAnswer(question.correctAnswerIndex)
            runtime.completeObjective(token: runtime.stepToken)
        case .miniGame:
            runtime.receiveGame(.completed, attempt: try #require(runtime.miniGame?.attemptID))
        case .none:
            Issue.record("Expected an active David step")
        }
    }

    @Test func davidDefinitionCompletesReflectsAndRestores() throws {
        let definition = try definition()
        #expect(definition.contentVersion == "david-1")
        #expect(definition.story.steps.count == 10)
        #expect(definition.scripture.isEmpty)
        #expect(definition.story.steps.allSatisfy { step in
            if case .dialogue(let page) = step { return page.kind == .interpretation }
            return true
        })
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let entry = try #require(StoryCatalogue.entry(for: .david))
        let runtime = entry.makeRuntime(storage: store)
        #expect(runtime.startNew())
        for index in definition.story.steps.indices {
            #expect(runtime.engine.currentStepIndex == index)
            try advance(runtime, definition: definition)
            #expect(runtime.error == nil)
        }
        #expect(runtime.engine.isCompleted)
        #expect(runtime.reflectionPresentation?.scriptureReference == BibleReference(book: .firstSamuel, chapter: 17, startVerse: 45, endVerse: 47))
        runtime.finishReflection()
        let relaunched = entry.makeRuntime(storage: store)
        #expect(relaunched.resume())
        #expect(relaunched.engine.isCompleted)
        #expect(relaunched.reflectionCompleted)
    }

    @Test func davidMatchingConfigurationAndNoahProgressAreIndependent() throws {
        let davidConfiguration = StoryActivityConfiguration.matchingPresentation(for: .david, activity: .gatherProvisions)
        #expect(davidConfiguration?.items.map(\.id) == ["grain", "bread", "cheese"])
        #expect(StoryActivityConfiguration.matchingPresentation(for: .david, activity: .gatherAnimals) == nil)
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let noah = NoahStory.makeRuntime(storage: store)
        #expect(noah.startNew())
        noah.advanceDialogue(token: noah.stepToken)
        let davidEntry = try #require(StoryCatalogue.entry(for: .david))
        let david = davidEntry.makeRuntime(storage: store)
        #expect(david.startNew())
        let restoredNoah = NoahStory.makeRuntime(storage: store)
        #expect(restoredNoah.resume())
        #expect(restoredNoah.engine.currentStepIndex == 1)
        #expect(restoredNoah.progress.story(.david)?.currentStepIndex == 0)
    }

    @Test func davidDefinitionRejectsAnActivityWithoutDavidConfiguration() throws {
        let encoded = try JSONEncoder().encode(try definition())
        var document = try JSONSerialization.jsonObject(with: encoded) as! [String: Any]
        var story = document["story"] as! [String: Any]
        var steps = story["steps"] as! [[String: Any]]
        steps[1]["activity"] = "gatherAnimals"
        story["steps"] = steps
        document["story"] = story
        let source = StoryDefinitionTests.Source(data: try JSONSerialization.data(withJSONObject: document))
        let repository = StoryDefinitionRepository(dataSource: source)
        if case .success = repository.result { Issue.record("David accepted a Noah-only matching activity") }
    }
}
