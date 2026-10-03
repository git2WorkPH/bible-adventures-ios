import SwiftUI

struct ContentView: View {
    @State private var runtime = NoahStory.makeRuntime()
    @State private var showPlayer = false
    @State private var confirmNew = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    Image(systemName: "book.closed.fill").font(.system(size: 70)).accessibilityHidden(true)
                    Text("Bible Adventure").font(.largeTitle).bold()
                    Text("Journey to Understanding Who GOD Is").font(.title2)
                    Text("Explore Noah's story, then return to Genesis 6–9 in your Bible.")
                    Button("New Adventure") {
                        if runtime.canResume || runtime.recoveryRequired { confirmNew = true }
                        else { beginNew() }
                    }.buttonStyle(.borderedProminent).frame(minHeight: 44)
                    Button("Continue adventure") { showPlayer = runtime.resume() }
                        .buttonStyle(.bordered).frame(minHeight: 44).disabled(!runtime.canResume)
                    if runtime.recoveryRequired {
                        Text(runtime.error?.message ?? "Your saved adventure is unavailable. Start a new adventure.")
                    }
                    DisclosureGroup("Scripture attribution") {
                        Text(ScriptureAttribution.notice).font(.caption)
                        Link("ESV permissions", destination: URL(string: "https://www.crossway.org/permissions/")!).frame(minHeight: 44)
                    }.frame(minHeight: 44)
                }
                .multilineTextAlignment(.center).padding().frame(maxWidth: 700).frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            .navigationDestination(isPresented: $showPlayer) { StoryPlayerView(runtime: runtime) }
            .confirmationDialog("Start Noah again? This replaces the saved adventure.", isPresented: $confirmNew, titleVisibility: .visible) {
                Button("Start new adventure", role: .destructive) { beginNew() }
            }
        }
    }

    private func beginNew() { showPlayer = runtime.startNew() }
}
