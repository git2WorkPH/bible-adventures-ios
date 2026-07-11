import SwiftUI

struct EnterArkView: View {

    let onComplete: () -> Void

    private let familyMembers = [
        "👨 Noah",
        "👩 Noah's Wife",
        "👨 Son",
        "👩 Son's Wife",
        "👨 Son",
        "👩 Son's Wife",
        "👨 Son",
        "👩 Son's Wife"
    ]

    @State private var enteredMembers: [String] = []
    @State private var currentIndex = 0

    @State private var doorClosed = false
    @State private var rainStarted = false
    @State private var completed = false

    var body: some View {

        VStack(spacing: 24) {

            Text(rainStarted ? "🌧️ The Rain Begins" : "🚢 Enter the Ark")
                .font(.largeTitle)
                .bold()

            Spacer()

            arkView

            Spacer()

            if completed {

                completedView

            } else if doorClosed {

                rainView

            } else {

                enterArkControls

            }

        }
        .padding()
    }

    // MARK: - Ark

    private var arkView: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.brown.opacity(0.8))
                .frame(height: 260)

            VStack(spacing: 16) {

                Text("🚢")
                    .font(.system(size: 80))

                Text("Noah's Ark")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(.white)

                if doorClosed {

                    Image(systemName: "door.left.hand.closed")
                        .font(.system(size: 45))
                        .foregroundStyle(.white)

                } else {

                    Text("Door Open")
                        .foregroundStyle(.white)

                }

                HStack {

                    ForEach(
                        Array(enteredMembers.enumerated()),
                        id: \.offset
                    ) { _, member in

                        Text(memberEmoji(member))
                            .font(.title2)

                    }

                }

            }

            if rainStarted {

                rainOverlay

            }

        }
        .animation(
            .easeInOut,
            value: enteredMembers.count
        )
    }

    // MARK: - Rain

    private var rainOverlay: some View {

        GeometryReader { geometry in

            ForEach(0..<30, id: \.self) { index in

                Text("💧")
                    .font(.caption)
                    .position(
                        x: rainX(
                            index: index,
                            width: geometry.size.width
                        ),
                        y: rainY(
                            index: index,
                            height: geometry.size.height
                        )
                    )

            }

        }

    }

    // MARK: - Controls

    private var enterArkControls: some View {

        VStack(spacing: 16) {

            if currentIndex < familyMembers.count {

                Text("GOD told Noah to enter the ark.")
                    .multilineTextAlignment(.center)

                Text(familyMembers[currentIndex])
                    .font(.title)

                Button("Enter the Ark") {

                    enterCurrentMember()

                }
                .buttonStyle(.borderedProminent)

            } else {

                Text("Everyone is safely inside.")
                    .font(.headline)

                Button("Close the Ark") {

                    closeDoor()

                }
                .buttonStyle(.borderedProminent)

            }

            Text(
                "\(enteredMembers.count) of \(familyMembers.count) inside"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

        }

    }

    // MARK: - Rain View

    private var rainView: some View {

        VStack(spacing: 16) {

            if rainStarted {

                Text("🌧️ 🌧️ 🌧️")
                    .font(.largeTitle)

                Text("The rain began to fall.")
                    .font(.title2)
                    .bold()

            } else {

                Text("The ark door is closed.")
                    .font(.title2)
                    .bold()

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🌧️")
                .font(.system(size: 70))

            Text("The Flood Begins")
                .font(.largeTitle)
                .bold()

            Text(
                "Noah and his family were safely inside the ark."
            )
            .multilineTextAlignment(.center)

            Text("📖 Genesis 7:13–16")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func enterCurrentMember() {

        guard currentIndex < familyMembers.count else {
            return
        }

        withAnimation(.easeInOut) {

            enteredMembers.append(
                familyMembers[currentIndex]
            )

            currentIndex += 1

        }

    }

    private func closeDoor() {

        withAnimation(.easeInOut) {

            doorClosed = true

        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1
        ) {

            withAnimation(.easeInOut) {

                rainStarted = true

            }

        }

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3
        ) {

            withAnimation(.easeInOut) {

                completed = true

            }

        }

    }

    private func memberEmoji(
        _ member: String
    ) -> String {

        String(member.prefix(1))

    }

    private func rainX(
        index: Int,
        width: CGFloat
    ) -> CGFloat {

        let position = (index * 47) % 100

        return width * CGFloat(position) / 100

    }

    private func rainY(
        index: Int,
        height: CGFloat
    ) -> CGFloat {

        let position = (index * 31) % 100

        return height * CGFloat(position) / 100

    }

}

#Preview {

    EnterArkView(
        onComplete: {}
    )

}
