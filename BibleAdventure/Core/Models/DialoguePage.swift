import Foundation

enum StoryContentKind: String { case scripture = "Scripture", interpretation = "Interpretation", gameActivity = "Game activity" }

struct DialoguePage {
    let speaker: Speaker
    let text: String
    let reference: BibleReference
    var kind: StoryContentKind = .gameActivity
}
