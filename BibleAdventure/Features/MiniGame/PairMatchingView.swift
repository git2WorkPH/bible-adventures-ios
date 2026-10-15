import SwiftUI

struct PairMatchingView: View {
    let configuration: PairMatchingPresentation
    let onComplete: () -> Void
    @Environment(\.storyReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var typeSize
    @Environment(\.accessibilityVoiceOverEnabled) private var voiceOver
    @State private var session: PairMatchingSession?
    @State private var feedback = ""
    @State private var showCompletion = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                GameActivityContext()
                Text(configuration.title).font(.largeTitle).bold()
                Text(configuration.instruction).multilineTextAlignment(.center)
                if let session {
                    Text(configuration.progressLabel).font(.headline)
                    ProgressView(value: Double(session.matchedIDs.count), total: Double(session.items.count))
                    Text("\(session.matchedIDs.count) of \(session.items.count)").font(.caption)
                    if showCompletion {
                        Text(configuration.completionSymbol).font(.system(size: 70)).accessibilityHidden(true)
                        Text(configuration.completedTitle).font(.largeTitle).bold()
                        Text(configuration.completedMessage).multilineTextAlignment(.center)
                        ForEach(session.items) { item in Text("\(item.symbol) \(item.symbol)  \(item.name) Pair").font(.title3) }
                        Text(configuration.referenceLabel).font(.caption)
                        Button("Continue Story") {
                            if self.session?.takeCompletion(attempt: session.attemptID) == true { onComplete() }
                        }.buttonStyle(.borderedProminent).frame(minHeight: 44)
                    } else {
                        Text(configuration.matchingPrompt).font(.title2).bold()
                        AdaptiveActivityGrid(singleColumn: typeSize.isAccessibilitySize || voiceOver) {
                            ForEach(session.cards) { card in
                                Button { select(card) } label: {
                                    VStack(spacing: 8) {
                                        Text(card.item.symbol).font(.system(size: 60)).accessibilityHidden(true)
                                        Text(card.item.name).font(.headline)
                                    }
                                    .frame(maxWidth: .infinity).frame(minHeight: 130)
                                    .background(RoundedRectangle(cornerRadius: 16).fill(session.selectedID == card.id ? Color.blue.opacity(0.25) : Color.green.opacity(0.1)))
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(session.selectedID == card.id ? Color.blue : Color.clear, lineWidth: 3))
                                }.buttonStyle(.plain).disabled(session.awaitingRetry)
                                    .accessibilityLabel(card.item.name)
                                    .accessibilityValue(session.selectedID == card.id ? "Selected" : "Not selected")
                            }
                        }
                        if !feedback.isEmpty { Text(feedback).font(.headline).multilineTextAlignment(.center) }
                    }
                } else {
                    Text("This matching activity is unavailable.")
                }
            }.padding()
        }
        .transaction { if reduceMotion { $0.animation = nil; $0.disablesAnimations = true } }
        .onAppear { if session == nil { session = PairMatchingSession(items: configuration.items) } }
    }

    private func select(_ card: MatchingCard) {
        guard let attempt = session?.attemptID else { return }
        switch session?.select(card.id, attempt: attempt) {
        case .selected: feedback = configuration.selectedMessage(for: card.item.name)
        case .deselected: feedback = ""
        case .matched:
            feedback = configuration.matchedMessage(for: card.item.name)
            if session?.isCompleted == true {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    guard session?.attemptID == attempt else { return }
                    showCompletion = true
                }
            }
        case .mismatched:
            feedback = configuration.mismatchFeedback
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                if session?.retryMismatch(attempt: attempt) == true { feedback = "" }
            }
        case .ignored, .none: break
        }
    }
}
