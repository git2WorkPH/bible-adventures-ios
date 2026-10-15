# PA-005 technical handover — David and Goliath

Date: 2026-10-16. Phase status: APPROVED, IN_PROGRESS. Owner authorized “implement david gameplay” on 2026-10-16. Approval record: [PA-005 approved tasks](../Tasks/Approved/PA-005-APPROVED-TASKS.md). Proposal/history: [PA-005 tasks](../Tasks/Proposed/PA-005-DAVID-IMPLEMENTATION.md).

## Current checkpoint — 2026-10-16

Implementation covers T01–T03: `BibleBook.firstSamuel`; `gatherProvisions`; compiled `DavidMatchingGame` and safe story/activity matching dispatch; David catalogue entry/Home selection; `david_story.json` (`david-1`); and `DavidStoryTests`/`DavidFlowTests`. Content is narrator interpretation, no new direct ESV quotation; provisions matching is labelled Game activity. Existing Noah JSON, `noah-2`, progress structure, and activities are retained. Passing evidence: 55 unit tests at `/private/tmp/BibleAdventure-PA005-units-v1.xcresult`; David UI flow on iPhone 17 Pro/iOS 26.1 and iPad Air 11-inch (M3)/iPadOS 26.1; Noah full regression on iPhone 17 Pro/iOS 26.1. Exact paths: `../Acceptance/PA-005-T01-T03-TEST-EVIDENCE.md`. Content audit: `../Acceptance/PA-005-T02-CONTENT-AUDIT.md`; rationale: `../Changes/Justification/PA-005-DAVID-GAMEPLAY.md`. Next: record only actual manual VoiceOver, OS Reduce Motion and compact iPad results for David; do not infer them from UI tests. No running command. PA-004/PA-005 was committed at `79c7676`, merged and synchronized at `d7920a6`; only personal Xcode state files and the preserved stash remain local.

## Inputs and scope

Owner chose David and Goliath. Requirements: [DAVID-REQUIREMENTS.md](../Requirements/Stories/David/DAVID-REQUIREMENTS.md). Design: [DAVID-CONTENT-DESIGN.md](../Architecture/Decisions/DAVID-CONTENT-DESIGN.md). Source: 1 Samuel 17 (ESV). Read Scripture Integrity Policy and Project documents before significant work. Maintain the requirements -> assessment -> finding -> decision -> proposed task -> approval -> implementation -> test -> review -> verified -> session-memory workflow.

PA-004 supplies validated story JSON and injected player metadata, plus reusable pair matching. Complete PA-004 acceptance before treating those capabilities as a verified baseline. No new engine, accounts/cloud/telemetry, audio framework or public release is needed for David.

## T01 — Foundation and composition support

Files: Core/Models/BibleBook.swift, StoryDefinition.swift, StoryStep.swift, MiniGameType.swift; Core/Repository/StoryDefinitionRepository.swift; Core/StoryRuntimeCoordinator.swift; Features/Home/ContentView.swift; Features/MiniGame/MiniGameView.swift and PairMatchingView.swift.

Steps:
1. Inspect final PA-004 implementation/evidence, current branches and uncommitted work.
2. Add First Samuel and structurally valid chapter/reference support after checking the canonical range; add malformed/out-of-range tests.
3. Record how an activity step chooses story-specific matching configuration. Version1 currently holds only typed MiniGameType and Noah's wrapper supplies its configuration. Define an explicit contract/version compatibility; keep Noah noah-2 and existing IDs unchanged. Do not route David through Noah animal copy.
4. Expose selection from reviewed StoryCatalogue entries; create one selected runtime. Keep per-story snapshots and retain errors/saves rather than replacing them silently.

Acceptance: configured matching works for two story definitions through the same rule/view implementation; invalid/unknown configuration fails before progression; story switching/restarting does not discard another story's snapshot; old Noah saves restore; domain/content/persistence tests and complete Noah regression pass. Record the new schema/activity interface and recovery decision.

## T02 — Reviewed David content

Files to create: Stories/David configuration and Resource/Stories/David/david_story.json; Acceptance/PA-005-T02-CONTENT-AUDIT.md. Initial proposed content identity david-1; no old David saves currently exist.

