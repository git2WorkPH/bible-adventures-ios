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

    @State private var completedMeasurements: Set<String> = []

    var body: some View {

        ScrollView {

            VStack(spacing: 24) {

                Text("📏 Measure the Ark")
                    .font(.largeTitle)
                    .bold()

                blueprintView

                if completed {
                    completedView
                } else {
                    questionView
                }

            }
            .padding()

        }
        .onAppear {
            shuffleCurrentOptions()
        }
    }

    // MARK: - Blueprint

    private var blueprintView: some View {

        VStack(spacing: 16) {

            Text("📜 Ark Blueprint")
                .font(.title2)
                .bold()

            ZStack {

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.blue.opacity(0.08))

                VStack(spacing: 12) {

                    Image(systemName: "ferry.fill")
                        .font(.system(size: 70))
                        .foregroundStyle(.blue)

                    blueprintMeasurement(
                        title: "Length",
                        value: "300 cubits"
                    )

                    blueprintMeasurement(
                        title: "Width",
                        value: "50 cubits"
                    )

                    blueprintMeasurement(
                        title: "Height",
                        value: "30 cubits"
                    )

                }
                .padding()

            }
            .frame(height: 260)

        }

    }

    private func blueprintMeasurement(
        title: String,
        value: String
    ) -> some View {

        HStack {

            Text(title)

            Spacer()

            if completedMeasurements.contains(title) {

                Text(value)
                    .bold()

                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)

            } else {

                Text("???")
                    .foregroundStyle(.secondary)

            }

        }
    }

    // MARK: - Question

    private var questionView: some View {

        let measurement = measurements[currentIndex]

        return VStack(spacing: 20) {

            Text("Choose the correct \(measurement.title.lowercased()).")
                .font(.title3)
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
                    : "Next Measurement"
                ) {

                    nextQuestion()

                }
                .buttonStyle(.borderedProminent)

            }

        }

    }

    // MARK: - Completed

    private var completedView: some View {

        VStack(spacing: 20) {

            Text("✅ Blueprint Approved!")
                .font(.largeTitle)
                .bold()

            Text("""
Excellent!

You completed the measurements GOD gave Noah.
""")
            .multilineTextAlignment(.center)

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

            withAnimation(.easeInOut) {

                completedMeasurements.insert(
                    measurement.title
                )

            }

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

            withAnimation {
                completed = true
            }

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
