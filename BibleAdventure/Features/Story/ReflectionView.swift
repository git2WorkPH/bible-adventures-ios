import SwiftUI

struct ReflectionView: View {
    let runtime: StoryRuntimeCoordinator

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                Text(runtime.reflectionCompleted ? "Adventure complete" : "Reflect on Noah")
                    .font(.largeTitle).accessibilityAddTraits(.isHeader)
                Text("You explored Noah's story. Keep reading Genesis 6–9 in your Bible.")
                if let presentation = runtime.reflectionPresentation {
                    Text(presentation.reflectionLabel).font(.headline)
                    Text(presentation.prompt)
                    Text(presentation.godCenteredQuestion).font(.title2)
                    Text("Bible reading: \(presentation.scriptureReference.displayText)").font(.headline)
                    Text("The reflection prompts are interpretation. Read the passage for the Biblical source.")
                }
                Link("Read Genesis 6–9 (ESV)", destination: URL(string: "https://www.esv.org/Genesis+6/")!).frame(minHeight: 44)
                if !runtime.reflectionCompleted {
                    Button("Finish reflection") { runtime.finishReflection() }.buttonStyle(.borderedProminent).frame(minHeight: 44)
                }
                DisclosureGroup("Scripture attribution") {
                    Text(ScriptureAttribution.notice).font(.caption)
                    Link("ESV permissions", destination: URL(string: "https://www.crossway.org/permissions/")!).frame(minHeight: 44)
                }.frame(minHeight: 44)
            }.padding()
        }
    }
}

enum ScriptureAttribution {
    static let notice = "Scripture quotations are from the ESV® Bible (The Holy Bible, English Standard Version®), © 2001 by Crossway, a publishing ministry of Good News Publishers. ESV Text Edition: 2025. The ESV text may not be quoted in any publication made available to the public by a Creative Commons license. The ESV may not be translated in whole or in part into any other language. Used by permission. All rights reserved."
}
