import Foundation

/// Recoverable errors returned by reusable content repositories.
enum ContentRepositoryError: Error, Equatable {
    case missingResource(String)
    case malformedContent(String)
    case invalidContent(String)
    case itemNotFound(String)
}

protocol DialogueContentLoading {
    func dialogue(for identifier: String) -> Result<DialoguePage, ContentRepositoryError>
}

protocol ObjectiveContentLoading {
    func objective(for identifier: String) -> Result<Objective, ContentRepositoryError>
}

/// A direct quotation returned by a Scripture repository.
struct ScriptureContent: Equatable {
    let reference: BibleReference
    let text: String
    let translation: ScriptureTranslation

    init(
        reference: BibleReference,
        text: String,
        translation: ScriptureTranslation = .esv
    ) {
        self.reference = reference
        self.text = text
        self.translation = translation
    }
}

enum ScriptureTranslation: String, Equatable {
    case esv = "ESV"
}

protocol ScriptureContentLoading {
    func scripture(
        for reference: BibleReference
    ) -> Result<ScriptureContent, ContentRepositoryError>
}

protocol ContentDataLoading {
    func loadData() -> Result<Data, ContentRepositoryError>
}

/// A Foundation-only source for one named bundled content resource.
struct BundleContentDataSource: ContentDataLoading {
    let resourceName: String
    let resourceExtension: String
    let bundle: Bundle

    init(
        resourceName: String,
        resourceExtension: String = "json",
        bundle: Bundle = .main
    ) {
        self.resourceName = resourceName
        self.resourceExtension = resourceExtension
        self.bundle = bundle
    }

    func loadData() -> Result<Data, ContentRepositoryError> {
        guard let url = bundle.url(
            forResource: resourceName,
            withExtension: resourceExtension
        ) else {
            return .failure(.missingResource("\(resourceName).\(resourceExtension)"))
        }

        do {
            return .success(try Data(contentsOf: url))
        } catch {
            return .failure(.malformedContent(resourceName))
        }
    }
}
