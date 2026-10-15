import SwiftUI

struct StorySelectionView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Choose Adventure").font(.largeTitle).bold()
            ForEach(StoryCatalogue.entries) { entry in
                NavigationLink(entry.title) {
                    StoryPlayerView(runtime: entry.makeRuntime())
                }.frame(minHeight: 44)
            }
        }.padding()
    }
}

#Preview { NavigationStack { StorySelectionView() } }
