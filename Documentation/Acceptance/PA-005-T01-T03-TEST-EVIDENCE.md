# PA-005 T01–T03 test evidence — David and Goliath

Date: 2026-10-16. Source checkout: `develop` at `4e2e74ddd1af4c1aa95e3c3365e4b3948586a77e`, with PA-004 and PA-005 implementation changes uncommitted.

| Check | Result | Evidence |
|---|---|---|
| Core/unit target | Passed: 55 tests in 10 suites | `/private/tmp/BibleAdventure-PA005-units-v1.log`; `/private/tmp/BibleAdventure-PA005-units-v1.xcresult` |
| David flow on iPhone 17 Pro, iOS 26.1 | Passed: 1 UI test | `/private/tmp/BibleAdventure-PA005-david-ui-v1.log`; `/private/tmp/BibleAdventure-PA005-david-ui-v1.xcresult` |
| David flow on iPad Air 11-inch (M3), iPadOS 26.1 | Passed: 1 UI test | `/private/tmp/BibleAdventure-PA005-david-ipad-ui-v1.log`; `/private/tmp/BibleAdventure-PA005-david-ipad-ui-v1.xcresult` |
| Noah full-flow regression on iPhone 17 Pro, iOS 26.1 | Passed: 1 UI test | `/private/tmp/BibleAdventure-PA005-noah-ui-v1.log`; `/private/tmp/BibleAdventure-PA005-noah-ui-v1.xcresult` |

The unit suite covers loaded David content, full runtime completion/reflection/relaunch, distinct David matching configuration, retained Noah progress, and rejection of a David definition wired to Noah's activity. The UI flow selects David, completes all three matching pairs, answers four source-connected questions, reaches reflection, finishes it, relaunches, reselects David, and observes `Adventure complete`.

Remaining T04 evidence: owner-recorded manual VoiceOver, actual OS Reduce Motion, and compact iPad window checks. Until those are recorded, device acceptance is not VERIFIED.
