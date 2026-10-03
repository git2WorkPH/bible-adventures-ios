# PA-003 — Device and accessibility validation matrix

Date: 2026-10-03. Build: current approved Noah implementation in the uncommitted working tree. Automated tester: Codex/XCTest. Detailed evidence and limits: PA-003-T08-VERIFICATION.md. VoiceOver is off in automated rows; accessibility5 and motion are DEBUG-injected presentation settings unless stated otherwise.

| Configuration | Orientation/window | Text / motion | Procedure | Result |
|---|---|---|---|---|
| iPhone 17 Pro / iOS 26.5 Simulator | Portrait | Default / normal | Entire Noah flow, incorrect answer/retry, saved boundary and completed-reflection relaunch | PASS |
| iPhone 17 Pro / iOS 26.5 Simulator | Portrait | accessibility5 / reduced-motion policy | Entire flow and home/question hit-region/text-clipping audit | PASS |
| iPad Air 11-inch (M3) / iOS 26.1 Simulator | Portrait | Default / normal | Entire flow and relaunch | PASS |
| iPad Air 11-inch (M3) / iOS 26.1 Simulator | Portrait | accessibility5 / reduced-motion policy | Entire flow and home/question audit | PASS |
| iPhone SE (3rd generation) / iOS 26.1 Simulator, 375-point width | Portrait | Default and accessibility5 / respective policies | Default complete flow passes in v3; largest flow + audit pass in v4 | PASS; narrow result summaries |
| iPhone 17 Pro / iOS 26.5 Simulator | Landscape | accessibility5 / reduced-motion policy | Entire flow and relaunch | PASS; phone-landscape-summary.json |
| iPad Air 11-inch (M3) / iOS 26.1 Simulator | Landscape | accessibility5 / reduced-motion policy | Entire flow and relaunch, including final interpretation labels | PASS; ipad-landscape-summary.json |
| Representative iPhone and iPad | Required orientations | VoiceOver on | Complete without sight/precision gesture; reading order, focus and announcements | BLOCKED: native Computer Use permissions not granted |
| Narrowest iPad multitasking width | Windowed/resizing | accessibility5 | Complete and resize during question/activity, preserve state/focus | NOT RUN |
| iPhone and iPad | Required layouts | OS Reduce Motion on | Human animation/equivalence inspection | NOT RUN manually; policy branch passes automatically |

## Component conclusions

- Text/control reachability: complete automated portrait flows pass; largest text reflows into scrollable single-column game controls. Full text does not need to fit one viewport.
- Hit targets/text clipping: automatic audit passes on home/wood question; remaining components need manual target inspection. No claim of every audit category passing.
- Gesture alternatives: complete automated flow uses wood/entry buttons and real two-stage construction matching. These paths preserve game rules.
- Labels/traits/non-color state: implemented and source reviewed; live nonvisual operation/focus remains unverified.
- Rotation: brief mid-flow rotation preserves the resumed dialogue; complete landscape tests are recorded separately when finished.
- Motion: production reads OS environment, DEBUG tests inject its policy, and scene animations are disabled under it. Actual OS setting/continuous motion requires manual inspection.

Overall: IMPLEMENTED_UNVERIFIED for mandatory full acceptance. Use actual passing row evidence rather than this matrix to infer any broader device/release support.

Landscape PASS rows describe functional operation. Original screenshot orientation metadata affects the available preview, so live visual inspection remains unverified; see T08.
