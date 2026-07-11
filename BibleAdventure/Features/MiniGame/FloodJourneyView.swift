import SwiftUI

struct FloodJourneyView: View {

    let onComplete: () -> Void

    private let stages: [FloodJourneyStage] = [

        FloodJourneyStage(
            id: "rain",
            title: "The Rain Falls",
            message: "The rain continued to fall upon the earth.",
            waterLevel: 0.20,
            actionTitle: "Continue Through the Rain"
        ),

        FloodJourneyStage(
            id: "water_rises",
            title: "The Waters Rise",
            message: "The waters increased and lifted the ark.",
            waterLevel: 0.40,
            actionTitle: "Rise With the Waters"
        ),

        FloodJourneyStage(
            id: "ark_floats",
            title: "The Ark Floats",
            message: "The ark floated on the surface of the water.",
            waterLevel: 0.60,
            actionTitle: "Continue the Journey"
        ),

        FloodJourneyStage(
            id: "mountains_covered",
            title: "The Waters Prevail",
            message: "The waters rose greatly over the earth.",
            waterLevel: 0.80,
            actionTitle: "Stay in the Ark"
        ),

        FloodJourneyStage(
            id: "waiting",
            title: "Waiting on GOD",
            message: "Noah and his family remained safely inside the ark.",
            waterLevel: 1.0,
            actionTitle: "Wait on GOD"
        )
    ]

    @State private var currentStageIndex = 0
    @State private var completed = false

    private var currentStage: FloodJourneyStage {
        stages[currentStageIndex]
    }

    var body: some View {

        VStack(spacing: 24) {

            Text("🌊 The Flood Journey")
                .font(.largeTitle)
                .bold()

            Text(currentStage.title)
                .font(.title2)
                .bold()

            journeyView

            if completed {

                completedView

            } else {

                journeyControls

            }

        }
        .padding()
    }

    // MARK: - Journey

    private var journeyView: some View {

        GeometryReader { geometry in

            ZStack(alignment: .bottom) {

                skyView

                mountainView

                waterView(
                    height: geometry.size.height
                )

                arkView(
                    height: geometry.size.height
                )

                rainView

            }
            .clipShape(
                RoundedRectangle(cornerRadius: 24)
            )

        }
        .frame(height: 360)
    }

    // MARK: - Sky

    private var skyView: some View {

        Rectangle()
            .fill(
                Color.gray.opacity(0.25)
            )

    }

    // MARK: - Mountains

    private var mountainView: some View {

        HStack(alignment: .bottom, spacing: -30) {

            Image(systemName: "mountain.2.fill")
                .font(.system(size: 150))

            Image(systemName: "mountain.2.fill")
                .font(.system(size: 120))

        }
        .foregroundStyle(
            Color.brown.opacity(0.6)
        )

    }

    // MARK: - Water

    private func waterView(
        height: CGFloat
    ) -> some View {

        Rectangle()
            .fill(
                Color.blue.opacity(0.75)
            )
            .frame(
                height: height * currentStage.waterLevel
            )
            .animation(
                .easeInOut(duration: 1),
                value: currentStage.waterLevel
            )

    }

    // MARK: - Ark

    private func arkView(
        height: CGFloat
    ) -> some View {

        Text("🚢")
            .font(.system(size: 80))
            .offset(
                y: arkOffset(
                    height: height
                )
            )
            .animation(
                .easeInOut(duration: 1),
                value: currentStage.waterLevel
            )

    }

    private func arkOffset(
        height: CGFloat
    ) -> CGFloat {

        let movement =
            height * currentStage.waterLevel

        return -(movement / 2)
    }

    // MARK: - Rain

    private var rainView: some View {

        GeometryReader { geometry in

            ForEach(0..<35, id: \.self) { index in

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

    // MARK: - Controls

    private var journeyControls: some View {

        VStack(spacing: 16) {

            Text(currentStage.message)
                .font(.title3)
                .multilineTextAlignment(.center)

            ProgressView(
                value: Double(currentStageIndex + 1),
                total: Double(stages.count)
            )

            Text(
                "Journey \(currentStageIndex + 1) of \(stages.count)"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

            Button(currentStage.actionTitle) {

                continueJourney()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🚢🌊")
                .font(.system(size: 60))

            Text("Safe in the Ark")
                .font(.largeTitle)
                .bold()

            Text(
                "Through the flood, Noah and his family remained inside the ark."
            )
            .multilineTextAlignment(.center)

            Text("📖 Genesis 7")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func continueJourney() {

        if currentStageIndex < stages.count - 1 {

            withAnimation(.easeInOut) {

                currentStageIndex += 1

            }

        } else {

            withAnimation(.easeInOut) {

                completed = true

            }

        }

    }

}

#Preview {

    FloodJourneyView(
        onComplete: {}
    )

}
