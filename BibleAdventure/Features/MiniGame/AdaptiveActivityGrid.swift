import SwiftUI

/// Accessible layouts expose all items in a single scrolling reading order.
struct AdaptiveActivityGrid<Content: View>: View {
    let singleColumn: Bool
    @ViewBuilder let content: () -> Content

    var body: some View {
        if singleColumn {
            VStack(spacing: 16, content: content)
        } else {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16, content: content)
        }
    }
}

struct GameActivityContext: View {
    var body: some View {
        VStack(spacing: 8) {
            Text("Game activity").font(.headline).accessibilityAddTraits(.isHeader)
            Text("Illustrations and interactions represent the story for learning.").font(.caption)
        }
    }
}
