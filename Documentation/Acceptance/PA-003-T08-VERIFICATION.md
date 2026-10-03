# PA-003-T08 — Noah device and accessibility acceptance

Date: 2026-10-03. Overall status: IMPLEMENTED; final manual acceptance outstanding.
Approval: ../Tasks/Approved/PA-003-APPROVED-TASKS.md.
Scope: all NOAH-001–012 components and player/activities/reflection/persistence/navigation. Build: current uncommitted approved implementation; existing user Xcode changes preserved. No physical-device or release certification.

## Executed evidence

| Configuration | Checks | Result |
|---|---|---|
| iPhone 17 Pro, iOS 26.5 Simulator, portrait | 45 unit tests + complete default flow + complete accessibility5/reduced-motion-policy flow + home/question hit-region/text-clipping audit | PASS: 48 tests, zero failures. Evidence/verified-phone-summary.json and verified-phone.log under PA-003-Evidence/. |
| iPad Air 11-inch (M3), iOS 26.1 Simulator | Complete default flow, largest-text/motion flow and audit | PASS: three tests, zero failures; verified-ipad-summary.json and verified-ipad.log in PA-003-Evidence/. |
| iPhone SE (3rd generation), iOS 26.1 Simulator, 375-point portrait width | Complete default and accessibility5/motion-policy flows and audit | PASS: default flow in v3; largest-text flow and audit in v4 (two tests, zero failures). |
| iPhone 17 Pro, iOS 26.5 Simulator, landscape | Complete accessibility5/motion-policy flow | PASS: one complete-flow test, zero failures; phone-landscape-summary.json. Earlier harness failures and fixes are retained below. |

Full-flow procedures actually select answers, retry a wrong answer, collect wood, answer dimensions, answer pitch/door/decks, match seven construction pieces, collect all food, pair all animals, bring in eight people, close the door, advance flood stages, send three dove journeys, assemble colors, finish reflection and relaunch. They use real configured step transitions, not a test fast-forward path. Relaunch resumes a saved dialogue boundary and completed reflection. A separate generic fixture exercises unavailable content/retry without Noah rules.

Largest-text and reduced-motion checks inject accessibility5 and the presentation motion policy in DEBUG builds. Production reads the actual OS Reduce Motion environment. These tests verify the policy branch and progression, but do not claim a human inspected every animation with the system setting enabled. VoiceOver is off during XCTest. The automatic audit covers only home and the first quotation/question screen, not the whole story or all accessibility audit categories.

## Repaired defects and review

- Fixed activity content clipped at large text by placing food/flood/dove views in scrolling containers.
- Replaced inaccessible drag-only requirements with equivalent wood/entry buttons and two-stage construction matching.
- Reflowed food/animal/color choices to non-lazy single-column layouts at accessibility text sizes or VoiceOver.
- Moved Game activity context into each activity’s scrollable content and made navigation options use an icon with a 44-point label frame.
- Added Interpretation labels to game completion summaries and kept food-completion emoji decorative at fixed size.
- Removed decorative scene motion/visual duplicates for accessible presentations; motion policy disables animations and flood offset motion.
- Retained useful original game visuals/drag behavior for standard presentations.

Default and largest-text phone screenshots are retained in PA-003-Evidence/. Visual review of the default reflection confirms readable source/interpretation distinction, prompt, GOD-centered question and finish action. Largest text intentionally requires scrolling. Screenshots captured after scrolling can show partially offscreen text; this is not a claim that the entire page fits one viewport. Rotation snapshots need separate interpretation from full-flow results.

## Outstanding manual acceptance

| Required check | Status / next procedure |
|---|---|
| Complete VoiceOver flow on representative iPhone and iPad landscape, including reading/focus order and error/retry announcements | BLOCKED: Computer Use reports permissions not granted. Enable native app access or execute the manual protocol below; existing AX labels/button paths are implementation evidence only. |
| Narrowest supported iPad multitasking window at accessibility5; resize without losing state | NOT RUN: requires manual window configuration; full-screen simulator checks do not certify multitasking. |
| OS Reduce Motion setting, animation equivalence and no continuing decorative motion | NOT RUN manually; DEBUG policy branch is exercised automatically. |
| Live landscape visual review | NOT RUN; screenshot orientation metadata affects preview. Full functional flows pass, but preview does not certify pixels. |
| Final owner review of replacement copy, questions, labels, attribution and reflection | Pending; source audit and presentation evidence are delivered in T04 and this record. Blanket task approval authorizes implementation but is not a recorded review of the delivered copy. |

Manual protocol: enable VoiceOver and complete the same configured flow without sight or precision gestures. Confirm title/source/instruction/controls/feedback order, answer retry focus, piece-to-outline matching, selected/matched state, completion and restored reflection. Repeat iPad in landscape and the narrowest multitasking window at accessibility5; resize during a question and a game. Enable OS Reduce Motion and inspect all games for equivalent immediate cues. Record tester, device/OS, setting, failures and results here before changing Noah or T08 to VERIFIED.

## Commands and artifacts

