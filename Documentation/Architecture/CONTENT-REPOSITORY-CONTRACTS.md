# Content Repository Contracts

Status: IMPLEMENTED_UNVERIFIED
Task: FND-BASE-T06

## Reusable contracts

| Contract | Responsibility |
|---|---|
| `StoryLoading` | Load one story by stable `StoryID`. |
| `DialogueContentLoading` | Load dialogue by a content identifier. |
| `ObjectiveContentLoading` | Load objectives by a content identifier. |
| `QuestionContentLoading` | Load a validated collection or one question by identifier. |
| `ScriptureContentLoading` | Load ESV Scripture content for a Bible reference. |
| `ContentDataLoading` | Supply raw external content data without tying repositories to Bundle or a story. |

All repository operations return `Result<Content, ContentRepositoryError>`. Expected missing, malformed, invalid, and not-found content is recoverable; no repository contract terminates the application.

## External-content boundary

The reusable boundary is an injected `ContentDataLoading` source. `QuestionRepository` implements JSON decoding and validation behind that boundary. `BundleContentDataSource` is the current Foundation adapter for one named JSON resource. Story-specific resource selection belongs to each story layer; `NoahQuestionRepository` is the current Noah adapter.

Stories, dialogue, objectives, and Scripture have repository contracts but remain in their existing prototype content forms. Their JSON migration is explicitly deferred. This preserves existing Noah content while allowing future approved content sources to conform to the same contracts.

## Scripture policy boundary

`ScriptureContent` carries a `BibleReference`, exact text, and the only approved direct-quotation translation: ESV. Any future source must apply `SCRIPTURE-INTEGRITY-POLICY.md`: exact ESV text, chapter-and-verse citation, `(ESV)` attribution, and the required content labels. This task does not migrate or certify existing Noah quotations.

## Validation and recovery

Question JSON is rejected when it is malformed, has empty/duplicate identifiers, has fewer than two answers, or identifies an answer outside its option list. Invalid resource configuration and missing content return typed errors. The presentation layer may provide user-safe recovery without receiving a fatal error.
