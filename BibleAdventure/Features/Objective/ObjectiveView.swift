import SwiftUI

struct ObjectiveView: View {

    let objective: Objective
    let onComplete: () -> Void

    @State private var completed = false

    var body: some View {

        VStack(spacing: 24) {
            
            if completed {

                Button("Continue") {
                    onComplete()
                }

            }

            Image(systemName: "target")
                .font(.system(size: 60))
                .foregroundStyle(.orange)

            Text("Objective")
                .font(.largeTitle)
                .bold()

            Text(objective.instruction)
                .font(.title2)
                .multilineTextAlignment(.center)

            if let hint = objective.hint {

                Text(hint)
                    .foregroundStyle(.secondary)
            }

            NavigationLink("Open Scripture") {

                ScriptureView(objective: objective, onComplete: onComplete)

            }
            .buttonStyle(.borderedProminent)

        }
        .padding()
    }
}

#Preview {

    
        ObjectiveView(
            objective: Objective(
                id: "listen_to_god",
                title: "Listen to GOD",
                instruction: "Read Genesis 6:9 - 8:22 before continuing.",
                hint: "Answer the question after reading.",
                type: .readScripture,
                reference: BibleReference(
                    book: .genesis,
                    chapter: 6,
                    startVerse: 9,
                    endVerse: nil
                ),
                scripture: """
    For GOD said to Noah...
    (Paste your Bible verse here)
    """,
                questionId: "listen_to_god", storyId: .noah
            ),
            onComplete: {}
        )
    }


