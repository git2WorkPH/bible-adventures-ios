# PA-004 technical handover

Synchronization checkpoint — 2026-10-04: owner requested “push it to develop and master.” Preparing the final Noah acceptance and approved PA-004 handover documentation commit. Fetch confirmed develop/origin ef6ad72 and master/origin 2d6e237 before synchronization. After interruption, inspect live Git status/log/upstream refs to determine which steps completed before repeating a push or merge. Final hashes are reported in the delivery response; preparation-state local/uncommitted descriptions below are historical after this commit. No application source changes; personal Xcode settings remain excluded. PA-004 implementation still starts at T01 design.

Updated: 2026-10-04, Australia/Sydney. Read this file to resume PA-004 after interruption or credit exhaustion. Approval and acceptance source: [PA-004-APPROVED-TASKS.md](../Tasks/Approved/PA-004-APPROVED-TASKS.md). General process: [HANDOVER-PROCESS.md](HANDOVER-PROCESS.md).

## Current work and authorization

Owner approved all four proposed next-phase tasks on 2026-10-04: “i have approved the proposed next phase.” T01–T04 are APPROVED, not started. No PA-004 application changes or tests have executed. First action is T01 design. No running operations remain known.

PA-003-T01–T08 are VERIFIED; Noah IMPLEMENTED_VERIFIED. Preserve the reviewed Noah content, Scripture policy, atomic local progress, retry/recovery and accessibility behavior. Owner manual acceptance devices: iPhone 14 Pro Max/iOS26 and iPad mini/iPadOS26. Do not infer point releases/tablet generation.

T04 authorizes selecting/defining a story and proposing its implementation. The owner has not named the next story. T03's mechanic/contract must be selected explicitly. Do not infer Moses or David from enum cases. Audio/assets framework, accounts/cloud/telemetry and publication remain outside PA-004. No renewed approval is needed for work already covered by these tasks.

## Task sequence and acceptance

### T01 — Reusable story composition and content design

Status: APPROVED. Dependencies: none outstanding for starting design.

Work:
1. Read product/foundation requirements, Scripture Integrity Policy and existing Noah runtime decision.
2. Inspect Home/ContentView.swift, StoryPlayer/StoryPlayerView.swift, NoahStory.swift, core Story/StoryStep/StoryID/MiniGameType, repository protocols and ProgressPersistence.swift.
3. Define catalogue/selection and injected title, restart/read labels and Bible destinations. Define a versioned content schema and validation boundaries, identifying content externalized to JSON and mechanics retained in Swift.
4. Record the single-active-save versus multiple-story-progress decision explicitly and define compatibility with current noah-2 saves. Do not change the save format silently.
5. Add two synthetic fixture examples and an architecture decision under Documentation/Architecture/Decisions/. Reconcile T02's exact scope with that decision before implementation.

Acceptance checklist:
- [ ] Two synthetic stories can be represented without invented Biblical claims.
- [ ] Catalogue, shared-player metadata and repository contracts are specified.
- [ ] Schema/version and unknown activity/invalid Bible reference recovery are defined.
- [ ] Existing noah-2 saves have explicit restore/migration/rejection rules.
- [ ] Decision for active-save behavior is recorded; any unresolved product choice remains visible.
- [ ] T02 implementation/test criteria trace to the decision.
- [ ] Design review/evidence and Completed/T01 record exist before VERIFIED.

Evidence: create Acceptance/PA-004-T01-VERIFICATION.md with contract/examples review. Design alone does not certify runtime behavior.

### T02 — Configured player and content implementation

Status: APPROVED. Dependency: T01 decision/review; Noah acceptance prerequisite already met.

Work:
1. Implement T01's catalogue/composition and validated loader using injected core boundaries.
2. Replace shared-player Noah defaults/restart/read copy with configuration. Keep Noah's public experience, reviewed text and rules intact.
3. Keep the alternate fixture test-only; implement invalid-schema/content recovery and the chosen progress compatibility behavior.
4. Add independent loader/runtime tests, then run full Noah regression and affected iPhone/iPad presentation/accessibility checks.

Acceptance checklist:
- [ ] Two fixture stories use the same player/runtime without Noah-specific copy.
- [ ] Deterministic content loading and malformed/unknown/versioned content recovery pass.
- [ ] Existing saves behave exactly as T01 specifies; no silent data overwrite.
- [ ] Noah quotation, sequence, questions, games, reflection and save behavior remain correct.
- [ ] Relevant unit/repository/integration tests and complete Noah regression pass with actual counts.
- [ ] Affected phone/tablet layout/accessibility checks have named configuration/results.
- [ ] Interface/schema changes and source/evidence locations are in this handover.

