import Foundation
import Testing
@testable import BibleAdventure

struct ProgressPersistenceTests {
    final class MemoryStorage: ProgressDataStoring {
        var data: Data?
        var loadError: ProgressStorageError?

        func load() -> Result<Data?, ProgressStorageError> {
            loadError.map(Result.failure) ?? .success(data)
        }

        func save(_ data: Data) -> Result<Void, ProgressStorageError> {
            self.data = data
            return .success(())
        }
    }

    func fixture() -> PlayerProgress {
        PlayerProgress(stories: [
            StoryProgress(
                storyID: .noah,
                currentStepIndex: nil,
                status: .completed,
                objectives: [ObjectiveProgress(objectiveID: "read-source", status: .completed)]
            ),
            StoryProgress(
                storyID: .moses,
                currentStepIndex: 2,
                status: .active,
                objectives: [ObjectiveProgress(objectiveID: "first-step", status: .active)]
            )
        ])
    }

    @Test func roundTripRestoresStoryAndObjectiveProgress() throws {
        let storage = MemoryStorage()
        let service = ProgressPersistenceService(storage: storage)
        let original = fixture()
        let saved = service.save(original)
        guard case .success = saved else {
            Issue.record("Expected progress save to succeed")
            return
        }
        let restored = service.restore()
        #expect(restored == .restored(original))
        #expect(restored.progress.story(.moses)?.currentStepIndex == 2)
        #expect(restored.progress.story(.noah)?.objectives.first?.status == .completed)
    }

    @Test func missingStateReturnsSafeEmptyProgress() {
        let result = ProgressPersistenceService(storage: MemoryStorage()).restore()
        #expect(result == .empty(PlayerProgress()))
        #expect(result.progress.stories.isEmpty)
    }

    @Test func corruptedAndUnavailableStateRecoverSafely() {
        let corrupted = MemoryStorage()
        corrupted.data = Data("not-json".utf8)
        let corruptResult = ProgressPersistenceService(storage: corrupted).restore()
        #expect(corruptResult == .recovered(PlayerProgress(), reason: .corruptedData))

        let unavailable = MemoryStorage()
        unavailable.loadError = .unavailable
        let unavailableResult = ProgressPersistenceService(storage: unavailable).restore()
        #expect(unavailableResult == .recovered(PlayerProgress(), reason: .unreadableStorage))
    }

    @Test func unlocksUseOnlyGameplayCompletion() {
        let progress = fixture()
        #expect(progress.isUnlocked(by: .available))
        #expect(progress.isUnlocked(by: .storyCompleted(.noah)))
        #expect(!progress.isUnlocked(by: .storyCompleted(.david)))
    }
}
