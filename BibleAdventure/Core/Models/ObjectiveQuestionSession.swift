import Foundation

struct LearningFeedback: Equatable {
    enum Kind { case correct, incorrect }
    let kind: Kind
    let explanation: String
    let reference: BibleReference
}

struct ObjectiveCompletion: Equatable {
    let objectiveID: String
    let questionID: String
    let reference: BibleReference
    var outcome: StoryActivityOutcome { .success }
}

/// Domain lifecycle for one question-backed objective. Presentation consumes
/// values; a coordinator forwards the completion report to the Story Engine.
struct ObjectiveQuestionSession {
    struct Answer: Identifiable, Equatable {
        /// Original option index, preserved independently of display order.
        let id: Int
        let text: String
    }

    enum Status: Equatable { case inactive, answering, incorrect, completed }

    let objectiveID: String
    let questionID: String
    let prompt: String
    let hint: String
    let reference: BibleReference
    let answers: [Answer]
    private let correctAnswerID: Int
    private let correctExplanation: String
    private let incorrectExplanation: String
    private(set) var status: Status = .inactive
    private(set) var feedback: LearningFeedback?
    private(set) var selectedAnswerID: Int?
    private var completionReported = false

    var objectiveState: ObjectiveState {
        let state: ObjectiveState.Status
        switch status {
        case .inactive: state = .inactive
        case .answering, .incorrect: state = .active
        case .completed: state = .completed
        }
        return ObjectiveState(objectiveID: objectiveID, status: state)
    }

    init?<R: RandomNumberGenerator>(
        objectiveID: String, question: QuizQuestion, reference: BibleReference,
        correctExplanation: String, incorrectExplanation: String,
        using generator: inout R
    ) {
        guard !objectiveID.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty,
              !question.id.isEmpty, !question.question.isEmpty,
              question.options.count >= 2,
              question.options.allSatisfy({ !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }),
              question.options.indices.contains(question.correctAnswerIndex),
              !correctExplanation.isEmpty, !incorrectExplanation.isEmpty,
              reference.chapter > 0, reference.startVerse > 0,
              reference.endVerse.map({ $0 >= reference.startVerse }) ?? true
        else { return nil }
        self.objectiveID = objectiveID
        questionID = question.id
        prompt = question.question
        hint = question.hint
        self.reference = reference
        correctAnswerID = question.correctAnswerIndex
        self.correctExplanation = correctExplanation
        self.incorrectExplanation = incorrectExplanation
        answers = question.options.enumerated().map {
            Answer(id: $0.offset, text: $0.element)
        }.shuffled(using: &generator)
    }

    init?(
        objectiveID: String, question: QuizQuestion, reference: BibleReference,
        correctExplanation: String, incorrectExplanation: String
    ) {
        var generator = SystemRandomNumberGenerator()
        self.init(objectiveID: objectiveID, question: question, reference: reference,
                  correctExplanation: correctExplanation,
                  incorrectExplanation: incorrectExplanation, using: &generator)
    }

    @discardableResult
    mutating func start() -> Bool {
        guard status == .inactive else { return false }
        status = .answering
        return true
    }

    @discardableResult
    mutating func submit(answerID: Int) -> Bool {
        guard status == .answering, answers.contains(where: { $0.id == answerID }) else {
            return false
        }
        selectedAnswerID = answerID
        let correct = answerID == correctAnswerID
        status = correct ? .completed : .incorrect
        feedback = LearningFeedback(kind: correct ? .correct : .incorrect,
                                    explanation: correct ? correctExplanation : incorrectExplanation,
                                    reference: reference)
        return true
    }

    /// A wrong attempt leaves the objective active; retry clears only attempt
    /// state, preserving answer order, identity, hints and reference.
    @discardableResult
    mutating func retry() -> Bool {
        guard status == .incorrect else { return false }
        status = .answering
        feedback = nil
        selectedAnswerID = nil
        return true
    }

    mutating func takeCompletion() -> ObjectiveCompletion? {
        guard status == .completed, !completionReported else { return nil }
        completionReported = true
        return ObjectiveCompletion(objectiveID: objectiveID, questionID: questionID,
                                   reference: reference)
    }
}