Evidence: Acceptance/PA-004-T02-VERIFICATION.md; Completed/PA-004-T02 record. Preserve failed results and passing reruns.

### T03 — One reusable game mechanic

Status: APPROVED. Dependency: explicit mechanic choice and contract. Matching/selection is a suggested candidate, not a recorded selection.

Work:
1. Evaluate future-story needs and current Noah matching/selection behavior; record the bounded mechanic choice and its configuration/result contract.
2. Extract one story-neutral state/rules component with injected items, prompts, feedback and typed activity result.
3. Integrate Noah through that component while preserving its existing game rules and accessible controls.
4. Test two distinct non-Biblical configurations independently; run affected game and full Noah regression.

Acceptance checklist:
- [ ] Mechanic/contract decision and extraction boundary recorded.
- [ ] Both fixture configurations pass selection, mismatch/retry and completion tests.
- [ ] Stale/duplicate outcomes cannot advance progression twice.
- [ ] Noah rules and accepted integration/full flow pass.
- [ ] Accessible labels/controls, non-color state and reduced motion pass on named phone/tablet configurations.
- [ ] Extraction does not claim all game frameworks or a new ruler interaction are complete.

Evidence: Acceptance/PA-004-T03-VERIFICATION.md and Completed/T03 record.

### T04 — Next-story selection and requirements

Status: APPROVED. Dependency: owner story choice; do not mark the task BLOCKED merely because T01 can progress independently.

Work:
1. Ask for the next story choice when beginning this task; present candidate/source/reuse considerations if useful.
2. Define purpose, audience, Biblical source, learning objectives and each proposed component.
3. Review exact quotations against the approved source/policy; separately label interpretation/game content, questions/feedback and reflection.
4. Identify foundation dependencies and create traceable implementation proposals with scope, tests and device acceptance.

Acceptance checklist:
- [ ] Owner story choice is recorded.
- [ ] Story/component requirements, source references and content decisions reviewed.
- [ ] Scripture/interpretation/game labels and reflection requirements specified.
- [ ] Required foundation gaps and implementation dependencies identified.
- [ ] Reviewable implementation proposal includes domain/UI/content/device criteria.
- [ ] No new story is shipped under this requirements task; its implementation approval is separate.

Evidence: new story requirements, content decision/audit, proposed implementation tasks and Acceptance/PA-004-T04-VERIFICATION.md.

## Workspace, preservation and evidence

Repository: /Users/cervantes/Documents/ChatGPT/BibleAdventure. Branch develop, last observed HEAD ef6ad72 (origin/develop); master 2d6e237. Previous implementation commit 699f256. New final Noah closure, PA-004 assessment/proposal/approval and handover edits are local/uncommitted/unpushed. Inspect live Git state on resume; remote state can change.

Preserve personal Xcode UI state and scheme preference modifications. Shared scheme/test plan are committed. Retained stash 5f939ff0c7e58344dfc94e51bdc49eb97bfbf354 holds original personal settings; do not blindly apply/drop it. Do not stage personal files with documentation.

Noah regression baseline: 46 final unit tests plus the recorded complete phone/iPad/default/accessibility5/landscape/narrow-phone UI flows. Commands, counts, failed/rerun evidence and limitations are in Acceptance/PA-003-T08-VERIFICATION.md and PA-003-Evidence/. Full technical implementation and destination IDs are in TECHNICAL-HANDOVER.md. Use new result paths when rerunning changed code; verify tool/runtime availability. No new tests needed for this documentation-only checkpoint.

## Exact resume instruction

Read AGENTS.md, project documents, CURRENT-CONTEXT.md, this handover and the approved PA-004 task record. Inspect git status/log and preserve local changes. Begin PA-004-T01 at work item 1; no implementation has started. Do not restart Noah acceptance or ask again to approve PA-004. Record explicit design decisions, review T01 acceptance, then implement T02. T03/T04 can proceed when their recorded choices exist. Keep the unchecked acceptance lists honest and attach actual evidence before marking tasks VERIFIED.

## Checkpoints for credit exhaustion

After each meaningful change and before a long command, update: active task/status; completed work; next exact action; changed interfaces/files/schema; tests and results; unresolved choices; Git state; running operation ID/log/result paths. Write these to this file and CURRENT-CONTEXT.md. Preserve previous evidence in SESSION-CONTEXT.md. If credits end unexpectedly, inspect existing logs/processes before repeating operations. Never assume a launched test or push completed.

Suggested prompt for a new session:

> Continue PA-004 from Documentation/SessionMemory/PA-004-TECHNICAL-HANDOVER.md and CURRENT-CONTEXT.md. Follow the approved task scopes and acceptance criteria, preserve local user changes, and resume the first incomplete step. Update the handover as work progresses.
