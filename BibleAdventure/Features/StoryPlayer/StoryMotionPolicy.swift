import SwiftUI

private struct StoryReduceMotionKey: EnvironmentKey {
    static let defaultValue = false
}

extension EnvironmentValues {
    var storyReduceMotion: Bool {
        get { self[StoryReduceMotionKey.self] }
        set { self[StoryReduceMotionKey.self] = newValue }
    }
}
