import Foundation

/// Game-activity examples based on the provisions in 1 Samuel 17:17–18.
/// Matching pairs are an invented learning interaction, not Biblical quantities.
enum DavidMatchingGame {
    static let items: [MatchingItem] = [
        MatchingItem(id: "grain", name: "Grain", symbol: "🌾"),
        MatchingItem(id: "bread", name: "Bread", symbol: "🍞"),
        MatchingItem(id: "cheese", name: "Cheese", symbol: "🧀")
    ]

    static let configuration = PairMatchingPresentation(
        title: "Prepare the Provisions",
        instruction: "Match the provision pictures. This game activity helps you remember the provisions mentioned in 1 Samuel 17:17–18.",
        matchingPrompt: "Find the matching provisions",
        selectedPrompt: "Find the matching {item}.",
        matchedFeedback: "✅ {item} pair matched!",
        mismatchFeedback: "Those provisions do not match.",
        progressLabel: "Provision Pairs Matched",
        completedTitle: "Provisions Prepared!",
        completedMessage: "The matching pairs are a game activity. Read 1 Samuel 17:17–18 to see the provisions Jesse sent with David.",
        referenceLabel: "Game activity — 1 Samuel 17:17–18",
        completionSymbol: "🎒",
        items: items
    )
}
