import SwiftUI

struct DialogueView: View {

    let page: DialoguePage
    let onContinue: () -> Void

    var body: some View {

        VStack(spacing: 24) {

            Spacer()

            Text(page.speaker.displayName)
                .font(.headline)
                .foregroundStyle(.blue)

            Text(page.text)
                .font(.title2)
                .multilineTextAlignment(.center)

            Text("📖 \(page.reference.displayText)")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()
            
            Button("Continue"){
                onContinue()
            }.buttonStyle(.borderedProminent)

        }
        .padding()
    }
}

#Preview {

    DialogueView(
        page: DialoguePage(
            speaker: .God,
            text: "Build an ark using cypress wood.",
            reference: BibleReference(
                book: .genesis,
                chapter: 6,
                startVerse: 14,
                endVerse: nil
                
            )
        ),
        onContinue: {}
    )

}