Phone command: `xcodebuild test -project BibleAdventure.xcodeproj -scheme BibleAdventure -destination 'platform=iOS Simulator,id=D1B4A041-95AD-48DE-A05B-8E70B8148510' -only-testing:BibleAdventureTests -only-testing:BibleAdventureUITests/NoahFlowTests -parallel-testing-enabled NO -derivedDataPath /private/tmp/BibleAdventure-PA003-derived -resultBundlePath /private/tmp/BibleAdventure-PA003-verified-phone.xcresult`.

iPad final command uses destination `07434B1A-E571-45CC-817B-FDE28A82A524`, only `BibleAdventureUITests/NoahFlowTests`, derived path `/private/tmp/BibleAdventure-PA003-ipad-derived`, result `/private/tmp/BibleAdventure-PA003-verified-ipad.xcresult`. Additional checks use the named test selectors and bundles recorded in the evidence summary. `xcresulttool get test-results summary` supplies exact results; `export attachments` supplies kept screenshots. `git diff --check` passes.

Conclusion: runtime implementation is testable and the complete phone and iPad portrait flows pass. Noah remains IMPLEMENTED_UNVERIFIED for overall acceptance while the manual criteria above remain open. T05–T07 narrow behavioral verification is retained separately.

### Test-harness failures retained

The first narrow-phone run failed at a construction outline and a memory card; the first landscape run failed at the height answer. AX snapshots showed controls present in the scrolling content but outside the viewport. The helper originally searched upward and then downward with eight fast gestures, which could skip a target or stop before reaching it. It now scrolls slowly toward a known control’s actual frame and searches both directions for lazy controls, up to forty gestures. Assertions and game actions are unchanged. First-attempt logs are retained as narrow-phone-first-attempt.log and phone-landscape-first-attempt.log; passing reruns must be recorded before those configurations are accepted.

The expanded landscape attempts also exposed unreliable partial-card taps: a reported tap did not always select a partially visible card, so unmatched cards remained and the continuation correctly stayed unavailable. The helper now brings the whole control into view using shorter near-target gestures and asserts selected state and removal of each matched pair. System confirmation controls are handled in their own presentation rather than constrained to the underlying story scroll view. These changes strengthen assertions and do not change game completion rules. One obsolete narrow run was interrupted after its default flow passed so the strengthened assertions could be used for the final run.

Final runtime review: PA-003-006 separated save warnings from activity/content errors so a storage failure cannot remove the content retry path. The final 46-test unit run passes; final-units-summary.json and final-units.log retain exact counts and commands. UI normal-flow checks are unaffected by this recovery-only change.

Final iPad landscape: iPad Air 11-inch (M3), iOS 26.1, accessibility5 and reduced-motion policy: complete flow PASS (one test, zero failures). All matches explicitly asserted; reflection and completed-state relaunch pass. Result: /private/tmp/BibleAdventure-PA003-ipad-landscape-v4.xcresult; retained ipad-landscape-summary.json, ipad-landscape.log and screenshots.

Final phone landscape: iPhone 17 Pro, iOS 26.5, accessibility5 and reduced-motion policy: complete flow PASS (one test, zero failures). Selected state and removal asserted for every animal pair. Result: /private/tmp/BibleAdventure-PA003-phone-landscape-v5.xcresult; retained phone-landscape-summary.json, phone-landscape.log and screenshots.

Landscape visual limitation: exported PNGs carry TIFF orientation 8 (confirmed from the PNG eXIf/iTXt metadata) and the available preview displays rotated/cropped content with black margins. They are retained as original artifacts but are not used to certify visual layout. Full functional landscape control/transition checks pass; live landscape visual inspection remains part of manual acceptance. No claim is made that this preview artifact proves either correct or defective on-device rendering.

Additional diagnostic logs retained: phone-landscape-clipped-hit-failure.log, ipad-landscape-activation-point-failure.log, narrow-default-pass-largest-failure.log. The helper now uses an observed visible hit region (at least 44 points) and asserts card state/match removal. Offscreen activation-point queries were removed after XCTest reported invalid activation points. This changes test input delivery, not domain rules.

Final narrow phone: iPhone SE (3rd generation), iOS 26.1, 375-point portrait: default complete flow PASS in /private/tmp/BibleAdventure-PA003-narrow-phone-v3.xcresult; accessibility5/motion-policy complete flow and audit PASS in /private/tmp/BibleAdventure-PA003-narrow-phone-v4.xcresult (two tests, zero failures). Default pass and separate failed older largest-text run remain visible in narrow-default-pass-largest-failure-summary.json. Latest largest/audit results: narrow-largest-audit-summary.json and narrow-largest-audit.log.

Final review: all recorded automated acceptance configurations pass in their cited successful runs. 46 final unit tests pass. Runtime recovery-only changes are covered by the final unit suite and final narrow full flow; earlier normal-flow results are retained with their original counts. verified-source-sha256.json records the delivered source. No application changes followed the final narrow run. All outstanding manual/content rows remain open, so T08 is IMPLEMENTED and Noah is IMPLEMENTED_UNVERIFIED.
