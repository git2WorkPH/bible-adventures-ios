import SwiftUI

struct SplashView: View {
    @Environment(\.accessibilityReduceMotion) private var reduceMotion
    @Environment(\.dynamicTypeSize) private var typeSize
    var body: some View {
        #if DEBUG
        ContentView()
            .environment(\.storyReduceMotion, reduceMotion || ProcessInfo.processInfo.environment["UI_TEST_REDUCE_MOTION"] == "1")
            .environment(\.dynamicTypeSize, ProcessInfo.processInfo.environment["UI_TEST_LARGEST_TEXT"] == "1" ? .accessibility5 : typeSize)
        #else
        ContentView().environment(\.storyReduceMotion, reduceMotion)
        #endif
    }
}
