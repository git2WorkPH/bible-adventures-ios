import Foundation

struct Story: Identifiable, Codable {
    let id: StoryID
    let title: String
    let description: String
    let steps: [StoryStep]
}
