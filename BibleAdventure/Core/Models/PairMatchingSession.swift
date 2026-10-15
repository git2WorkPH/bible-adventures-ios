import Foundation

struct MatchingItem: Identifiable, Codable, Equatable {
    let id: String
    let name: String
    let symbol: String
}

struct MatchingCard: Identifiable, Equatable {
    let id: String
    let item: MatchingItem
}

struct PairMatchingSession {
    enum Selection: Equatable { case selected, deselected, matched, mismatched, ignored }
    let attemptID = UUID()
    private(set) var cards: [MatchingCard]
    private(set) var selectedID: String?
    private(set) var matchedIDs = Set<String>()
    private(set) var awaitingRetry = false
    private var completionTaken = false
    let items: [MatchingItem]

    init?(items: [MatchingItem], shuffle: Bool = true) {
        guard !items.isEmpty, Set(items.map(\.id)).count == items.count,
              items.allSatisfy({ !$0.id.isEmpty && !$0.name.isEmpty }) else { return nil }
        self.items = items
        let cards = items.flatMap { item in [MatchingCard(id: item.id + "-0", item: item), MatchingCard(id: item.id + "-1", item: item)] }
        self.cards = shuffle ? cards.shuffled() : cards
    }

    var isCompleted: Bool { matchedIDs.count == items.count }

    mutating func select(_ id: String, attempt: UUID) -> Selection {
        guard attempt == attemptID, !awaitingRetry, !isCompleted, let card = cards.first(where: { $0.id == id }) else { return .ignored }
        guard selectedID != id else { selectedID = nil; return .deselected }
        guard let selectedID, let first = cards.first(where: { $0.id == selectedID }) else {
            self.selectedID = id; return .selected
        }
        if first.item.id == card.item.id {
            matchedIDs.insert(card.item.id)
            cards.removeAll { $0.item.id == card.item.id }
            self.selectedID = nil
            return .matched
        }
        awaitingRetry = true
        return .mismatched
    }

    @discardableResult
    mutating func retryMismatch(attempt: UUID) -> Bool {
        guard attempt == attemptID, awaitingRetry else { return false }
        awaitingRetry = false; selectedID = nil
        return true
    }

    mutating func takeCompletion(attempt: UUID) -> Bool {
        guard attempt == attemptID, isCompleted, !completionTaken else { return false }
        completionTaken = true
        return true
    }
}
