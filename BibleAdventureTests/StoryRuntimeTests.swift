import Foundation
import Testing
@testable import BibleAdventure

struct StoryRuntimeTests {
    private func storage() -> LocalProgressStorage {
        LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent(UUID().uuidString).appendingPathComponent("progress.json"))
    }

    private func advance(_ runtime: StoryRuntimeCoordinator) throws {
        switch runtime.engine.currentStep {
        case .dialogue: runtime.advanceDialogue(token: runtime.stepToken)
        case .objective(let objective):
            let question = try NoahQuestionRepository.question(for: objective.questionId).get()
            runtime.submitAnswer(question.correctAnswerIndex)
            runtime.completeObjective(token: runtime.stepToken)
        case .miniGame:
            runtime.receiveGame(.completed, attempt: try #require(runtime.miniGame?.attemptID))
        case .none: Issue.record("Expected active step")
        }
    }

    @Test func entireNoahConfigurationCompletesAndReflectsWithRealRepositories() throws {
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let runtime = NoahStory.makeRuntime(storage: store)
        #expect(runtime.startNew())
        #expect(runtime.reflection == nil)
        for index in NoahStory.build().steps.indices {
            #expect(runtime.engine.currentStepIndex == index)
            try advance(runtime)
            #expect(runtime.error == nil)
        }
        #expect(runtime.engine.isCompleted)
        #expect(runtime.reflection?.status == .active)
        #expect(runtime.reflectionPresentation?.godCenteredQuestion.contains("GOD") == true)
        runtime.finishReflection()
        runtime.finishReflection()
        #expect(runtime.reflectionCompleted)
        let relaunched = NoahStory.makeRuntime(storage: store)
        #expect(relaunched.resume())
        #expect(relaunched.engine.isCompleted)
        #expect(relaunched.reflectionCompleted)
        #expect(relaunched.reflection == nil)
    }

    @Test func relaunchRestoresBoundaryAndRejectsStaleCallbacks() throws {
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let runtime = NoahStory.makeRuntime(storage: store)
        #expect(runtime.startNew())
        let oldToken = runtime.stepToken
        runtime.advanceDialogue(token: oldToken)
        runtime.advanceDialogue(token: oldToken)
        #expect(runtime.engine.currentStepIndex == 1)
        try advance(runtime)
        let relaunched = NoahStory.makeRuntime(storage: store)
        #expect(relaunched.resume())
        #expect(relaunched.engine.currentStepIndex == 2)
        #expect(relaunched.questionSession?.status == .answering)
        relaunched.submitAnswer(0)
        #expect(relaunched.questionSession?.status == .incorrect)
        relaunched.retryAnswer()
        #expect(relaunched.questionSession?.status == .answering)
        try advance(relaunched)
        try advance(relaunched)
        let attempt = try #require(relaunched.miniGame?.attemptID)
        relaunched.receiveGame(.failed, attempt: attempt)
        #expect(relaunched.engine.currentStepIndex == 4)
        relaunched.retryGame()
        let fresh = try #require(relaunched.miniGame?.attemptID)
        #expect(fresh != attempt)
        relaunched.receiveGame(.completed, attempt: attempt)
        #expect(relaunched.engine.currentStepIndex == 4)
        relaunched.receiveGame(.completed, attempt: fresh)
        relaunched.receiveGame(.completed, attempt: fresh)
        #expect(relaunched.engine.currentStepIndex == 5)
        #expect(relaunched.startNew())
        #expect(relaunched.engine.currentStepIndex == 0)
        #expect(relaunched.progress.story(.noah)?.objectives.isEmpty == true)
    }

    @Test func damagedAndOutdatedSavesRemainUntilExplicitNewAdventure() throws {
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        _ = store.save(Data("broken".utf8))
        let broken = NoahStory.makeRuntime(storage: store)
        #expect(broken.recoveryRequired)
        broken.save()
        #expect(try store.load().get() == Data("broken".utf8))
        #expect(broken.startNew())
        let invalid = StoryProgress(storyID: .noah, currentStepIndex: 999, status: .active,
                                    objectives: [], contentVersion: NoahStory.contentVersion)
        _ = ProgressPersistenceService(storage: store).save(PlayerProgress(stories: [invalid]))
        let outOfRange = NoahStory.makeRuntime(storage: store)
        #expect(!outOfRange.resume())
        #expect(outOfRange.recoveryRequired)
        let outdated = StoryProgress(storyID: .noah, currentStepIndex: 0, status: .active,
                                     objectives: [], contentVersion: "old")
        _ = ProgressPersistenceService(storage: store).save(PlayerProgress(stories: [outdated]))
        let old = NoahStory.makeRuntime(storage: store)
        #expect(!old.resume())
        #expect(old.recoveryRequired)
    }

    @Test func pendingReflectionResumesAndWriteFailureIsVisible() throws {
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let runtime = NoahStory.makeRuntime(storage: store)
        #expect(runtime.startNew())
        for _ in NoahStory.build().steps { try advance(runtime) }
        let relaunched = NoahStory.makeRuntime(storage: store)
        #expect(relaunched.resume())
        #expect(relaunched.reflection?.status == .active)
        struct FailingStore: ProgressDataStoring {
            func load() -> Result<Data?, ProgressStorageError> { .success(nil) }
            func save(_ data: Data) -> Result<Void, ProgressStorageError> { .failure(.writeFailed) }
        }
        let failed = NoahStory.makeRuntime(storage: FailingStore())
        #expect(failed.startNew())
        #expect(failed.saveFailed)
        #expect(failed.saveError != nil)
        #expect(failed.engine.currentStep != nil)
    }

    @Test func noahContentUsesOnlyReviewedQuotationAndPolicySafeQuestions() throws {
        let story = NoahStory.build()
        for step in story.steps {
            if case .dialogue(let page) = step {
                #expect(!page.text.lowercased().contains("cypress"))
                if page.kind == .scripture {
                    #expect(page.text == NoahStory.woodScripture)
                    #expect(page.reference == NoahStory.reference(6, 14))
                }
            }
        }
        let wood = try NoahQuestionRepository.question(for: "ark_wood").get()
        #expect(wood.options[wood.correctAnswerIndex] == "Gopher wood")
        let door = try NoahQuestionRepository.question(for: "ark_door").get()
        #expect(door.options[door.correctAnswerIndex] == "In its side")
    }

    @Test func genericCoordinatorHandlesUnavailableQuestionAndReloadWithoutNoahRules() {
        let reference = BibleReference(book: .exodus, chapter: 1, startVerse: 1, endVerse: nil)
        let objective = Objective(id: "generic", title: "Read", instruction: "Read the source", hint: nil,
                                  type: .readScripture, reference: reference, scripture: "", questionId: "generic", storyId: .moses)
        let story = Story(id: .moses, title: "Generic", description: "Fixture", steps: [.objective(objective)])
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        var available = false
        let runtime = StoryRuntimeCoordinator(storyID: .moses, loader: StoryRepository(stories: [story]),
            questionLookup: { _ in
                if available { return .success(QuizQuestion(id: "generic", question: "Choose", options: ["One", "Two"], correctAnswerIndex: 0, hint: "Read")) }
                return .failure(.missingResource("fixture"))
            }, reflectionContent: ReflectionContent(id: "generic", prompt: "Reflect", scriptureReference: reference),
            contentVersion: "1", storage: store)
        #expect(runtime.startNew())
        #expect(runtime.error?.title == "Content unavailable")
        #expect(runtime.engine.currentStepIndex == 0)
        available = true
        runtime.retryCurrentContent()
        #expect(runtime.error == nil)
        runtime.submitAnswer(0)
        runtime.completeObjective(token: runtime.stepToken)
        #expect(runtime.engine.isCompleted)
        #expect(runtime.reflectionPresentation?.scriptureReference == reference)
    }

    @Test func forgedObjectiveCompletionAndEarlyReflectionAreRejectedOnRestore() {
        let store = storage()
        defer { try? FileManager.default.removeItem(at: store.url.deletingLastPathComponent()) }
        let snapshot = StoryProgress(storyID: .noah, currentStepIndex: 0, status: .active,
            objectives: [ObjectiveProgress(objectiveID: "ark_wood", status: .completed)], contentVersion: NoahStory.contentVersion)
        _ = ProgressPersistenceService(storage: store).save(PlayerProgress(stories: [snapshot]))
        let runtime = NoahStory.makeRuntime(storage: store)
        #expect(!runtime.resume())
        #expect(runtime.recoveryRequired)
        let invalid = StoryProgress(storyID: .noah, currentStepIndex: 0, status: .active,
                                   objectives: [], contentVersion: NoahStory.contentVersion, reflectionCompleted: true)
        let result = ProgressPersistenceService(storage: store).save(PlayerProgress(stories: [invalid]))
        if case .success = result { Issue.record("Early reflection must not be saved") }
    }

    @Test func storageFailureDoesNotHideContentRecovery() {
        struct FailingStore: ProgressDataStoring {
            func load() -> Result<Data?, ProgressStorageError> { .success(nil) }
            func save(_ data: Data) -> Result<Void, ProgressStorageError> { .failure(.writeFailed) }
        }
        let reference = NoahStory.reference(6, 14)
        let objective = Objective(id: "fixture", title: "Read", instruction: "Read", hint: nil,
                                  type: .readScripture, reference: reference, scripture: "", questionId: "fixture", storyId: .noah)
        let story = Story(id: .noah, title: "Fixture", description: "Recovery", steps: [.objective(objective)])
        var available = false
        let runtime = StoryRuntimeCoordinator(storyID: .noah, loader: StoryRepository(stories: [story]),
            questionLookup: { _ in
                available ? .success(QuizQuestion(id: "fixture", question: "Choose", options: ["One", "Two"], correctAnswerIndex: 0, hint: "Read")) : .failure(.missingResource("fixture"))
            }, reflectionContent: ReflectionContent(id: "fixture", prompt: "Reflect", scriptureReference: reference),
            contentVersion: "1", storage: FailingStore())
        #expect(runtime.startNew())
        #expect(runtime.error?.title == "Content unavailable")
        #expect(runtime.saveError != nil)
        runtime.save()
        #expect(runtime.error?.title == "Content unavailable")
        available = true
        runtime.retryCurrentContent()
        #expect(runtime.error == nil)
        #expect(runtime.questionSession?.status == .answering)
        #expect(runtime.saveFailed)
    }
}
