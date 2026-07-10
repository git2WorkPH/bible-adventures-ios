import Foundation

struct QuestionRepository {

    private static var cache: [StoryID: [QuizQuestion]] = [:]

    static func loadQuestions(for story: StoryID) -> [QuizQuestion] {

        let fileName: String

        switch story {

        case .noah:
            fileName = "noah_questions"

        case .moses:
            fileName = "moses_questions"

        case .david:
            fileName = "david_questions"

        }

        guard let url = Bundle.main.url(
            forResource: fileName,
            withExtension: "json"
        ) else {

            fatalError("Unable to locate \(fileName).json")

        }

        do {

            let data = try Data(contentsOf: url)

            let questions = try JSONDecoder().decode(
                [QuizQuestion].self,
                from: data
            )
            
            cache[story]=questions
            return questions
            

        } catch {

            fatalError(error.localizedDescription)

        }

    }

    static func question(
        story: StoryID,
        id: String
    ) -> QuizQuestion {

        guard let question = loadQuestions(for: story)
            .first(where: { $0.id == id }) else {

            fatalError("Question '\(id)' not found.")

        }

        return question

    }

}
