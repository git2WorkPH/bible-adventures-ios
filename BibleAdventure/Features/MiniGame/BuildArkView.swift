import SwiftUI

struct BuildArkView: View {

    let onComplete: () -> Void

    private let stages: [ArkBuildStage] = [
        ArkBuildStage(
            id: "foundation",
            title: "Build the Foundation",
            icon: "rectangle.fill"
        ),
        ArkBuildStage(
            id: "lower_deck",
            title: "Build the Lower Deck",
            icon: "square.stack.fill"
        ),
        ArkBuildStage(
            id: "middle_deck",
            title: "Build the Middle Deck",
            icon: "square.stack.3d.up.fill"
        ),
        ArkBuildStage(
            id: "upper_deck",
            title: "Build the Upper Deck",
            icon: "building.2.fill"
        ),
        ArkBuildStage(
            id: "roof",
            title: "Finish the Ark",
            icon: "house.fill"
        )
    ]

    @State private var currentStageIndex = 0
    @State private var completedStages: Set<String> = []
    @State private var completed = false

    var body: some View {

        VStack(spacing: 24) {

            Text("🔨 Build the Ark")
                .font(.largeTitle)
                .bold()

            Text("Help Noah build the ark.")
                .multilineTextAlignment(.center)

            Spacer()

            arkView

            Spacer()

            if completed {

                completedView

            } else {

                buildControls

            }

        }
        .padding()
    }

    // MARK: - Ark

    private var arkView: some View {

        VStack(spacing: 6) {

            if isCompleted("roof") {

                Image(systemName: "triangle.fill")
                    .font(.system(size: 50))
                    .transition(.scale)

            }

            if isCompleted("upper_deck") {

                arkSection(
                    title: "Upper Deck",
                    width: 180
                )

            }

            if isCompleted("middle_deck") {

                arkSection(
                    title: "Middle Deck",
                    width: 220
                )

            }

            if isCompleted("lower_deck") {

                arkSection(
                    title: "Lower Deck",
                    width: 260
                )

            }

            if isCompleted("foundation") {

                Capsule()
                    .frame(
                        width: 300,
                        height: 30
                    )
                    .transition(.move(edge: .bottom))

            }

        }
        .frame(height: 300)
        .animation(
            .easeInOut,
            value: completedStages
        )

    }

    private func arkSection(
        title: String,
        width: CGFloat
    ) -> some View {

        RoundedRectangle(cornerRadius: 8)
            .fill(Color.brown.opacity(0.8))
            .frame(
                width: width,
                height: 45
            )
            .overlay {

                Text(title)
                    .foregroundStyle(.white)
                    .bold()

            }
            .transition(.scale)

    }

    // MARK: - Controls

    private var buildControls: some View {

        let stage = stages[currentStageIndex]

        return VStack(spacing: 16) {

            Text(stage.title)
                .font(.title2)
                .bold()

            Button {

                buildCurrentStage()

            } label: {

                Label(
                    stage.title,
                    systemImage: stage.icon
                )
                .frame(maxWidth: .infinity)
                .padding()

            }
            .buttonStyle(.borderedProminent)

            Text(
                "\(completedStages.count) of \(stages.count) sections completed"
            )
            .font(.caption)
            .foregroundStyle(.secondary)

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 16) {

            Text("🚢 Ark Complete!")
                .font(.largeTitle)
                .bold()

            Text(
                "You helped Noah build the ark according to GOD's instructions."
            )
            .multilineTextAlignment(.center)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func buildCurrentStage() {

        let stage = stages[currentStageIndex]

        withAnimation(.easeInOut) {

            completedStages.insert(stage.id)

        }

        if currentStageIndex < stages.count - 1 {

            currentStageIndex += 1

        } else {

            withAnimation {

                completed = true

            }

        }

    }

    private func isCompleted(
        _ stageID: String
    ) -> Bool {

        completedStages.contains(stageID)

    }

}

#Preview {

    BuildArkView(
        onComplete: {}
    )

}
