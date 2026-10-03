import Foundation
import Observation

/// One presentation-neutral owner of the engine and current activity lifecycle.
@Observable
final class StoryRuntimeCoordinator {
    private(set) var engine: StoryEngine
    private(set) var questionSession: ObjectiveQuestionSession?
    private(set) var scripture: ScriptureContent?
    private(set) var miniGame: MiniGameAdapter?
    private(set) var reflection: ReflectionSession?
    private(set) var reflectionPresentation: ReflectionPresentation?
    private(set) var reflectionCompleted = false
    private(set) var progress = PlayerProgress()
    private(set) var error: UserFacingError?
    private(set) var saveError: UserFacingError?
    private(set) var saveFailed = false
    private(set) var recoveryRequired = false
    private(set) var stepToken = UUID()
    private var completedObjectives: [ObjectiveProgress] = []
    private let loader: any StoryLoading
    private let questionLookup: (String) -> Result<QuizQuestion, ContentRepositoryError>
    private let scriptureLookup: (BibleReference) -> Result<ScriptureContent, ContentRepositoryError>
    private let reflectionContent: ReflectionContent
    private let contentVersion: String
    private let storyID: StoryID
    private let persistence: ProgressPersistenceService
    private let logger: FoundationLogger

    init(storyID: StoryID, loader: any StoryLoading,
         questionLookup: @escaping (String) -> Result<QuizQuestion, ContentRepositoryError>,
         scriptureLookup: @escaping (BibleReference) -> Result<ScriptureContent, ContentRepositoryError> = { _ in .failure(.itemNotFound("scripture")) },
         reflectionContent: ReflectionContent, contentVersion: String,
         storage: any ProgressDataStoring,
         logger: FoundationLogger = FoundationLogger(mode: .production, writer: SystemLogWriter())) {
        self.storyID = storyID
        self.loader = loader
        self.questionLookup = questionLookup
        self.scriptureLookup = scriptureLookup
        self.reflectionContent = reflectionContent
        self.contentVersion = contentVersion
        self.persistence = ProgressPersistenceService(storage: storage)
        self.logger = logger
        engine = StoryEngine(loader: loader)
        let result = persistence.restore()
        progress = result.progress
        if case .recovered = result {
            recoveryRequired = true
            error = UserFacingError(title: "Saved adventure unavailable", message: "Your saved adventure could not be read. Start a new adventure when you are ready.", actions: [])
        }
    }

    var canResume: Bool { !recoveryRequired && progress.story(storyID) != nil }

    @discardableResult
    func startNew() -> Bool {
        engine = StoryEngine(loader: loader)
        guard engine.start(storyID: storyID) else {
            report(.temporarilyUnavailable, operation: .storyStart)
            return false
        }
        recoveryRequired = false
        error = nil
        completedObjectives = []
        reflectionCompleted = false
        prepareStep()
        save()
        return true
    }

    @discardableResult
    func resume() -> Bool {
        guard canResume, let snapshot = progress.story(storyID),
              snapshot.contentVersion == contentVersion,
              case .success(let story) = loader.story(for: storyID) else {
            recoverSave()
            return false
        }
        let objectiveIDs = Set(story.steps.compactMap { step -> String? in
            if case .objective(let objective) = step { return objective.id }; return nil
        })
        let boundary = snapshot.status == .completed ? story.steps.count : (snapshot.currentStepIndex ?? -1)
        let priorObjectives = Set(story.steps.prefix(max(0, boundary)).compactMap { step -> String? in
            if case .objective(let objective) = step { return objective.id }; return nil
        })
        guard Set(snapshot.objectives.map(\.objectiveID)) == priorObjectives,
              snapshot.objectives.allSatisfy({ objectiveIDs.contains($0.objectiveID) && $0.status == .completed }) else {
            recoverSave(); return false
        }
        var restored = StoryEngine(loader: loader)
        guard restored.restore(snapshot) else { recoverSave(); return false }
        engine = restored
        error = nil
        completedObjectives = snapshot.objectives
        reflectionCompleted = snapshot.reflectionCompleted == true
        prepareStep()
        return true
    }

    func advanceDialogue(token: UUID) {
        guard token == stepToken, case .dialogue = engine.currentStep else { return }
        accept(engine.apply(outcome: .success))
    }

    func submitAnswer(_ id: Int) {
        guard var session = questionSession else { return }
        _ = session.submit(answerID: id)
        questionSession = session
        engine.setActivityStates(objective: session.objectiveState)
    }

