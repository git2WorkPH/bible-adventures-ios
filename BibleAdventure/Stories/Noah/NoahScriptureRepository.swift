import Foundation

struct NoahScriptureRepository: ScriptureContentLoading {
    func scripture(for reference: BibleReference) -> Result<ScriptureContent, ContentRepositoryError> {
        guard reference == NoahStory.reference(6, 14) else { return .failure(.itemNotFound("noah-scripture")) }
        return .success(ScriptureContent(reference: reference, text: NoahStory.woodScripture, translation: .esv))
    }
}
