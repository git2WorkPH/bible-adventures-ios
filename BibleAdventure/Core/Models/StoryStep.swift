import Foundation

enum StoryStep {

    case dialogue(DialoguePage)

    case objective(Objective)

    case miniGame(MiniGameType)

}

extension StoryStep: Codable {
    private enum CodingKeys: String, CodingKey { case kind, dialogue, objective, activity }
    private enum Kind: String, Codable { case dialogue, objective, miniGame }

    init(from decoder: any Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let kind = try values.decode(Kind.self, forKey: .kind)
        let expected: CodingKeys = kind == .dialogue ? .dialogue : kind == .objective ? .objective : .activity
        guard [.dialogue, .objective, .activity].filter({ values.contains($0) }) == [expected] else {
            throw DecodingError.dataCorruptedError(forKey: .kind, in: values, debugDescription: "A step must contain exactly its tagged payload.")
        }
        switch kind {
        case .dialogue: self = .dialogue(try values.decode(DialoguePage.self, forKey: .dialogue))
        case .objective: self = .objective(try values.decode(Objective.self, forKey: .objective))
        case .miniGame: self = .miniGame(try values.decode(MiniGameType.self, forKey: .activity))
        }
    }

    func encode(to encoder: any Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        switch self {
        case .dialogue(let page):
            try values.encode(Kind.dialogue, forKey: .kind)
            try values.encode(page, forKey: .dialogue)
        case .objective(let objective):
            try values.encode(Kind.objective, forKey: .kind)
            try values.encode(objective, forKey: .objective)
        case .miniGame(let activity):
            try values.encode(Kind.miniGame, forKey: .kind)
            try values.encode(activity, forKey: .activity)
        }
    }
}
