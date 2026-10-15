# PA-004 story composition and reuse

Date: 2026-10-04. Status: APPROVED under owner approval of PA-004 and necessary in-scope follow-ups. Tasks T01–T03.

Use a version-1 Codable StoryDefinition document containing story/steps, content version, player reading/navigation metadata, reflection, reviewed Scripture records and questions. Story steps use explicit tagged fields (kind plus dialogue/objective/activity), not implicit enum payload keys. Existing typed mini-game IDs continue mapping to Swift mechanics; JSON cannot execute code. Reject missing/unknown fields required for operation, unknown kinds/activity IDs, duplicate objective/question identities, inconsistent story IDs, malformed references, invalid questions, missing/contradictory quoted text and unsupported schema versions. Reference validation checks structure/ranges within currently supported books; canonical source correctness remains editorial review, not inferred by numeric validation.

Provide one validated loader boundary and inject definition metadata into shared home/player/reflection. The production catalogue exposes only Noah; alternate definitions are synthetic test fixtures. Preserve all 26 Noah steps/text and noah-2 content identity exactly. Missing/malformed documents must surface recovery and never silently substitute an executable story.

Preserve PlayerProgress schema and existing per-story entries. There remains one selected active runtime; selecting/restarting a story updates that story's snapshot while retaining other entries, as the existing service already does. Do not add save slots or change noah-2 indices/objective IDs. Incompatible content versions keep existing explicit New Adventure recovery; unknown/unreadable saves are retained. This requires no migration for the unchanged Noah configuration. Any later changed sequencing must bump content version and record compatibility rules.

Choose pair matching for T03 because Noah already requires selection, mismatch retry and completion and it can be independently tested with distinct item sets. Extract rules/session state from presentation and inject item labels/symbols. Preserve 16 Noah pairs, single selection, mismatch delay, completion and existing typed mini-game handoff. No David gameplay is shipped by this extraction.

Owner selected David and Goliath for T04 on 2026-10-04. Requirements/content design uses 1 Samuel 17 and Scripture policy; new-story implementation remains a separate proposal under T04 scope.
