import SwiftUI

struct ScriptureView: View {

    let objective: Objective

    @Environment(\.dismiss) private var dismiss

    @State private var selectedAnswer: Int?
    @State private var isCorrect = false
    @State private var showWrongAnswer = false

    
    private var question: QuizQuestion {
           QuestionRepository.question(
               story: objective.storyId,
               id: objective.questionId
           )
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

            let question = question

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

                dismiss()

            }
            .buttonStyle(.borderedProminent)
            .disabled(!isCorrect)

        }
        .padding()
        .navigationBarBackButtonHidden(true)

    }
}

#Preview {

    ScriptureView(
        objective: Objective(
            id: "listen_to_god",
            title: "Listen to GOD",
            instruction: "Read Genesis 6:13 before continuing.",
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
        )
    )
}
