import Foundation
import Testing
@testable import BibleAdventure

struct PairMatchingTests {
    @Test func twoConfigurationsSelectRetryCompleteAndRejectStaleActions() throws {
        for names in [["Circle", "Square"], ["Apple", "Pear", "Banana"]] {
            let items = names.map { MatchingItem(id: $0.lowercased(), name: $0, symbol: "") }
            var session = try #require(PairMatchingSession(items: items, shuffle: false))
            let attempt = session.attemptID
            let stale = UUID()
            let ignored = session.select(session.cards[0].id, attempt: stale)
            #expect(ignored == .ignored)
            let selected = session.select(session.cards[0].id, attempt: attempt)
            #expect(selected == .selected)
            let deselected = session.select(session.cards[0].id, attempt: attempt)
            #expect(deselected == .deselected)
            _ = session.select(session.cards[0].id, attempt: attempt)
            let mismatch = session.select(session.cards[2].id, attempt: attempt)
            #expect(mismatch == .mismatched)
            let locked = session.select(session.cards[1].id, attempt: attempt)
            #expect(locked == .ignored)
            let staleRetry = session.retryMismatch(attempt: stale)
            #expect(!staleRetry)
            let retry = session.retryMismatch(attempt: attempt)
            #expect(retry)
            while !session.cards.isEmpty {
                let first = session.cards[0]
                let second = session.cards[1]
                _ = session.select(first.id, attempt: attempt)
                let match = session.select(second.id, attempt: attempt)
                #expect(match == .matched)
                #expect(!session.cards.contains { $0.item.id == first.item.id })
                let duplicate = session.select(second.id, attempt: attempt)
                #expect(duplicate == .ignored)
            }
            #expect(session.isCompleted)
            let staleCompletion = session.takeCompletion(attempt: stale)
            #expect(!staleCompletion)
            let completion = session.takeCompletion(attempt: attempt)
            #expect(completion)
            let duplicateCompletion = session.takeCompletion(attempt: attempt)
            #expect(!duplicateCompletion)
        }
    }

    @Test func invalidItemsRejectedAndNoahHasSixteenPairs() {
        #expect(PairMatchingSession(items: []) == nil)
        let item = MatchingItem(id: "same", name: "Label", symbol: "")
        #expect(PairMatchingSession(items: [item, item]) == nil)
        #expect(PairMatchingSession(items: [MatchingItem(id: "", name: "", symbol: "")]) == nil)
        #expect(NoahMatchingGame.items.count == 16)
        #expect(PairMatchingSession(items: NoahMatchingGame.items)?.cards.count == 32)
    }
}
