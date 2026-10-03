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
| Complete VoiceOver flow on representative iPhone and iPad landscape, including reading/focus order and error/retry announcements | BLOCKED in the available iOS 26.1 Simulator: Computer Use access now works, but VoiceOver is absent from Simulator Accessibility settings. Physical-device testing is required; see the live acceptance update below. |
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


## Live acceptance update — 2026-10-03

Tester: Codex through Computer Use. Repository: develop, implementation commit 699f256. No application source changed during this session. Tested existing installed Simulator applications; installed-binary hashes were not independently compared with committed source, so these observations supplement the existing reproducible XCTest evidence.

Computer Use permission is now available. The earlier permission blocker is resolved. Simulator iOS 26.1 Accessibility settings expose Display & Text Size, Motion and Spoken Content, but no VoiceOver control. Apple's [assistive-technology testing guidance](https://developer.apple.com/documentation/accessibility/performing-accessibility-testing-for-your-app) states that VoiceOver testing requires a physical device in this Simulator setup. An accessibility-tree inspection does not establish spoken announcements or VoiceOver focus behavior. `xcrun devicectl list devices` reports a connected iPhone 14 Pro Max and an unavailable iPad mini; no physical-device VoiceOver test was executed.

### iPhone live flow

Device: iPhone 17 Pro Max / iOS 26.1 Simulator, ID 51ECE249-51FD-464C-A7AB-DADA8F9AEE5B. Started portrait, rotated to landscape during the first dialogue. Actual Settings > Accessibility > Motion > Reduce Motion changed from 0 to 1 and confirmed with the switch state and live screenshot. Text initially default; increased nine times using Simulator's preferred-text-size control during the animal game. Single-column accessibility layout appeared and game state remained 0/16. The exact final Dynamic Type category was not independently read, so this session does not replace existing accessibility5 XCTest evidence.

PASS for live control/transition operation: Continue, exact labelled Genesis 6:14 quotation, wrong Oak answer with feedback and Try again, correct gopher wood answer, all three wood collections, dimensions 300/50/30, pitch/side-door/three-deck questions, seven construction matches, six food items, all sixteen animal pairs, all eight family entry buttons, Close the Ark, all five flood stages, three dove results, seven rainbow colors, final reading invitation, reflection and Finish reflection. Final heading: Adventure complete. Every animal pair was checked for Selected state after its first activation and disappearance after its match; counters advanced 1 through 16. Other game counters reached their configured totals. ESV attribution disclosure exposed the complete notice and permissions link.

Live landscape screenshots were readable through Computer Use, resolving the inability to inspect any landscape screenshot. Reviewed samples: opening dialogue, first quotation/question, wood collection/completion, animal completion, dove result, reflection and its scrolled Finish/attribution controls. Long text and controls require scrolling. Decorative emoji were partially cropped in some large-text samples; meaningful labels remained present. No full pixel, target-size or temporal-animation certification is inferred from AX activation. OS Reduce Motion functional equivalence passed for this flow; continuous-motion inspection on both device families remains outstanding.

### iPad live samples

Device: iPad Air 11-inch (M3) / iOS 26.1 Simulator, ID 07434B1A-E571-45CC-817B-FDE28A82A524. Booted and opened its existing app. Portrait home, landscape home and landscape first Scripture question visually readable. New Adventure and two dialogue transitions reached the question with the reviewed quotation/source label and answer controls. Attempts to drag the system window resize handle, including Simulator pointer capture, did not establish a narrower app window. Pointer/keyboard capture was returned to off. Multitasking minimum width and resizing state acceptance remain NOT VERIFIED. No complete new iPad flow or actual iPad OS Reduce Motion check is claimed in this session.

Overall status remains IMPLEMENTED_UNVERIFIED. Remaining mandatory evidence: physical iPhone/iPad VoiceOver flow and focus/announcements; complete narrow iPad multitasking/resizing checks; both-family temporal Reduce Motion inspection; comprehensive live layout review; final owner content review. No verification status was promoted based on the partial live results.


## Owner acceptance — 2026-10-03

Owner response after the final acceptance report: “all working as expected.” Delivered Noah content/story is accepted; PA-003-T04 is VERIFIED. PA-003-T08 remains IMPLEMENTED and Noah IMPLEMENTED_UNVERIFIED pending the device/OS and manual accessibility details required by the acceptance record. Requested the tested iPhone/iPad models, OS versions and confirmation of VoiceOver, compact iPad resizing and OS Reduce Motion coverage. No device-specific result is inferred from this general confirmation. No source changes or test run in this update.


Owner follow-up — 2026-10-03: answered “yes” to whether final checks included VoiceOver, narrow iPad window resizing and Reduce Motion. These manual checks are recorded as owner-reported PASS together with “all working as expected.” Device models and OS versions were not supplied; manual test configuration metadata remains pending. Agent-observed Simulator results retain their separate scope. T08 formal verification remains pending that required metadata, with no remaining owner-reported functional failure.
