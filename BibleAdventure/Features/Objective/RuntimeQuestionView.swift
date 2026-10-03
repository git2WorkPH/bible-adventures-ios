import SwiftUI

struct RuntimeQuestionView: View {
    let objective: Objective
    let runtime: StoryRuntimeCoordinator
    let token: UUID
    @AccessibilityFocusState private var feedbackFocused: Bool

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(objective.title).font(.title).accessibilityAddTraits(.isHeader)
                Text("Game activity").font(.headline)
                Text(objective.instruction)
                if let scripture = runtime.scripture {
                    Text("Scripture — \(scripture.reference.displayText) (\(scripture.translation.rawValue))").font(.headline)
                    Text(scripture.text).textSelection(.enabled)
                }
                Link("Read \(objective.reference.displayText) in the Bible", destination: sourceURL).frame(minHeight: 44)
                if let session = runtime.questionSession {
                    Text(session.prompt).font(.title2)
                    ForEach(session.answers) { answer in
                        Button {
                            runtime.submitAnswer(answer.id)
                            feedbackFocused = true
                        } label: {
                            HStack {
                                Text(answer.text).multilineTextAlignment(.leading)
                                Spacer()
                                if session.selectedAnswerID == answer.id { Image(systemName: "checkmark") }
                            }.frame(minHeight: 44)
                        }
                        .buttonStyle(.bordered)
                        .disabled(session.status != .answering)
                        .accessibilityValue(session.selectedAnswerID == answer.id ? "Selected" : "")
                        .accessibilityIdentifier("answer-\(answer.id)")
                    }
                    DisclosureGroup("Hint") { Text(session.hint) }.frame(minHeight: 44)
                    if let feedback = session.feedback { Text(feedback.explanation).accessibilityFocused($feedbackFocused) }
                    if session.status == .incorrect {
                        Button("Try again") { runtime.retryAnswer() }.buttonStyle(.borderedProminent)
                    }
                    if session.status == .completed {
                        Button("Continue story") { runtime.completeObjective(token: token) }
                            .buttonStyle(.borderedProminent).frame(minHeight: 44)
                    }
                }
            }.padding()
        }
    }

    private var sourceURL: URL {
        URL(string: "https://www.esv.org/\(objective.reference.displayText.replacingOccurrences(of: " ", with: "+"))/")!
    }
}
