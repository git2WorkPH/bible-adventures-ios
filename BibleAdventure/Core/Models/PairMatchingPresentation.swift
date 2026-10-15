import Foundation

struct PairMatchingPresentation {
    let title: String
    let instruction: String
    let matchingPrompt: String
    let selectedPrompt: String
    let matchedFeedback: String
    let mismatchFeedback: String
    let progressLabel: String
    let completedTitle: String
    let completedMessage: String
    let referenceLabel: String
    let completionSymbol: String
    let items: [MatchingItem]

    func selectedMessage(for name: String) -> String { selectedPrompt.replacingOccurrences(of: "{item}", with: name) }
    func matchedMessage(for name: String) -> String { matchedFeedback.replacingOccurrences(of: "{item}", with: name) }
}
