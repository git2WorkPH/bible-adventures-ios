import Foundation

enum StoryContentKind: String, Codable { case scripture = "Scripture", interpretation = "Interpretation", gameActivity = "Game activity" }

struct DialoguePage: Codable {
    let speaker: Speaker
    let text: String
    let reference: BibleReference
    var kind: StoryContentKind = .gameActivity
}
