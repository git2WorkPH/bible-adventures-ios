import SwiftUI

struct BuildRainbowView: View {

    let onComplete: () -> Void

    private let rainbowColours: [RainbowColour] = [
        RainbowColour(
            id: "red",
            name: "Red",
            colour: .red
        ),
        RainbowColour(
            id: "orange",
            name: "Orange",
            colour: .orange
        ),
        RainbowColour(
            id: "yellow",
            name: "Yellow",
            colour: .yellow
        ),
        RainbowColour(
            id: "green",
            name: "Green",
            colour: .green
        ),
        RainbowColour(
            id: "blue",
            name: "Blue",
            colour: .blue
        ),
        RainbowColour(
            id: "indigo",
            name: "Indigo",
            colour: Color(
                red: 75 / 255,
                green: 0 / 255,
                blue: 130 / 255
            )
        ),
        RainbowColour(
            id: "violet",
            name: "Violet",
            colour: .purple
        )
    ]

    @State private var availableColours: [RainbowColour] = []
    @State private var addedColours: [RainbowColour] = []
    @State private var completed = false

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text(" GOD's Covenant")
                    .font(.largeTitle)
                    .bold()

                Text(
                    "Build the rainbow and discover GOD's promise."
                )
                .multilineTextAlignment(.center)

                rainbowView

                if completed {

                    completedView

                } else {

                    colourSelectionView

                }

            }
            .padding()

        }
        .onAppear {

            prepareColours()

        }
    }

    // MARK: - Rainbow

    private var rainbowView: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 24)
                .fill(
                    Color.blue.opacity(0.1)
                )

            VStack(spacing: 6) {

                Spacer()

                ForEach(addedColours) { rainbowColour in

                    Capsule()
                        .fill(rainbowColour.colour)
                        .frame(
                            width: rainbowWidth(
                                for: rainbowColour
                            ),
                            height: 20
                        )
                        .transition(
                            .scale.combined(
                                with: .opacity
                            )
                        )

                }

                Text("🌍")
                    .font(.system(size: 60))

            }
            .padding()

        }
        .frame(height: 320)
        .animation(
            .easeInOut,
            value: addedColours.count
        )

    }

    // MARK: - Colour Selection

    private var colourSelectionView: some View {

        VStack(spacing: 20) {

            Text("Add colours to the rainbow")
                .font(.title2)
                .bold()

            Text(
                "\(addedColours.count) of \(rainbowColours.count) colours added"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            ProgressView(
                value: Double(addedColours.count),
                total: Double(rainbowColours.count)
            )

            LazyVGrid(
                columns: [
                    GridItem(.flexible()),
                    GridItem(.flexible())
                ],
                spacing: 16
            ) {

                ForEach(availableColours) { rainbowColour in

                    Button {

                        addColour(rainbowColour)

                    } label: {

                        VStack(spacing: 8) {

                            Circle()
                                .fill(rainbowColour.colour)
                                .frame(
                                    width: 55,
                                    height: 55
                                )

                            Text(rainbowColour.name)
                                .font(.headline)

                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 110)
                        .background(
                            rainbowColour.colour.opacity(0.1)
                        )
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 16
                            )
                        )

                    }
                    .buttonStyle(.plain)

                }

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("")
                .font(.system(size: 80))

            Text("GOD's Covenant")
                .font(.largeTitle)
                .bold()

            Text(
                "GOD set the rainbow in the clouds as the sign of His covenant."
            )
            .font(.title3)
            .multilineTextAlignment(.center)

            Text("📖 Genesis 9:12–17")
                .font(.headline)
                .foregroundStyle(.secondary)

            Button("Complete Noah's Adventure") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func prepareColours() {

        availableColours = rainbowColours.shuffled()

    }

    private func addColour(
        _ rainbowColour: RainbowColour
    ) {

        withAnimation(.easeInOut) {

            addedColours.append(rainbowColour)

            availableColours.removeAll {
                $0.id == rainbowColour.id
            }

        }

        if addedColours.count == rainbowColours.count {

            DispatchQueue.main.asyncAfter(
                deadline: .now() + 0.6
            ) {

                withAnimation(.easeInOut) {

                    completed = true

                }

            }

        }

    }

    private func rainbowWidth(
        for rainbowColour: RainbowColour
    ) -> CGFloat {

        guard let index = rainbowColours.firstIndex(
            where: {
                $0.id == rainbowColour.id
            }
        ) else {

            return 200

        }

        return 280 - CGFloat(index * 25)

    }

}

#Preview {

    BuildRainbowView(
        onComplete: {}
    )

}
