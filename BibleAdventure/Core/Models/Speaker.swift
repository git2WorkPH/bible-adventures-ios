import Foundation

enum Speaker {
    case God
    case noah
    case narrator

    var displayName: String {
        switch self {
        case .God:
            return "GOD"

        case .noah:
            return "Noah"

        case .narrator:
            return "Narrator"
        }
    }
}
