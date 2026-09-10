import Foundation

struct Story: Identifiable {
    let id: StoryID
    let title: String
    let description: String
    let steps: [StoryStep]
}
