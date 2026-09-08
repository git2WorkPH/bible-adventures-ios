import Foundation

/// Story-neutral content for a post-story reflection. Reflection copy is
/// interpretation, while `scriptureReference` points back to the Biblical
/// source without embedding or paraphrasing a quotation.
struct ReflectionContent: Equatable {
    let id: String
    let prompt: String
    let scriptureReference: BibleReference

    var isValid: Bool {
        !id.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !prompt.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

/// Values a reusable view needs to present reflection and Scripture as
/// distinct content under the approved Scripture integrity policy.
struct ReflectionPresentation: Equatable {
    let reflectionLabel = "Interpretation"
    let prompt: String
    let godCenteredQuestion = "What does this story teach you about GOD?"
    let scriptureReference: BibleReference

    var scriptureLabel: String {
        "Scripture — \(scriptureReference.displayText) (ESV)"
    }
}

/// A post-completion reflection lifecycle. Finishing this session records only
/// that the opportunity was completed; it makes no claim about spiritual
/// understanding or achievement.
struct ReflectionSession {
    enum Status: Equatable {
        case ready
        case active
        case completed
    }

    let content: ReflectionContent
    private(set) var status: Status = .ready

    /// Completion handoff: reflection is available only after StoryEngine has
    /// completed its configured story.
    static func afterStoryCompletion(
        engine: StoryEngine,
        content: ReflectionContent
    ) -> ReflectionSession? {
        guard engine.isCompleted, content.isValid else { return nil }
        return ReflectionSession(content: content)
    }

    mutating func start() -> ReflectionPresentation? {
        guard status == .ready else { return nil }
        status = .active
        return ReflectionPresentation(
            prompt: content.prompt,
            scriptureReference: content.scriptureReference
        )
    }

    @discardableResult
    mutating func complete() -> Bool {
        guard status == .active else { return false }
        status = .completed
        return true
    }
}
