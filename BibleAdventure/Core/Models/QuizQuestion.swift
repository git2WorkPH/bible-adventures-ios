import Foundation

struct QuizQuestion: Codable, Identifiable {

    let id: String

    let question: String

    let options: [String]

    let correctAnswerIndex: Int

    let hint: String

}