    func retryAnswer() {
        guard var session = questionSession else { return }
        _ = session.retry()
        questionSession = session
        engine.setActivityStates(objective: session.objectiveState)
    }

    func completeObjective(token: UUID) {
        guard token == stepToken, var session = questionSession,
              let completion = session.takeCompletion() else { return }
        questionSession = session
        engine.setActivityStates(objective: session.objectiveState)
        let result = engine.apply(outcome: completion.outcome)
        guard result != .rejected else { report(.gameplay(.rejectedOutcome), operation: .activityResult); return }
        completedObjectives.append(ObjectiveProgress(objectiveID: completion.objectiveID, status: .completed))
        accept(result)
    }

    func receiveGame(_ result: MiniGameResult, attempt: UUID) {
        guard var adapter = miniGame, adapter.attemptID == attempt else { return }
        let progression = adapter.receive(result, attempt: attempt)
        miniGame = adapter
        engine = adapter.engine
        if result == .failed && progression == .rejected { return }
        accept(progression)
    }

    func retryGame() {
        guard var adapter = miniGame else { return }
        guard adapter.retry() != nil else { return }
        miniGame = adapter
        engine = adapter.engine
        stepToken = UUID()
    }

    func finishReflection() {
        guard var session = reflection, session.complete() else { return }
        reflection = session
        reflectionCompleted = true
        save()
    }

    func retryCurrentContent() { error = nil; prepareStep() }

    func save() {
        guard !recoveryRequired, let story = engine.currentStory else { return }
        let snapshot = StoryProgress(storyID: story.id, currentStepIndex: engine.currentStepIndex,
                                     status: engine.isCompleted ? .completed : .active,
                                     objectives: completedObjectives, contentVersion: contentVersion,
                                     reflectionCompleted: reflectionCompleted)
        progress = PlayerProgress(stories: progress.stories.filter { $0.storyID != story.id } + [snapshot])
        if case .failure = persistence.save(progress) {
            saveFailed = true
            saveError = ApplicationError.temporarilyUnavailable.userFacingError
            logger.record(.temporarilyUnavailable, operation: .activityResult, context: LogContext(storyID: storyID))
        } else {
            saveError = nil
            saveFailed = false
        }
    }

    private func accept(_ result: StoryProgressionResult) {
        guard result != .rejected else { report(.gameplay(.rejectedOutcome), operation: .activityResult); return }
        prepareStep()
        save()
    }

    private func prepareStep() {
        engine.setActivityStates()
        stepToken = UUID()
        questionSession = nil
        scripture = nil
        miniGame = nil
        reflection = nil
        reflectionPresentation = nil
        if engine.isCompleted {
            if !reflectionCompleted, var session = ReflectionSession.afterStoryCompletion(engine: engine, content: reflectionContent) {
                reflectionPresentation = session.start()
                reflection = session
            }
            return
        }
        switch engine.currentStep {
        case .objective(let objective):
            if !objective.scripture.isEmpty {
                switch scriptureLookup(objective.reference) {
                case .success(let content): scripture = content
                case .failure(let failure): report(.content(failure), operation: .contentLoad); return
                }
            }
            switch questionLookup(objective.questionId) {
            case .failure(let failure): report(.content(failure), operation: .contentLoad)
            case .success(let question):
                guard var session = ObjectiveQuestionSession(objectiveID: objective.id, question: question,
                    reference: objective.reference,
                    correctExplanation: "Correct. Read \(objective.reference.displayText) to see the Biblical source.",
                    incorrectExplanation: "Read \(objective.reference.displayText) again, then try another answer.") else {
                    report(.gameplay(.invalidConfiguration), operation: .contentLoad); return
                }
                _ = session.start()
                questionSession = session
                engine.setActivityStates(objective: session.objectiveState)
            }
        case .miniGame(let type):
            var adapter = MiniGameAdapter(configuration: MiniGameConfiguration(id: type.rawValue, allowsRetry: true), engine: engine)
            guard adapter.start() != nil else { report(.gameplay(.invalidState), operation: .activityResult); return }
            miniGame = adapter
            engine = adapter.engine
        case .dialogue, .none: break
        }
    }

    private func recoverSave() {
        recoveryRequired = true
        error = UserFacingError(title: "Saved adventure unavailable", message: "This save belongs to a different story version or has invalid progress. Start a new adventure to continue.", actions: [])
    }

    private func report(_ failure: ApplicationError, operation: LogOperation) {
        logger.record(failure, operation: operation, context: LogContext(storyID: storyID))
        error = failure.userFacingError
    }
}
