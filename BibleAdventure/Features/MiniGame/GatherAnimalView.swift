import SwiftUI

struct GatherAnimalsView: View {
    let onComplete: () -> Void
    var body: some View {
        PairMatchingView(configuration: NoahMatchingGame.configuration, onComplete: onComplete)
    }
}

#Preview { GatherAnimalsView(onComplete: {}) }
