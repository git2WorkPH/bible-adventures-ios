import Foundation

/// Noah's resource selection belongs to the story-content layer, not the
/// reusable question repository.
enum NoahQuestionRepository {
    private static let repository = QuestionRepository(
        dataSource: BundleContentDataSource(resourceName: "noah_questions")
    )

    static func question(
        for identifier: String
    ) -> Result<QuizQuestion, ContentRepositoryError> {
        repository.question(for: identifier)
    }
}
