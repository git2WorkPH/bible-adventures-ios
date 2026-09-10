import Foundation

struct ObjectiveProgress: Codable, Equatable {
    enum Status: String, Codable { case active, completed }

    let objectiveID: String
    let status: Status
}

struct StoryProgress: Codable, Equatable {
    enum Status: String, Codable { case active, completed }

    let storyID: StoryID
    let currentStepIndex: Int?
    let status: Status
    let objectives: [ObjectiveProgress]
}

/// Saveable gameplay progress. It records visited/completed activities only;
/// it does not represent spiritual understanding, growth, or achievement.
struct PlayerProgress: Codable, Equatable {
    static let currentSchemaVersion = 1

    let schemaVersion: Int
    let stories: [StoryProgress]

    init(stories: [StoryProgress] = []) {
        schemaVersion = Self.currentSchemaVersion
        self.stories = stories
    }

    fileprivate var isValid: Bool {
        guard schemaVersion == Self.currentSchemaVersion,
              Set(stories.map(\.storyID)).count == stories.count
        else { return false }

        return stories.allSatisfy { story in
            let objectiveIDs = story.objectives.map(\.objectiveID)
            let hasValidStep = story.currentStepIndex.map { $0 >= 0 } ?? true
            let completionHasNoCurrentStep = story.status != .completed || story.currentStepIndex == nil
            return hasValidStep && completionHasNoCurrentStep &&
                objectiveIDs.allSatisfy { !$0.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty } &&
                Set(objectiveIDs).count == objectiveIDs.count
        }
    }

    func story(_ storyID: StoryID) -> StoryProgress? {
        stories.first { $0.storyID == storyID }
    }
}

enum StoryUnlockRule: Equatable {
    case available
    case storyCompleted(StoryID)
}

extension PlayerProgress {
    /// Unlocks are based only on explicit gameplay completion prerequisites.
    func isUnlocked(by rule: StoryUnlockRule) -> Bool {
        switch rule {
        case .available:
            return true
        case .storyCompleted(let prerequisite):
            return story(prerequisite)?.status == .completed
        }
    }
}

enum ProgressStorageError: Error, Equatable {
    case unavailable
    case writeFailed
}

protocol ProgressDataStoring {
    func load() -> Result<Data?, ProgressStorageError>
    func save(_ data: Data) -> Result<Void, ProgressStorageError>
}

enum ProgressRecoveryReason: Equatable {
    case unreadableStorage
    case corruptedData
    case unsupportedOrInvalidProgress
}

enum ProgressRestoreResult: Equatable {
    case restored(PlayerProgress)
    case empty(PlayerProgress)
    case recovered(PlayerProgress, reason: ProgressRecoveryReason)

    var progress: PlayerProgress {
        switch self {
        case .restored(let progress), .empty(let progress), .recovered(let progress, _):
            return progress
        }
    }
}

/// JSON persistence boundary with deterministic safe-default recovery.
struct ProgressPersistenceService {
    private let storage: any ProgressDataStoring
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init(
        storage: any ProgressDataStoring,
        encoder: JSONEncoder = JSONEncoder(),
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.storage = storage
        self.encoder = encoder
        self.decoder = decoder
    }

    func restore() -> ProgressRestoreResult {
        switch storage.load() {
        case .failure:
            return .recovered(PlayerProgress(), reason: .unreadableStorage)
        case .success(nil):
            return .empty(PlayerProgress())
        case .success(.some(let data)):
            guard let progress = try? decoder.decode(PlayerProgress.self, from: data) else {
                return .recovered(PlayerProgress(), reason: .corruptedData)
            }
            guard progress.isValid else {
                return .recovered(PlayerProgress(), reason: .unsupportedOrInvalidProgress)
            }
            return .restored(progress)
        }
    }

    func save(_ progress: PlayerProgress) -> Result<Void, ProgressStorageError> {
        guard progress.isValid, let data = try? encoder.encode(progress) else {
            return .failure(.writeFailed)
        }
        return storage.save(data)
    }
}
