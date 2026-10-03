# Technical handover — BibleAdventure

Updated: 2026-10-03, Australia/Sydney. Current checkpoint for PA-003 closure and future project continuation. Use HANDOVER-PROCESS.md and HANDOVER-TEMPLATE.md for every later task.

## Objective and approval

Repository: /Users/cervantes/Documents/ChatGPT/BibleAdventure. Native Swift/SwiftUI iPhone/iPad application; local JSON content and progress. Documentation is authoritative.

Owner approved PA-003-T01–T08 and necessary follow-ups within their scope. Approval: ../Tasks/Approved/PA-003-APPROVED-TASKS.md. Future stories, audio/assets framework, cloud/accounts/telemetry and publication remain outside this approval. Owner separately authorized pushing develop and synchronizing master; those operations completed for implementation commit 699f256.

T01–T07 VERIFIED at bounded scopes. T04 owner content acceptance recorded. T08 IMPLEMENTED, pending only named manual test device/OS metadata after owner confirmed all works and the outstanding manual checks passed. Noah status stays IMPLEMENTED_UNVERIFIED until formal record closure. Do not repeat the owner's accepted tests just to obtain permission again.

## Implementation map

- BibleAdventure/Core/StoryRuntimeCoordinator.swift owns StoryEngine, objective session, activity attempt UUID guards, reflection and progress/recovery. Views send typed actions; the engine controls progression. Save errors are independent of content/activity errors so simultaneous failures keep both retry paths available.
- Core/LocalProgressStorage.swift atomically writes Application Support/BibleAdventure/progress.json. Core/ProgressPersistence.swift validates snapshots. Save after new game, accepted transition, reflection completion and scene inactivity. Resume unfinished activities at the step boundary with fresh attempts, rather than restoring an unfinished drag or card selection. Damaged/old saves remain until explicit New Adventure.
- Stories/Noah and Resource/Stories/Noah supply the 26-step noah-2 content and configuration. NoahScriptureRepository.swift supplies the reviewed ESV Genesis 6:14 quotation. Gopher wood identity is uncertain; side-door location does not assert left/right. Interpretation and Game activity are labelled.
- Features/Objective/RuntimeQuestionView.swift handles shuffled stable answer identities, feedback, hints, retry and Scripture source links.
- Features/Story/ReflectionView.swift presents the completion-gated GOD-centered prompt, Genesis references, reading invitation and Finish reflection. No faith score or personal reflection answers are stored.
- Features/StoryPlayer/StoryMotionPolicy.swift propagates actual OS Reduce Motion. Features/MiniGame/AdaptiveActivityGrid.swift reflows controls at accessibility text/VoiceOver. Wood, construction and entry have button equivalents to gestures. All activities remain reachable through scrolling.
- BibleAdventureTests/StoryRuntimeTests.swift covers runtime, restoration and simultaneous content/storage failures. BibleAdventureUITests/NoahFlowTests.swift drives real controls, explicit selected/matched states, reflection and relaunch. DEBUG tests isolate progress and inject text/motion settings; they do not bypass progression.

## Git and preservation

Last locally observed: develop/ origin/develop 699f2567156231a57096bc0c48d7c41011081944; master/origin/master 9c75981f13306d078c139469171e3effe2d306fe. Remote hashes were verified during prior push; this handover update did not query the network. Both committed trees matched after sync. At preparation of this checkpoint, documentation edits are local and uncommitted. The owner subsequently instructed pushing this update to develop and master. Fetch confirmed the hashes above before synchronization. Inspect git log/status and origin refs to determine whether the documentation commit and merge completed; do not treat preparation-state wording as live Git state.

Preserve personal modifications to BibleAdventure.xcodeproj/project.xcworkspace/xcuserdata/cervantes.xcuserdatad/UserInterfaceState.xcuserstate and BibleAdventure.xcodeproj/xcuserdata/cervantes.xcuserdatad/xcschemes/xcschememanagement.plist. Shared scheme/project/test plan are already committed. Never stage personal state accidentally.

Retained stash hash 5f939ff0c7e58344dfc94e51bdc49eb97bfbf354, currently stash@{0}, message “Codex: preserve personal Xcode settings during master sync.” Contains original personal settings before Xcode rewrote live UI state; scheme preferences were restored selectively. Do not blindly apply/drop this stash. Other stashes predate this work and remain untouched. Inspect Git status before every new operation.

## Evidence and limits

