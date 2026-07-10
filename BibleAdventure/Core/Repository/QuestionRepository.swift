import Foundation

struct QuestionRepository {

    static func loadQuestions(for story: StoryID) -> [QuizQuestion]{
        guard
            let url = Bundle.main.url(
                forResource: "noah_questions",
                withExtension: "json"
            )
        else {

            fatalError("Unable to locate noah_questions.json")

        }

        do {

            let data = try Data(contentsOf: url)

            return try JSONDecoder().decode(
                [QuizQuestion].self,
                from: data
            )

        } catch {

            fatalError(error.localizedDescription)

        }

    }
    
    static func question(
        id: String
    ) -> QuizQuestion {

        guard let question = loadQuestions(for: .noah)
            .first(where: { $0.id == id }) else {

            fatalError("Question not found")

        }

        return question

    }

}
