import SwiftUI

struct PlaceholderMiniGameView: View {

    let title: String

    var body: some View {

        VStack(spacing: 20) {

            Spacer()

            Image(systemName: "hammer.fill")
                .font(.system(size: 60))

            Text(title)
                .font(.largeTitle)
                .bold()

            Text("Coming Soon")
                .foregroundStyle(.secondary)

            Spacer()

        }

        .padding()

    }

}

#Preview {

    PlaceholderMiniGameView(
        title: "Measure Ark"
    )

}
