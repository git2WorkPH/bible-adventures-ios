import SwiftUI

struct StoryPlayerView: View {

    let story = StoryRepository.loadStory(.noah)

    @State private var currentStep = 0

    var body: some View {

        NavigationStack {

            VStack {

                Spacer()

                Text(story.title)
                    .font(.largeTitle)
                    .bold()

                Spacer()

                switch story.steps[currentStep] {

                case .dialogue(let dialogue):

                    VStack(spacing: 24) {

                        Text(dialogue.speaker.displayName)
                            .font(.headline)
                            .foregroundStyle(.blue)

                        Text(dialogue.text)
                            .font(.title2)
                            .multilineTextAlignment(.center)

                        Text("📖 \(dialogue.reference.displayText)")
                            .font(.caption)
                            .foregroundStyle(.secondary)

                        Button("Continue") {

                            if currentStep < story.steps.count - 1 {
                                currentStep += 1
                            }

                        }
                        .buttonStyle(.borderedProminent)

                    }

                case .objective(let objective):

                    ObjectiveView(objective: objective)

                }

                Spacer()

            }
            .padding()

        }
    }
}

#Preview {
    StoryPlayerView()
}
