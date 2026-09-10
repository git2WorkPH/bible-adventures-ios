# Foundation Baseline Decisions

Status: Proposed for project adoption
Date: 2026-08-29

## 1. Authoritative documentation
`Documentation/` is the authoritative project documentation root. Legacy root planning files may remain for history but must not compete with it.

## 2. Prototype versus approved implementation
Existing Noah code is prototype/reference material unless its requirement and acceptance criteria have been verified. Working UI does not automatically mean a requirement is complete.

## 3. Requirement status
- `NOT_STARTED`
- `PARTIAL`
- `IMPLEMENTED_UNVERIFIED`
- `IMPLEMENTED_VERIFIED`
- `OUT_OF_SCOPE`
- `NEEDS_DECISION`

`IMPLEMENTED_VERIFIED` requires satisfied acceptance criteria plus verification evidence.

## 4. Task status
- `PROPOSED`
- `APPROVED`
- `IN_PROGRESS`
- `BLOCKED`
- `IMPLEMENTED`
- `VERIFIED`
- `CANCELLED`

Only `APPROVED` tasks may be implemented.

## 5. Scope control
Codex must not expand an approved task because it discovers adjacent improvements. New work must be reported as a finding, proposed requirement change, or proposed task for approval.

## 6. Foundation-first principle
Reusable systems are established before expanding stories. Initial dependency direction:

Story Engine -> Story State -> Progression -> Content/Objective/Question contracts -> Mini-game lifecycle -> Completion -> Reflection -> Progress/Persistence.

## 7. Noah disposition
### Preserve as prototype/reference
- `NoahStory`
- existing visual interactions during initial foundation work

### Adapt into foundation when approved
- `Story`, `StoryID`, `StoryStep`, `DialoguePage`, `BibleReference`, `Objective`, question models, mini-game dispatch boundary

### Keep Noah-specific
- Genesis content and ark/animal/food/flood/dove/rainbow details

### Refactor
- `StoryPlayerView` local progression
- closure-only mini-game lifecycle
- embedded objective/Scripture/question coupling
- hard-coded repository behavior

### Replace when approved
- unused duplicate `MiniGame` enum
- duplicate covenant/rainbow implementation
- obsolete prototype paths

## 8. Scripture integrity
Before expanding Noah content, define a Scripture source/translation policy. The game must distinguish: (1) Scripture, (2) interpretation, and (3) gameplay representation. Uncertain interpretations must not be presented as direct Biblical statements. The `gopher wood` / `cypress wood` issue is a content decision, not an implementation task.

## 9. Verification
A feature is not complete merely because it exists, compiles, or works manually once. Appropriate acceptance evidence is required, including automated tests where applicable.

## 10. Decision gate
Before foundation implementation begins: reconcile documentation authority, approve Scripture policy, reconcile task status, and approve the initial foundation sequence.
