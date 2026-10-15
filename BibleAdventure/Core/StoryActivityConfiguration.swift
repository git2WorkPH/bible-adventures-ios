import Foundation

/// Story-specific content may select a compiled activity presentation.
/// JSON identifies the activity; it never provides executable behavior.
enum StoryActivityConfiguration {
    static func matchingPresentation(for storyID: StoryID, activity: MiniGameType) -> PairMatchingPresentation? {
        switch (storyID, activity) {
        case (.noah, .gatherAnimals): NoahMatchingGame.configuration
        case (.david, .gatherProvisions): DavidMatchingGame.configuration
        default: nil
        }
    }
}
