import Testing
@testable import BibleAdventure

struct ObjectiveQuestionSessionTests {
    let reference = BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: 2)
    // Duplicate labels deliberately prove correctness depends on identity.
    let question = QuizQuestion(id: "fixture", question: "Choose the designated option",
                                options: ["Same", "Same", "Other"], correctAnswerIndex: 1,
                                hint: "Use the supplied reference.")

    struct Generator: RandomNumberGenerator {
        var seed: UInt64
        mutating func next() -> UInt64 {
            seed = seed &* 6364136223846793005 &+ 1442695040888963407
            return seed
        }
    }

    func session(seed: UInt64 = 1) throws -> ObjectiveQuestionSession {
        var generator = Generator(seed: seed)
        return try #require(ObjectiveQuestionSession(
            objectiveID: "objective", question: question, reference: reference,
            correctExplanation: "That is the designated option.",
            incorrectExplanation: "That option is not designated.", using: &generator))
    }

    @Test func shufflePreservesCorrectnessAcrossOrders() throws {
        var orders = Set<[Int]>()
        for seed in 1...32 {
            var value = try session(seed: UInt64(seed))
            orders.insert(value.answers.map(\.id))
            #expect(Set(value.answers.map(\.id)) == Set([0, 1, 2]))
            for answer in value.answers { #expect(answer.text == question.options[answer.id]) }
            let result1 = value.start()
            #expect(result1)
            let result2 = value.submit(answerID: 1)
            #expect(result2)
            #expect(value.status == .completed)
            #expect(value.feedback?.kind == .correct)
        }
        #expect(orders.count > 1)
    }

    @Test func wrongAttemptRetryAndCompletionPreserveContext() throws {
        var value = try session()
        let order = value.answers
        let result3 = value.start()
        #expect(result3)
        let result4 = value.submit(answerID: 0)
        #expect(result4)
        #expect(value.feedback == LearningFeedback(kind: .incorrect,
            explanation: "That option is not designated.", reference: reference))
        #expect(value.objectiveState.status == .active)
        let result5 = value.takeCompletion() == nil
        #expect(result5)
        let result6 = value.retry()
        #expect(result6)
        #expect(value.feedback == nil)
        #expect(value.selectedAnswerID == nil)
        #expect(value.answers == order)
        #expect(value.hint == question.hint)
        #expect(value.reference == reference)
        let result7 = value.submit(answerID: 1)
        #expect(result7)
        #expect(value.feedback?.explanation == "That is the designated option.")
        #expect(value.feedback?.reference == reference)
        #expect(value.objectiveState.status == .completed)
        let completion = value.takeCompletion()
        let report = try #require(completion)
        #expect(report.objectiveID == "objective")
        #expect(report.questionID == question.id)
        #expect(report.reference == reference)
        #expect(report.outcome == .success)
        let result8 = value.takeCompletion() == nil
        #expect(result8)
    }

    @Test func invalidActionsDoNotChangeState() throws {
        var value = try session()
        let result9 = !value.submit(answerID: 1)
        #expect(result9)
        let result10 = !value.retry()
        #expect(result10)
        let result11 = value.start()
        #expect(result11)
        let result12 = !value.start()
        #expect(result12)
        let result13 = !value.submit(answerID: 999)
        #expect(result13)
        #expect(value.status == .answering)
        #expect(value.selectedAnswerID == nil)
        let result14 = value.submit(answerID: 1)
        #expect(result14)
        let result15 = !value.submit(answerID: 0)
        #expect(result15)
        let result16 = !value.retry()
        #expect(result16)
        #expect(value.status == .completed)
    }

    @Test func invalidQuestionIsRejected() {
        let invalid = QuizQuestion(id: "bad", question: "Question", options: ["A", "B"],
                                   correctAnswerIndex: 9, hint: "Hint")
        #expect(ObjectiveQuestionSession(objectiveID: "objective", question: invalid,
            reference: reference, correctExplanation: "Yes", incorrectExplanation: "No") == nil)
    }
}
