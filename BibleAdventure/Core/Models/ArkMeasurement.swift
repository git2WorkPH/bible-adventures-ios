import Foundation

struct ArkMeasurement: Identifiable {

    let id = UUID()

    let title: String

    let correctAnswer: String

    let options: [String]

}
