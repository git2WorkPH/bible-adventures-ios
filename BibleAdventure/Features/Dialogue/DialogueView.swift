import SwiftUI

struct DialogueView: View {

    let page: DialoguePage
    let onContinue: () -> Void

    var body: some View {

        ScrollView {
        VStack(spacing: 24) {

            Spacer()

            Text(page.kind == .scripture ? "Scripture — \(page.reference.displayText) (ESV)" : page.kind.rawValue)
                .font(.headline)
                .accessibilityAddTraits(.isHeader)

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
            }.buttonStyle(.borderedProminent).frame(minHeight: 44)

        }
        .padding()
        }
    }
}

#Preview {

    DialogueView(
        page: DialoguePage(
            speaker: .God,
            text: "Help prepare the ark in this game activity.",
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
