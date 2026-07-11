import SwiftUI

struct MeasureArkView: View {

    let onComplete: () -> Void

    private let measurements: [ArkMeasurement] = [

        ArkMeasurement(
            title: "Length",
            correctAnswer: "300 cubits",
            options: [
                "200 cubits",
                "300 cubits",
                "500 cubits"
            ]
        ),

        ArkMeasurement(
            title: "Width",
            correctAnswer: "50 cubits",
            options: [
                "30 cubits",
                "50 cubits",
                "80 cubits"
            ]
        ),

        ArkMeasurement(
            title: "Height",
            correctAnswer: "30 cubits",
            options: [
                "20 cubits",
                "30 cubits",
                "60 cubits"
            ]
        )
    ]

    @State private var currentIndex = 0
    @State private var currentOptions: [String] = []

    @State private var feedback = ""
    @State private var showContinue = false
    @State private var completed = false

    var body: some View {

        VStack(spacing: 30) {

            Spacer()

            if completed {
                completedView
            } else {
                questionView
            }

            Spacer()

        }
        .padding()
        .onAppear {
            shuffleCurrentOptions()
        }
    }

    // MARK: - Question

    private var questionView: some View {

        let measurement = measurements[currentIndex]

        return VStack(spacing: 24) {

            Text("📏 Measure the Ark")
                .font(.largeTitle)
                .bold()

            Text("Help Noah complete the ark blueprint.")
                .multilineTextAlignment(.center)

            Text(measurement.title)
                .font(.title)
                .bold()

            ForEach(currentOptions, id: \.self) { option in

                Button {

                    answer(option)

                } label: {

                    HStack {

                        Text(option)

                        Spacer()

                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue.opacity(0.1))
                    .clipShape(
                        RoundedRectangle(cornerRadius: 12)
                    )

                }
                .buttonStyle(.plain)

            }

            if !feedback.isEmpty {

                Text(feedback)
                    .font(.headline)
                    .multilineTextAlignment(.center)

            }

            if showContinue {

                Button(
                    currentIndex == measurements.count - 1
                    ? "Finish Blueprint"
                    : "Next"
                ) {

                    nextQuestion()

                }
                .buttonStyle(.borderedProminent)

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 24) {

            Text("📜")
                .font(.system(size: 70))

            Text("Blueprint Complete!")
                .font(.largeTitle)
                .bold()

            Text("""
Excellent!

You helped Noah remember the measurements GOD gave him.
""")
            .multilineTextAlignment(.center)

            VStack(alignment: .leading, spacing: 12) {

                Label(
                    "Length - 300 cubits",
                    systemImage: "checkmark.circle.fill"
                )

                Label(
                    "Width - 50 cubits",
                    systemImage: "checkmark.circle.fill"
                )

                Label(
                    "Height - 30 cubits",
                    systemImage: "checkmark.circle.fill"
                )

            }

            Button("Continue Story") {

                onComplete()

            }
            .buttonStyle(.borderedProminent)

        }

    }

    // MARK: - Logic

    private func answer(_ option: String) {

        let measurement = measurements[currentIndex]

        if option == measurement.correctAnswer {

            feedback = "✅ Correct!"

            showContinue = true

        } else {

            feedback = """
❌ That's not correct.

Think about Genesis 6:15 and try again.
"""

            showContinue = false

        }

    }

    private func nextQuestion() {

        feedback = ""
        showContinue = false

        if currentIndex < measurements.count - 1 {

            currentIndex += 1

            shuffleCurrentOptions()

        } else {

            completed = true

        }

    }

    private func shuffleCurrentOptions() {

        currentOptions = measurements[currentIndex]
            .options
            .shuffled()

    }

}

#Preview {

    MeasureArkView(
        onComplete: {}
    )

}