Durable evidence: ../Acceptance/PA-003-Evidence/. Full acceptance: ../Acceptance/PA-003-T08-VERIFICATION.md; device matrix: PA-003-DEVICE-VALIDATION-MATRIX.md. Content audit: PA-003-T04-CONTENT-AUDIT.md. Runtime decisions: ../Architecture/Decisions/NOAH-RUNTIME-INTEGRATION.md.

46 final unit tests passed on iPhone 17 Pro/iOS26.1, including storageFailureDoesNotHideContentRecovery. Original phone combined run had 48 tests (45 then-existing units plus three UI); do not relabel its count as the final suite. Full default/accessibility5 portrait flows and home/question audit passed on iPhone17Pro/iOS26.5 and iPadAir11(M3)/iOS26.1. Complete accessibility5 landscape flows passed on both. iPhoneSE3/iOS26.1 375-point default flow passed in v3; final largest-text/audit v4 passed two tests. Failed harness runs and passing reruns remain in evidence.

Useful temporary result bundles (may be removed by OS cleanup): /private/tmp/BibleAdventure-PA003-final-units.xcresult; verified-phone.xcresult; verified-ipad.xcresult; phone-landscape-v5.xcresult; ipad-landscape-v4.xcresult; narrow-phone-v4.xcresult, each prefixed BibleAdventure-PA003-. Durable logs/summaries are preferred. verified-source-sha256.json records delivered source hashes.

If changed code requires rerunning tests, use the recorded xcodebuild commands in T08 with a fresh result bundle path. Known destinations: phone26.1 3F0029BB-6C6E-46A0-A143-3503D038B9A0; phone26.5 D1B4A041-95AD-48DE-A05B-8E70B8148510; iPad26.1 07434B1A-E571-45CC-817B-FDE28A82A524; narrowphone26.1 7E49F393-F818-4CA8-8F5D-42335A8FB99B. Recheck availability first. Xcode/Simulator and Git writes/network may need sandbox escalation. Do not rerun passing suites for documentation-only edits.

Computer Use now works. Bind Simulator anew after a runtime reset and read fresh AX state before acting. Live iPhone17ProMax/iOS26.1 51ECE249-51FD-464C-A7AB-DADA8F9AEE5B completed landscape through Adventure complete with actual OS Reduce Motion enabled. System text increased during animals; exact final category not independently read. iPad home/first question visually inspected; compact resize was not established by agent. Live installed binary hashes were not compared to source. Landscape exported PNG orientation8 caused preview cropping; live samples were readable. Current Simulator lacks VoiceOver; physical-device results are owner-reported. Last device list showed connected iPhone14ProMax, unavailable iPad mini. Do not infer those were the owner's tested devices.

## Operations and local changes

No known build/test/Git command remains running from this task. No background monitor or automation exists. Simulator windows may remain open: iPhone at completed reflection and iPad at first question. iPhone Simulator Reduce Motion remains enabled and text increased for testing; iPad pointer/keyboard capture returned off. Do not change the user's Mac accessibility settings.

Uncommitted acceptance updates cover T04 owner acceptance, T08 live checks and owner-reported PASS; task register and both session files changed accordingly. This handover/process/template and AGENTS.md checkpoint rule are added by the documentation request. No application source changed after the passing final tests.

## Exact continuation

1. Read CURRENT-CONTEXT.md, task register and latest T08/owner acceptance sections. Ask only for the missing manual iPhone/iPad models and OS versions; preserve already confirmed PASS results.
2. Record metadata and reconcile T08, device matrix, component acceptance, requirement coverage, approved task summary and current session/project status. Mark T08 VERIFIED and Noah IMPLEMENTED_VERIFIED only when mandatory evidence metadata is complete. Older rows remain historical, explicitly superseded.
3. Review documentation diff and run git diff --check. Preserve personal Xcode files. If continuing the authorized Git sync, stage only intended documentation/instruction files, commit, push develop and merge into current master preserving history, then push and return to develop. Inspect remote changes first; do not force push. Record resulting hashes in the delivery response; the commit cannot include its own final hash. The next checkpoint should refresh them from Git.
4. Assess remaining product/foundation requirements and propose the next phase. Obtain approval for newly scoped implementation; the Noah blanket approval does not authorize every future project task.

Maintain this handover at each meaningful checkpoint using HANDOVER-PROCESS.md. If credits end unexpectedly, the next agent should resume the first incomplete step rather than restart Noah implementation.
