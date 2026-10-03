# Progress and persistence contract

Status: VERIFIED
Task: FND-BASE-T10
Requirements/findings: FND-016, FND-017; PA-002-004.

## Saveable progress

`PlayerProgress` is a versioned, Codable gameplay snapshot containing zero or more `StoryProgress` records. Story progress contains its `StoryID`, active step when applicable, gameplay status, and uniquely identified `ObjectiveProgress` records. Completed stories have no current step. Duplicate story/objective identities, negative step indexes, and unsupported schema versions are invalid.

The names and values record only application activity: `active` and `completed`. They do not measure Biblical understanding, faith, spiritual growth, or spiritual achievement.

## Unlock rules

`StoryUnlockRule` supports content that is immediately available or requires explicit completion of another story. `PlayerProgress.isUnlocked(by:)` evaluates only those gameplay records. Story availability does not imply spiritual status, and no score, ranking, analytics, or hidden engagement criterion is part of the rule.

## Persistence boundary and recovery

`ProgressDataStoring` is the injected raw-data boundary. A platform adapter may later implement local file or preferences storage. Cloud sync, accounts, and a production storage choice are outside T10.

`ProgressPersistenceService` encodes and decodes JSON:

- valid data returns `restored`;
- no saved data returns `empty` with new default progress;
- unreadable storage, malformed JSON, unsupported versions, and semantically invalid progress return `recovered` with new default progress and a typed reason; and
- saving invalid progress or encoding failure returns a typed write failure.

Recovery does not automatically overwrite the unreadable value. The caller can present a safe recovery path and decide when a new valid snapshot should be saved.

## Integration boundary

Coordinators may translate Story Engine and objective lifecycle state into these snapshots at explicit save points and use restored values when constructing a future runtime session. T10 does not mutate Story Engine internals or replace the prototype's view-local state; runtime hydration requires separately approved integration work.