Steps: finalize a complete ordered component list from DAV-001–008; include three-category provisions matching, four questions, narrator interpretation, reading destination and reflection. Record every text/symbol/source/label row. Avoid exact ESV quotations unless copied and reviewed under policy with attribution/permissions. If no new quotations, still review interpretation/source accuracy. Use no graphic combat or timer. Maintain source-supported armor explanation and truthful brief outcome.

Acceptance: complete content/source/label audit passes; every question has one supported answer, source hint and retry feedback; no invented certainty or guaranteed-victory message; reflection connects to GOD/source reading. Agent source review and owner acceptance are recorded distinctly. Only reviewed content becomes a production catalogue entry.

## T03 — Story runtime/progress integration

Reuse StoryRuntimeCoordinator, StoryEngine, ObjectiveQuestionSession, MiniGameAdapter, ReflectionSession and LocalProgressStorage. Synthetic fixtures stay test-only. Load David through the same validated definition repository; add catalogue entry only with reviewed content.

Acceptance tests: full ordered story completion; wrong answer/retry; matching mismatch/retry and once-only handoff; stale activity callbacks after restart; interruption/relaunch at every boundary; pending/completed reflection restore; Noah/David switching and restart; missing/malformed/incompatible content and corrupt/write-failed saves. Ensure content version and objective/step identities remain stable after acceptance. Reject incompatible indices explicitly if future sequence changes. Record actual test counts and result paths.

## T04 — Device acceptance and closeout

Run complete David flow and Noah regression using named iPhone/iPad models and OS versions. Include default/largest text, portrait/landscape, compact iPad window, actual OS Reduce Motion, VoiceOver reading/focus order, accessible labels and non-color selection, reachable44-point controls, error/retry and reflection/source link. Simulator policy flags are not proof of actual OS assistive technology behavior. Record manual owner results separately and do not reuse Noah's historical confirmation as David verification.

Acceptance: all required checks pass with retained evidence and source/build identity; bounded fixes retested; content audit accepted; requirements/task statuses trace to evidence; handover/session memory and Completed records updated. Do not label unfinished manual criteria VERIFIED. No publication is included.

## Verification tools and baseline locations

Use the shared BibleAdventure scheme/project and filesystem-synchronized sources. Existing unit target BibleAdventureTests; UI target BibleAdventureUITests. NoahFlowTests is the full regression harness; keep game assertions and44-point target criterion. Add David flow checks for the new configured sequence.

Known destinations (verify still available): iPhone 17 Pro26.5 D1B4A041-95AD-48DE-A05B-8E70B8148510; iPhone 17 Pro26.1 3F0029BB-6C6E-46A0-A143-3503D038B9A0; iPadAir11M3 26.1 07434B1A-E571-45CC-817B-FDE28A82A524. Use fresh /private/tmp/BibleAdventure-PA005-* logs/results/derived paths. Long operations need checkpoints before launch and meaningful progress updates. Export summaries/logs/kept screenshots under Acceptance/PA-005-Evidence, including failed attempts and passing reruns.

Repository: /Users/cervantes/Documents/ChatGPT/BibleAdventure. Preserve personal Xcode UI/scheme files and all retained stashes. Read live Git state; current PA-004 handover carries latest branch/work status. Do not infer that a launched push or test finished.

## Credit-limit checkpoint template

After each task/change record: approval/task status; completed work; exact next action; changed paths/interfaces/data versions; unresolved decisions; tests/counts/failures; operation session/PID/log/result paths; Git branch/head/local/remote state; preservation list. Update this handover and CURRENT-CONTEXT before long commands. No task can be marked VERIFIED merely to close a session.

## Resume prompt

> Read the project instructions, CURRENT-CONTEXT, PA-004 final acceptance, PA-005 proposal/approval and this handover. Continue PA-005 T04 by recording only attributable manual David device evidence, preserve personal changes, keep source/content/acceptance traceability and update technical checkpoints. Do not redo completed automated tests or Noah work unless a change/failure requires it.
