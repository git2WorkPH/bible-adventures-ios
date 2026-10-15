import Foundation

struct StoryPresentation: Codable, Equatable {
    let homeIntroduction: String
    let restartName: String
    let reflectionTitle: String
    let completionInvitation: String
    let readingLabel: String
    let readingURL: URL

    static let generic = StoryPresentation(homeIntroduction: "Explore an adventure and return to its Biblical source.", restartName: "adventure", reflectionTitle: "Reflect on the adventure", completionInvitation: "Keep reading the Biblical source.", readingLabel: "Read the Bible (ESV)", readingURL: URL(string: "https://www.esv.org/")!)

    var isValid: Bool {
        [homeIntroduction, restartName, reflectionTitle, completionInvitation, readingLabel].allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } && readingURL.scheme == "https" && readingURL.host == "www.esv.org" && readingURL.user == nil && readingURL.password == nil
    }
}

struct StoryDefinition: Codable {
    let schemaVersion: Int
    let contentVersion: String
    let story: Story
    let presentation: StoryPresentation
    let reflection: ReflectionContent
    let scripture: [ScriptureContent]
    let questions: [QuizQuestion]

    var isValid: Bool {
        guard schemaVersion == 1, !contentVersion.isEmpty, !story.title.isEmpty, !story.description.isEmpty,
              !story.steps.isEmpty, presentation.isValid, reflection.isValid, reflection.scriptureReference.isStructurallyValid,
              Set(questions.map(\.id)).count == questions.count,
              questions.allSatisfy({ !$0.id.isEmpty && !$0.question.isEmpty && $0.options.count >= 2 && $0.options.allSatisfy { !$0.isEmpty } && $0.options.indices.contains($0.correctAnswerIndex) }),
              scripture.allSatisfy({ $0.reference.isStructurallyValid && !$0.text.isEmpty }),
              Set(scripture.map { $0.reference.displayText }).count == scripture.count else { return false }
        var objectiveIDs = Set<String>()
        for step in story.steps {
            switch step {
            case .dialogue(let page):
                guard !page.text.isEmpty, page.reference.isStructurallyValid else { return false }
                if page.kind == .scripture && !scripture.contains(where: { $0.reference == page.reference && $0.text == page.text }) { return false }
            case .objective(let objective):
                guard !objective.id.isEmpty, objectiveIDs.insert(objective.id).inserted, objective.storyId == story.id,
                      !objective.title.isEmpty, !objective.instruction.isEmpty, objective.reference.isStructurallyValid,
                      questions.contains(where: { $0.id == objective.questionId }) else { return false }
                if !objective.scripture.isEmpty && !scripture.contains(where: { $0.reference == objective.reference && $0.text == objective.scripture }) { return false }
            case .miniGame(let activity):
                if activity == .gatherAnimals || activity == .gatherProvisions,
                   StoryActivityConfiguration.matchingPresentation(for: story.id, activity: activity) == nil {
                    return false
                }
            }
        }
        return true
    }

    func question(for id: String) -> Result<QuizQuestion, ContentRepositoryError> {
        guard let item = questions.first(where: { $0.id == id }) else { return .failure(.itemNotFound(id)) }
        return .success(item)
    }

    func quotation(for reference: BibleReference) -> Result<ScriptureContent, ContentRepositoryError> {
        guard let item = scripture.first(where: { $0.reference == reference }) else { return .failure(.itemNotFound(reference.displayText)) }
        return .success(item)
    }
}

extension BibleReference {
    var isStructurallyValid: Bool {
        let chapters: [BibleBook: Int] = [.genesis: 50, .exodus: 40, .leviticus: 27, .numbers: 36, .deuteronomy: 34, .firstSamuel: 31]
        guard let maximumChapter = chapters[book], chapter >= 1, chapter <= maximumChapter else { return false }
        return startVerse > 0 && startVerse <= 176 && (endVerse == nil || (endVerse! >= startVerse && endVerse! <= 176))
    }
}
