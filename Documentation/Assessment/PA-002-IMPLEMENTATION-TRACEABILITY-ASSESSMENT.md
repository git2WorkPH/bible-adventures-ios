# PA-002 — Implementation Traceability Assessment

Status: OPEN
Date: 2026-09-04
Assessment type: Read-only implementation assessment

## Scope and baseline

The repository contains a SwiftUI Noah prototype with dialogue, an objective/Scripture screen, JSON-backed questions, and several Noah-specific mini-game views. `Story`, `StoryID`, and `StoryStep` provide a small reusable content model; the recorded FND-001-T01 model-contract tests cover a generic fixture and Noah representation.

No requirement is recorded as formally approved or verified. The product, foundation, and Noah documents are all marked requirements definitions/drafts, the baseline decisions classify the existing Noah implementation as prototype/reference material, and there is no acceptance-evidence record. Therefore this assessment classifies observed implementation only; it does not change requirement, task, or approval status.

## Requirement classification

| Requirement | Classification | Observed evidence / gap |
|---|---|---|
| PRD-001 | PARTIAL | Dialogue and objectives carry `BibleReference`; one objective invites Scripture reading. There is no approved source/translation policy and displayed text includes source artifacts. |
| PRD-002 | PARTIAL | Noah content and completion language refer to GOD, but there is no reusable GOD-centred reflection outcome. |
| PRD-003 | PARTIAL | Prototype includes dialogue, one objective/question flow, and multiple mini-games. It is Noah-specific and not a complete reusable story capability. |
| PRD-004 | PARTIAL | Reusable story-model types exist, but the player, progression, repository dispatch, and mini-game lifecycle are hard-coded to Noah. |
| PRD-005 | PARTIAL | The app uses SwiftUI, but no iPhone/iPad layout verification is recorded. |
| PRD-006 | NOT_STARTED | `StoryCompleteView` ends the experience without reflection. |
| FND-001 | PARTIAL | Model contract exists; no reusable load/start/progress/complete/restart engine exists. |
| FND-002 | PARTIAL | `StoryPlayerView` owns `currentStep` and completion with `@State`; no foundation Game/Story/Objective/Mini-game state contract exists. |
| FND-003 | PARTIAL | Local sequential success advancement exists only. Conditional, failed, and retryable centrally managed transitions do not. |
| FND-004 | PARTIAL | `BibleReference` and presentation exist. No Scripture repository or approved Scripture-content policy exists. |
| FND-005 | PARTIAL | Dialogue model and view exist; no repository or generic content lifecycle exists. |
| FND-006 | PARTIAL | Objective model/view include instruction, hint, and reference; completion state is not reusable or centrally held. |
| FND-007 | PARTIAL | JSON question model and answer feedback exist, but no reusable question view/lifecycle and no randomized quiz answer order. |
| FND-008 | PARTIAL | Local incorrect-answer/activity feedback exists, not reusable learning-feedback behavior. |
| FND-009 | PARTIAL | `MiniGameView` dispatches Noah enum cases through completion closures. It has no result, failure, retry, or Story Engine contract. |
| FND-010–014 | PARTIAL | Noah has quiz-like, memory-like, puzzle, selection, and measurement interactions, but no reusable frameworks/engines. Measurement has no ruler interaction. |
| FND-015 | NOT_STARTED | No reflection model, view, flow, or tests. |
| FND-016–017 | NOT_STARTED | No story/objective progress model, save, or restore behavior. |
| FND-018 | PARTIAL | Story and question repositories exist, but they are hard-coded and no repositories exist for dialogue, objectives, or Scripture. |
| FND-019 | PARTIAL | Questions are decoded from JSON; stories, dialogue, and objectives remain in Swift source and malformed-content recovery is absent. |
| FND-020 | PARTIAL | Individual animations exist; no reusable pattern or reduced-motion support exists. |
| FND-021–022 | NOT_STARTED | No audio-management or asset-foundation implementation was found. |
| FND-023 | PARTIAL | SwiftUI supplies some baseline accessibility behavior, but no explicit Dynamic Type, VoiceOver, touch-target, or reduced-motion verification exists. |
| FND-024–025 | NOT_STARTED | Repositories use `fatalError`; logging is limited to `print`. |
| FND-026 | PARTIAL | Two Story-model tests exist. Broader foundation tests and a passing test record are absent; environment test execution remains unverified. |
| FND-027 | NEEDS_DECISION | Requirement remains proposed. Code calls `gopher wood` “cypress,” includes unlabelled gameplay/narrative additions, and displays quotation artifacts. |
| NOAH-001–011 | PARTIAL | The prototype has a mostly complete ordered Noah flow and corresponding interactions, but lacks required per-component definitions, success/failure contracts, approved Scripture policy, and reusable foundation integration. |
| NOAH-012 | NOT_STARTED | No post-story Scripture-connected reflection exists. |

## Acceptance evidence

