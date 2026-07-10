import Foundation

struct StoryRepository {

    static func loadStory(_ storyID: StoryID) -> Story {

        switch storyID {

        case .noah:
            return NoahStory.build()

        case .moses:
            fatalError("Moses story not implemented.")

        case .david:
            fatalError("David story not implemented.")
        }
    }
}
