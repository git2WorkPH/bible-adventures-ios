import Foundation

protocol QuestionContentLoading {
    func questions() -> Result<[QuizQuestion], ContentRepositoryError>
    func question(for identifier: String) -> Result<QuizQuestion, ContentRepositoryError>
}

/// Decodes and validates an externalized question collection from an injected
/// data source. It has no story-specific resource-selection behavior.
struct QuestionRepository: QuestionContentLoading {
    private let dataSource: any ContentDataLoading

    init(dataSource: any ContentDataLoading) {
        self.dataSource = dataSource
    }

    func questions() -> Result<[QuizQuestion], ContentRepositoryError> {
        let data: Data

        switch dataSource.loadData() {
        case .success(let loadedData):
            data = loadedData
        case .failure(let error):
            return .failure(error)
        }

        do {
            let questions = try JSONDecoder().decode([QuizQuestion].self, from: data)
            return validate(questions)
        } catch {
            return .failure(.malformedContent("questions"))
        }
    }

    func question(
        for identifier: String
    ) -> Result<QuizQuestion, ContentRepositoryError> {
        switch questions() {
        case .success(let questions):
            guard let question = questions.first(where: { $0.id == identifier }) else {
                return .failure(.itemNotFound("question:\(identifier)"))
            }

            return .success(question)
        case .failure(let error):
            return .failure(error)
        }
    }

    private func validate(
        _ questions: [QuizQuestion]
    ) -> Result<[QuizQuestion], ContentRepositoryError> {
        var identifiers = Set<String>()

        for question in questions {
            guard !question.id.isEmpty,
                  !question.question.isEmpty,
                  question.options.count >= 2,
                  question.options.indices.contains(question.correctAnswerIndex),
                  identifiers.insert(question.id).inserted
            else {
                return .failure(.invalidContent("questions"))
            }
        }

        return .success(questions)
    }
}
