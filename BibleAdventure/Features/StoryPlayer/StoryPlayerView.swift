import SwiftUI

struct StoryPlayerView: View {
    @State var runtime: StoryRuntimeCoordinator = NoahStory.makeRuntime()
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.storyReduceMotion) private var reduceMotion
    @AccessibilityFocusState private var titleFocused: Bool
    @State private var restartConfirmation = false

    var body: some View {
        VStack(spacing: 8) {
            Text(runtime.engine.currentStory?.title ?? "Adventure")
                .font(.headline).accessibilityAddTraits(.isHeader)
                .accessibilityFocused($titleFocused)
            if runtime.saveFailed {
                Text("Progress could not be saved. You can keep playing.")
                Button("Retry save") { runtime.save() }.buttonStyle(.bordered)
            }
            if runtime.error != nil {
                ScrollView {
                    Text(runtime.error?.title ?? "Adventure unavailable").font(.title)
                    Text(runtime.error?.message ?? "Please try again.")
                    if !runtime.recoveryRequired {
                        Button("Retry activity") { runtime.retryCurrentContent() }.buttonStyle(.borderedProminent)
                    }
                    Button("Start new adventure") { restartConfirmation = true }.buttonStyle(.bordered)
                }
            } else if runtime.engine.isCompleted {
                ReflectionView(runtime: runtime)
            } else {
                stepContent.id(runtime.stepToken)
            }
        }
        .controlSize(.large)
        .frame(maxWidth: 900).frame(maxWidth: .infinity).padding(.horizontal)
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                Menu {
                    Button("Restart Noah", role: .destructive) { restartConfirmation = true }
                    Link("Read Genesis 6–9", destination: URL(string: "https://www.esv.org/Genesis+6/")!)
                } label: {
                    Label("Adventure options", systemImage: "ellipsis.circle")
                        .labelStyle(.iconOnly).frame(width: 44, height: 44)
                }
            }
        }
        .confirmationDialog("Restart Noah from the beginning?", isPresented: $restartConfirmation, titleVisibility: .visible) {
            Button("Restart Noah", role: .destructive) { _ = runtime.startNew() }
        }
        .onChange(of: scenePhase) { _, phase in if phase != .active { runtime.save() } }
        .onChange(of: runtime.stepToken) { _, _ in titleFocused = true }
        .transaction { if reduceMotion { $0.animation = nil; $0.disablesAnimations = true } }
        .onAppear { if runtime.engine.currentStory == nil && !runtime.recoveryRequired { _ = runtime.startNew() } }
    }

    @ViewBuilder private var stepContent: some View {
        let token = runtime.stepToken
        switch runtime.engine.currentStep {
        case .dialogue(let page):
            DialogueView(page: page) { runtime.advanceDialogue(token: token) }
        case .objective(let objective):
            RuntimeQuestionView(objective: objective, runtime: runtime, token: token)
        case .miniGame(let type):
            if let attempt = runtime.miniGame?.attemptID {
                MiniGameView(miniGame: type) { runtime.receiveGame(.completed, attempt: attempt) }
            } else if runtime.miniGame?.state.status == .failed {
                Text("Try this activity again.")
                Button("Retry activity") { runtime.retryGame() }
            }
        case .none:
            ProgressView("Loading adventure")
        }
    }
}