| Acceptance criterion | Assessment |
|---|---|
| Foundation reusable by multiple stories | Not met: `StoryPlayerView` loads `.noah`; repositories and mini-game dispatch enumerate Noah content. |
| Story content not hard-coded in reusable engines | Not met: no reusable engine exists; player and dispatch are coupled to Noah prototype behavior. |
| Central progression source of truth | Not met: view-local `@State` owns progression/completion. |
| References attach to relevant content | Partially evidenced: dialogue and objective models require `BibleReference`; no Scripture repository/policy. |
| Question answer order randomized | Not met: `ScriptureView` renders JSON option order directly. |
| Mini-games return results to Story Engine | Not met: only completion closures return to the view. |
| Failure safe / retryable | Partially evidenced locally; no central failure/result/progression contract. |
| Completion triggers reflection | Not met. |
| Progress saved/restored | Not met. |
| Automated tests where appropriate | Partially evidenced by two model tests; no recorded passing run and no broader foundation tests. |
| iPhone/iPad functional; accessibility respected | Unverified. |
| Scripture-first and GOD-centred spiritual acceptance | Partially evidenced by references and a Scripture-reading objective; not verified because policy, content distinction, and reflection are absent. |
| Biblical facts/inventions clearly distinguished | Not met: FND-027 policy has not been approved, `gopher`/`cypress` is undecided, and gameplay-created narration is not labelled. |

## Stable findings

### PA-002-001 — Prototype progression bypasses the planned foundation boundary

Status: OPEN

Affected requirements: FND-001, FND-002, FND-003, FND-009, PRD-004.

Evidence: `StoryPlayerView` owns step index and completion; `MiniGameView` directly maps every `MiniGameType` case to a Noah view; `StoryRepository` switches to `NoahStory.build()`.

Impact: New stories would duplicate or expand prototype UI control flow rather than reuse a tested foundation.

Recommendation: Follow the already proposed sequence for state, engine, progression, then mini-game lifecycle. Preserve Noah as prototype content until those tasks are approved.

### PA-002-002 — Scripture integrity decision gate remains unresolved

Status: DECISION_REQUIRED

Affected requirements: PRD-001, FND-004, FND-027, NOAH-002, NOAH-009.

Evidence: FND-027 is proposed; Noah content identifies an ESV instruction without an approved policy, contains apparent footnote/source artifacts, and equates `gopher` with `cypress` in dialogue and gameplay.

Impact: The project cannot verify Scripture accuracy or the required distinction between quotation, interpretation, and gameplay representation.

Recommendation: Approve the source/translation, formatting, classification, and `gopher wood` treatment before expanding or presenting Noah as verified content.

### PA-002-003 — Completion does not satisfy the reflection or spiritual-purpose outcome

Status: OPEN

Affected requirements: PRD-002, PRD-006, FND-015, NOAH-012.

Evidence: `StoryCompleteView` provides congratulatory text only; no reflection model, Scripture prompt, or question about GOD is present.

Impact: The app cannot demonstrate that completion encourages players to return to Scripture and reflect on GOD rather than merely finish gameplay.

Recommendation: Retain the existing completion screen as prototype presentation and implement a reusable reflection contract only through an approved task.

### PA-002-004 — Resilience, progress, accessibility, and verification remain foundation gaps

Status: OPEN

Affected requirements: FND-016, FND-017, FND-020, FND-023–026, PRD-005.

Evidence: no persistence/progress model; `fatalError` handles content failures; no structured logging; no reduced-motion implementation; no explicit accessibility validation; tests cover only the story model and no passing test result is recorded.

Impact: Prototype behavior is not safe to classify as production-ready or verified for supported devices.

Recommendation: Address these through the existing proposed quality/persistence tasks after core state and lifecycle dependencies.

## Existing-code disposition

Preserve as prototype/reference: Noah story content and visual interactions, including existing mini-game views.

Adapt when approved: `Story`, `StoryID`, `StoryStep`, `BibleReference`, dialogue/objective/question contracts, and the mini-game dispatch boundary.

Refactor when approved: view-local progression, closure-only mini-game completion, hard-coded repository switching, and embedded Scripture/objective/question coupling.

Do not claim as verified: any requirement or acceptance criterion in this assessment. Existing FND-001-T01 model work is implementation evidence only until automated or accepted manual verification is recorded.

## Proposed task sequence

1. Resolve the documentation/task-status and Scripture-integrity decision gates (FND-BASE-T01/T02).
2. Approve and implement the state, engine, and progression contracts (FND-BASE-T03 through T05).
3. Approve content, objective/question, and mini-game lifecycle boundaries (FND-BASE-T06 through T08).
4. Approve reflection, progress, and persistence (FND-BASE-T09/T10).
5. Approve testing, accessibility/reduced-motion, and error/logging work (FND-BASE-T11 through T13).
6. Assess the Noah prototype against the completed foundation before any story expansion.

## Risks and decisions required

- Decision: approve a Scripture source/translation and display policy, including quotation cleanup and the `gopher wood`/`cypress wood` treatment.
- Decision: reconcile the task record that calls FND-001-T01 complete with its location outside `Tasks/Approved/` and the policy that only approved tasks authorize implementation.
- Risk: hard-coded Noah dispatch and local state will create duplicated story behavior if further stories are added before foundation work.
- Risk: fatal content loading, absent persistence, and absent test/device/accessibility evidence can lose progress or make failures unrecoverable.
