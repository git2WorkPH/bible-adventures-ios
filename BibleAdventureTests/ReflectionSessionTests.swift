import Testing
@testable import BibleAdventure

struct ReflectionSessionTests {
    struct Loader: StoryLoading {
        func story(for id: StoryID) -> Result<Story, ContentRepositoryError> {
            let page = DialoguePage(
                speaker: .narrator,
                text: "Fixture",
                reference: BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: nil)
            )
            return .success(Story(id: id, title: "Fixture", description: "Generic", steps: [.dialogue(page)]))
        }
    }

    let content = ReflectionContent(
        id: "fixture-reflection",
        prompt: "Think about the story and its Biblical source.",
        scriptureReference: BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: 3)
    )

    func engine(completed: Bool) -> StoryEngine {
        var engine = StoryEngine(loader: Loader())
        engine.start(storyID: .moses)
        if completed { engine.apply(outcome: .success) }
        return engine
    }

    @Test func completedStoryHandsOffToReflection() throws {
        let completedEngine = engine(completed: true)
        var session = try #require(
            ReflectionSession.afterStoryCompletion(engine: completedEngine, content: content)
        )
        let startedPresentation = session.start()
        let presentation = try #require(startedPresentation)
        #expect(presentation.prompt == content.prompt)
        #expect(presentation.godCenteredQuestion == "What does this story teach you about GOD?")
        #expect(session.status == .active)
    }

    @Test func activeStoryCannotStartReflection() {
        let activeEngine = engine(completed: false)
        let session = ReflectionSession.afterStoryCompletion(engine: activeEngine, content: content)
        #expect(session == nil)
    }

    @Test func presentationSeparatesReflectionFromScripture() throws {
        let completedEngine = engine(completed: true)
        var session = try #require(
            ReflectionSession.afterStoryCompletion(engine: completedEngine, content: content)
        )
        let startedPresentation = session.start()
        let presentation = try #require(startedPresentation)
        #expect(presentation.reflectionLabel == "Interpretation")
        #expect(presentation.scriptureLabel == "Scripture — Genesis 1:1-3 (ESV)")
        #expect(presentation.scriptureReference == content.scriptureReference)
    }

    @Test func invalidAndRepeatedLifecycleActionsAreSafe() throws {
        let completedEngine = engine(completed: true)
        let invalid = ReflectionContent(id: " ", prompt: "", scriptureReference: content.scriptureReference)
        let rejected = ReflectionSession.afterStoryCompletion(engine: completedEngine, content: invalid)
        #expect(rejected == nil)

        var session = try #require(
            ReflectionSession.afterStoryCompletion(engine: completedEngine, content: content)
        )
        let earlyCompletion = session.complete()
        #expect(earlyCompletion == false)
        let firstPresentation = session.start()
        #expect(firstPresentation != nil)
        let repeatedStart = session.start()
        #expect(repeatedStart == nil)
        let firstCompletion = session.complete()
        let repeatedCompletion = session.complete()
        #expect(firstCompletion)
        #expect(repeatedCompletion == false)
        #expect(session.status == .completed)
    }
}
