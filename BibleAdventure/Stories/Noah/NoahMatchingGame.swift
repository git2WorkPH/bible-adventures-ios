import Foundation

/// Reviewed Noah-specific item examples and copy; matching rules are reusable.
enum NoahMatchingGame {
    static let items: [MatchingItem] = [

        MatchingItem(id: "lion",name: "Lion",symbol: "🦁"),
        MatchingItem(id: "elephant",name: "Elephant",symbol:"🐘"),
        MatchingItem(id: "giraffe",name: "Giraffe",symbol: "🦒"),
        MatchingItem(id: "zebra",name: "Zebra",symbol: "🦓"),
        MatchingItem(id:"tiger", name: "Tiger", symbol: "🐅"),
        MatchingItem(id: "parrot", name: "Parrot", symbol: "🦜"),
        MatchingItem(id:"redFireAnt", name:"Red Fire Ant", symbol: "🐜"),
        MatchingItem(id:"spider", name:"Spider", symbol: "🕷️"),
        MatchingItem(id:"rhino", name:"Rhino", symbol: "🦏"),
        MatchingItem(id:"bear", name:"Bear", symbol: "🐻"),
        MatchingItem(id:"sheep", name:"Sheep", symbol: "🐑"),
        MatchingItem(id:"dog", name:"Dog", symbol: "🐕"),
        MatchingItem(id:"horse", name:"Horse", symbol: "🎠"),
        MatchingItem(id:"camel", name:"Camel", symbol: "🐫"),
        MatchingItem(id:"frog", name:"Frog", symbol: "🐸"),
        MatchingItem(id:"kangaroo", name:"Kangaroo", symbol: "🦘")
    ]

    static let configuration = PairMatchingPresentation(
        title: "🦒 Gather the Animals", instruction: "Help Noah find the matching animal pairs.",
        matchingPrompt: "Find the matching pairs", selectedPrompt: "Find the matching {item}.", matchedFeedback: "✅ {item} pair gathered!", mismatchFeedback: "❌ Those animals don't match.", progressLabel: "Animal Pairs Gathered",
        completedTitle: "Animals Gathered!", completedMessage: "You helped Noah gather the animal pairs.", referenceLabel: "📖 Genesis 7", completionSymbol: "🚢", items: items)
}
