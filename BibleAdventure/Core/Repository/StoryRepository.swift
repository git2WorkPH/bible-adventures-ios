import Foundation

/// An in-memory story repository with no story-specific selection rules.
struct StoryRepository: StoryLoading {
    private let stories: [StoryID: Story]

    init(stories: [Story]) {
        self.stories = Dictionary(
            uniqueKeysWithValues: stories.map { ($0.id, $0) }
        )
    }

    func story(for storyID: StoryID) -> Result<Story, ContentRepositoryError> {
        guard let story = stories[storyID] else {
            return .failure(.itemNotFound("story:\(storyID.rawValue)"))
        }

        return .success(story)
    }
}
