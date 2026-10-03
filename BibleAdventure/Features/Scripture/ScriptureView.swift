import SwiftUI

struct ScriptureView: View {

    let objective: Objective

    @Environment(\.dismiss) private var dismiss

    @State private var selectedAnswer: Int?
    @State private var isCorrect = false
    @State private var showWrongAnswer = false

//    let reference: BibleReference
//    let verse: String
    let onComplete: () -> Void
    
    private var questionResult: Result<QuizQuestion, ContentRepositoryError> {
        NoahQuestionRepository.question(for: objective.questionId)
    }
    
    
    var body: some View {

        VStack(spacing: 20) {

            Text("📖 Scripture")
                .font(.largeTitle)
                .bold()

            Text(objective.reference.displayText)
                .font(.headline)
                .foregroundStyle(.secondary)

            ScrollView {

                Text(objective.scripture)
                    .frame(maxWidth: .infinity, alignment: .leading)

            }
            .frame(maxHeight: 220)

            Divider()

            switch questionResult {
            case .success(let question):
                questionContent(question)
            case .failure:
                Text("This question is unavailable right now. Please return to the story and try again.")
                    .multilineTextAlignment(.center)
                    .foregroundStyle(.secondary)
            }

        }
        .padding()
        .navigationBarBackButtonHidden(true)

    }

    @ViewBuilder
    private func questionContent(_ question: QuizQuestion) -> some View {
        Text(question.question)
            .font(.title3)
            .bold()

        ForEach(question.options.indices, id: \.self) { index in

                Button {

                    selectedAnswer = index

                    if index == question.correctAnswerIndex {

                        isCorrect = true
                        showWrongAnswer = false

                    } else {

                        isCorrect = false
                        showWrongAnswer = true

                    }

                } label: {

                    HStack {

                        Text(question.options[index])

                        Spacer()

                        if selectedAnswer == index {
                            Image(systemName: "checkmark.circle.fill")
                        }

                    }

                }
                .buttonStyle(.bordered)

        }

        if showWrongAnswer {

            Text("❌ That's not quite right. Read the Scripture again and try once more.")
                .foregroundStyle(.red)
                .multilineTextAlignment(.center)

        }

        if isCorrect {

            Text("✅ Great job! You answered correctly.")
                .foregroundStyle(.green)

        }

        Button("Continue") {

            onComplete()
            dismiss()

        }
        .buttonStyle(.borderedProminent)
        .disabled(!isCorrect)

    }
}

#Preview {

    ScriptureView(
        objective: Objective(
            id: "listen_to_god",
            title: "Listen to GOD",
            instruction: "Read Genesis 6:9 - 8:22 before continuing.",
            hint: "Answer the question after reading.",
            type: .readScripture,
            reference: BibleReference(
                book: .genesis,
                chapter: 6,
                startVerse: 13,
                endVerse: nil
            ),
            scripture: """
Paste Genesis 6:13 here.
""",
            questionId: "listen_to_god", storyId: .noah
        ),
        onComplete:  {}

    )
}
