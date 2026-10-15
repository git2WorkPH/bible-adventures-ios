import Foundation

/// Validates the complete document before exposing any executable steps.
struct StoryDefinitionRepository: StoryLoading {
    let result: Result<StoryDefinition, ContentRepositoryError>

    init(dataSource: any ContentDataLoading) {
        result = dataSource.loadData().flatMap { data in
            do {
                let definition = try JSONDecoder().decode(StoryDefinition.self, from: data)
                guard definition.isValid else { return .failure(.invalidContent("story-definition")) }
                return .success(definition)
            } catch {
                return .failure(.malformedContent("story-definition"))
            }
        }
    }

    func story(for id: StoryID) -> Result<Story, ContentRepositoryError> {
        result.flatMap { definition in
            guard definition.story.id == id else { return .failure(.itemNotFound(id.rawValue)) }
            return .success(definition.story)
        }
    }
}

struct StoryCatalogueEntry: Identifiable {
    let id: StoryID
    let title: String
    let resourceName: String
    func makeRuntime(storage: any ProgressDataStoring = LocalProgressStorage.application, bundle: Bundle = .main) -> StoryRuntimeCoordinator {
        var selectedStorage = storage
        #if DEBUG
        if ProcessInfo.processInfo.environment["BIBLE_ADVENTURE_UI_TEST"] == "1" {
            selectedStorage = LocalProgressStorage(url: FileManager.default.temporaryDirectory.appendingPathComponent("story-ui-progress.json"))
        }
        #endif
        let repository = repository(bundle: bundle)
        let definition = try? repository.result.get()
        return StoryRuntimeCoordinator(storyID: id, loader: repository,
            questionLookup: { definition?.question(for: $0) ?? .failure(.missingResource(resourceName)) },
            scriptureLookup: { definition?.quotation(for: $0) ?? .failure(.missingResource(resourceName)) },
            reflectionContent: definition?.reflection ?? ReflectionContent(id: "unavailable", prompt: "Read the Biblical source.", scriptureReference: BibleReference(book: .genesis, chapter: 1, startVerse: 1, endVerse: nil)),
            contentVersion: definition?.contentVersion ?? "unavailable", storage: selectedStorage,
            presentation: definition?.presentation ?? .generic)
    }

    func repository(bundle: Bundle = .main) -> StoryDefinitionRepository {
        StoryDefinitionRepository(dataSource: BundleContentDataSource(resourceName: resourceName, bundle: bundle))
    }
}

/// Only reviewed and delivered stories appear in the production catalogue.
enum StoryCatalogue {
    static let entries = [
        StoryCatalogueEntry(id: .noah, title: "Noah's Ark", resourceName: "noah_story"),
        StoryCatalogueEntry(id: .david, title: "David and Goliath", resourceName: "david_story")
    ]

    static func entry(for storyID: StoryID) -> StoryCatalogueEntry? {
        entries.first { $0.id == storyID }
    }
}
