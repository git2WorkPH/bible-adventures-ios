import SwiftUI

struct ObjectiveView: View {

    let objective: Objective

    var body: some View {

        VStack(spacing: 24) {

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

            Button("Open Scripture") {

                // Next chapter
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
            title:"Listen to God",
            instruction: "Read Genesis 6:13 before continuing.",
            hint: "Open the Scripture to complete this objective.",
            type: .readScripture,
            reference: BibleReference(
                book: .genesis,
                chapter: 6,
                startVerse: 13,
                endVerse: nil
            )
        )
    )

}
