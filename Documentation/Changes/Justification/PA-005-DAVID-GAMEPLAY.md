# PA-005 David and Goliath gameplay justification

Date: 2026-10-16. Status: IN_PROGRESS.

## Authorization and scope

The owner asked to “implement david gameplay.” Approved scope is PA-005-T01 through T04 in `../../Tasks/Approved/PA-005-APPROVED-TASKS.md`, based on the existing David requirements and design decision. The change delivers a second reviewed story through the existing configured runtime. It excludes accounts, cloud synchronization, telemetry, audio, publication, and unrelated mechanics.

## Observed state and approach

PA-004 already provides a versioned `StoryDefinition`, a reviewed Noah JSON story, catalogue entries, per-story `PlayerProgress`, and reusable pair-matching rules. The home screen still starts the first catalogue entry and the matching dispatch is tied to Noah. Add First Samuel structural validation, a David matching configuration, a validated `david_story.json`, and a reviewed catalogue choice. Route the matching presentation through the current runtime rather than adding a David-specific engine.

David content uses narrator interpretation and source references only; no new direct ESV quotation is added. The provisions matching activity is explicitly labelled as a game activity. The outcome is brief and non-graphic. Existing Noah content, activity IDs, `noah-2` save identity, tests, and gameplay behavior remain supported.

## Compatibility, tests, and recovery

`david-1` is a new story identity. `PlayerProgress` remains unchanged and stores separate Noah/David snapshots. Missing or malformed David JSON remains a recoverable unavailable-story condition; it must not overwrite another story's save. Add content/runtime/persistence and activity-dispatch tests, retain existing Noah assertions, and run relevant unit and full-flow device checks. Evidence and any limitations are recorded under `Documentation/Acceptance/`.

## Removals

No files, APIs, tests, save data, or gameplay behaviors are approved for removal. Existing Noah matching wrapper remains as compatibility presentation while dispatch becomes story-configured.
