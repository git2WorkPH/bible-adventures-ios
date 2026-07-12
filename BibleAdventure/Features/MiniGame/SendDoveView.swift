import SwiftUI

struct SendDoveView: View {

    let onComplete: () -> Void

    private let stages: [DoveJourneyStage] = [

        DoveJourneyStage(
            id: "first_flight",
            title: "First Flight",
            message: "Noah sent out the dove to see if the waters had receded.",
            actionTitle: "Send the Dove",
            resultMessage: "The dove found nowhere to rest and returned to Noah.",
            resultEmoji: "🕊️🚢"
        ),

        DoveJourneyStage(
            id: "second_flight",
            title: "Seven Days Later",
            message: "Noah waited seven more days and sent the dove out again.",
            actionTitle: "Send the Dove Again",
            resultMessage: "The dove returned with a freshly plucked olive leaf!",
            resultEmoji: "🕊️🌿"
        ),

        DoveJourneyStage(
            id: "third_flight",
            title: "Seven More Days",
            message: "Noah waited seven more days and sent the dove again.",
            actionTitle: "Send the Dove One More Time",
            resultMessage: "This time, the dove did not return.",
            resultEmoji: "🌤️"
        )
    ]

    @State private var currentStageIndex = 0
    @State private var doveFlying = false
    @State private var showResult = false
    @State private var completed = false

    private var currentStage: DoveJourneyStage {
        stages[currentStageIndex]
    }

    var body: some View {

        VStack(spacing: 24) {

            Text("🕊️ Send the Dove")
                .font(.largeTitle)
                .bold()

            Text(currentStage.title)
                .font(.title2)
                .bold()

            Spacer()

            journeyView

            Spacer()

            if completed {

                completedView

            } else if showResult {

                resultView

            } else {

                controlsView

            }

        }
        .padding()
    }

    // MARK: - Journey

    private var journeyView: some View {

        ZStack {

            RoundedRectangle(cornerRadius: 24)
                .fill(Color.blue.opacity(0.12))

            VStack {

                Spacer()

                Text("🚢")
                    .font(.system(size: 80))

            }
            .padding()

            Text("🕊️")
                .font(.system(size: 55))
                .offset(
                    x: doveFlying ? 180 : 0,
                    y: doveFlying ? -100 : 0
                )
                .opacity(
                    doveFlying ? 0 : 1
                )
                .animation(
                    .easeInOut(duration: 1.5),
                    value: doveFlying
                )

        }
        .frame(height: 320)
    }

    // MARK: - Controls

    private var controlsView: some View {

        VStack(spacing: 16) {

            Text(currentStage.message)
                .font(.title3)
                .multilineTextAlignment(.center)

            Text("📖 Genesis 8:8–12")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button(currentStage.actionTitle) {

                sendDove()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Result

    private var resultView: some View {

        VStack(spacing: 16) {

            Text(currentStage.resultEmoji)
                .font(.system(size: 60))

            Text(currentStage.resultMessage)
                .font(.title3)
                .multilineTextAlignment(.center)

            Button(
                currentStageIndex == stages.count - 1
                ? "Continue"
                : "Wait Seven Days"
            ) {

                nextStage()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("🌿")
                .font(.system(size: 70))

            Text("The Waters Had Receded")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)

            Text(
                "Noah knew the waters were disappearing from the earth."
            )
            .multilineTextAlignment(.center)

            Text("📖 Genesis 8:11–12")
                .font(.caption)
                .foregroundStyle(.secondary)

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func sendDove() {

        doveFlying = true

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 1.6
        ) {

            withAnimation(.easeInOut) {

                showResult = true

            }

        }

    }

    private func nextStage() {

        showResult = false
        doveFlying = false

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

    SendDoveView(
        onComplete: {}
    )

}
