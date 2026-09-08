# Recoverable error and structured logging contract

Status: VERIFIED
Task: FND-BASE-T13
Requirements/findings: FND-024, FND-025; PA-002-004.

## Error boundary

`ApplicationError` is the reusable application boundary for typed content, gameplay, and temporary-availability failures. `GameplayError` identifies invalid configuration, invalid lifecycle state, and rejected outcomes. Existing `ContentRepositoryError` remains the repository source for missing, malformed, invalid, and not-found content.

Expected failures remain values returned through `Result`; they do not terminate the process. `RecoverableContentHandler` passes successful repository values through unchanged and converts a failure into a `UserFacingError` while recording its structured diagnostic event.

The approved repository/lifecycle paths contained no active `fatalError`, `preconditionFailure`, or forced process termination at implementation time, so T13 did not remove unrelated prototype code. Future work in these paths must use typed failure and recovery rather than introduce fatal handling for expected conditions.

## User-safe recovery

User-facing errors contain a short title, generic message, and supported recovery actions (`retry` and/or `returnToStory`). They never interpolate resource names, decoder output, file paths, internal identifiers, underlying error descriptions, or stack information.

- Missing/not-found content may retry or return to the story.
- Malformed/invalid content returns to the story because repeating the same local decode is not expected to repair it.
- Gameplay errors may retry or return to the story.
- Temporary application unavailability may retry.

Presentation owns accessible error announcement, focus, and controls. The domain boundary owns the typed error and allowed recovery actions. Recovery actions do not silently advance Story Engine state.

## Structured logging conventions

`FoundationLogger` writes `StructuredLogEvent` through injected `StructuredLogWriting`. The event contains an allow-listed level, category, stable error code, operation, and metadata dictionary. This seam supports unit tests and a future platform logger without coupling Foundation code to external telemetry.

Stable codes use category prefixes such as `content.malformed` and `gameplay.invalid_state`. Operations are typed (`contentLoad`, `contentDecode`, `storyStart`, `activityResult`). Production events may include the fixed `StoryID`; content identifiers are development-only. Free-form log messages, user-entered content, answers, Scripture text, personal data, tokens, file contents, and underlying error strings are prohibited in every mode.

Development mode may include allow-listed content identifiers needed to locate bundled/configured content. Production mode omits them. Neither mode collects user data or sends events externally. A future concrete writer must preserve these fields and privacy rules, choose appropriate OS log privacy controls, and avoid adding unreviewed metadata.

## Severity and environment behavior

- `error`: an operation failed and a recovery path is returned; used by the current handler.
- `warning`: a recoverable degradation that still provides the requested experience.
- `info`: lifecycle diagnostics useful for development, never high-volume user behavior tracking.

Production logging must be sparse and actionable. Development logging may be more detailed only within the allow list. Logging failure must never block the recovery path or change gameplay behavior.

## Deferred work

T13 does not add an OSLog adapter, telemetry, analytics, accounts, user-data collection, or UI. Existing `print` calls in prototype views and error handling outside the approved repository/lifecycle boundary remain separate cleanup/integration work and are not changed here.
