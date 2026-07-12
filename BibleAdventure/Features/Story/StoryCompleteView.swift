import SwiftUI

struct StoryCompleteView: View {

    let title: String

    var body: some View {

        VStack(spacing: 24) {

            Spacer()

            Text("🎉")
                .font(.system(size: 80))

            Text("Story Complete")
                .font(.largeTitle)
                .bold()

            Text(title)
                .font(.title2)

            Text("""
Well done!

You completed this Bible adventure.
""")
            .multilineTextAlignment(.center)

            Spacer()
        }
        .padding()
    }
}

#Preview {
    StoryCompleteView(title: "Noah")
}
