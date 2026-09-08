# Responsive accessibility and reduced-motion standards

Status: VERIFIED for standards definition
Task: FND-BASE-T12
Requirements/findings: PRD-005, FND-020, FND-023; PA-002-004.

These standards govern reusable SwiftUI presentation work after that work is separately approved. They do not certify the current Noah prototype.

## Dynamic Type

- User-facing text uses semantic SwiftUI text styles and supports every system Dynamic Type size from `xSmall` through `accessibility5`.
- Fixed point sizes are permitted only for decorative imagery. They must not be used to prevent meaningful text from scaling.
- At `accessibility5`, text remains readable without clipping, overlap, or loss of controls. Content may reflow vertically and must remain reachable by scrolling.
- Horizontal control groups that no longer fit become vertical or adaptive. Meaningful text is not reduced below the user's selected size to preserve a layout.
- Truncation is permitted only for nonessential repeated labels when the full value is also available to assistive technology; Scripture, prompts, feedback, instructions, and button labels must remain available in full.

## VoiceOver and nonvisual operation

- Every actionable control has a concise accessible label that names the action, plus a value or hint only when it adds necessary context.
- Images conveying content have a meaningful label. Decorative images, emoji, and duplicate visual labels are hidden from accessibility.
- Reading order follows the visible task order: context/title, source or instruction, interactive content, feedback/status, then primary continuation action.
- Selection, correctness, completion, disabled state, and progress are not communicated by color, shape, position, animation, or sound alone.
- Custom gestures have an accessible Button or adjustable-action equivalent. Drag-only, timed, memory, selection, measurement, and puzzle activities require a complete VoiceOver-operable path.
- Focus remains on the changed control or moves deliberately to new feedback/content after a state transition; it must not reset unpredictably to the screen root.
- A complete flow can be operated with VoiceOver without requiring sight or a precise gesture.

## Touch and interaction targets

- Every actionable target is at least 44 by 44 points, including icon-only controls and tappable game objects.
- Adjacent targets have sufficient separation to avoid overlap at all supported text sizes. Enlarged invisible hit areas must not intersect.
- Controls remain reachable without precision at compact iPhone widths, landscape height constraints, iPad layouts, and supported multitasking widths.
- State-changing interactions provide visible and accessible feedback and are safe against accidental duplicate activation.

## Responsive iPhone and iPad layout

- The app supports both target device families declared by the project (`TARGETED_DEVICE_FAMILY = "1,2"`).
- Validation covers the narrowest supported iPhone portrait width, iPhone landscape, a representative large iPhone, iPad portrait, iPad landscape, and the narrowest supported iPad multitasking width.
- No required control or meaningful content is clipped, obscured by safe areas/keyboards, or placed off-screen. Horizontal scrolling is used only when intrinsic to an explicitly documented activity.
- Rotation and size-class changes preserve current story/activity state, selected answer, retry state, and focus as applicable.
- Layouts use available space rather than device-model checks. iPad content is constrained to readable widths or intentionally arranged into additional columns; it is not merely an indefinitely stretched phone layout.

## Reduced motion

- The presentation owner reads SwiftUI's `accessibilityReduceMotion` environment value and passes a motion policy to reusable animated components when needed.
- When Reduce Motion is enabled, decorative continuous, repeating, parallax, shake, bounce, spin, large-scale zoom, and large-distance position animations are removed.
- Required state changes remain understandable using immediate updates or a short opacity transition. Animation must never be the only indication of selection, progress, success, failure, or completion.
- Gameplay whose mechanic depends on observing or producing motion provides an equivalent non-motion control or representation; simply slowing the animation is insufficient.
- Disabling animation must not change progression rules, scoring, available actions, completion callbacks, or content timing required for comprehension.
- No automatically repeating animation continues indefinitely while Reduce Motion is enabled.

## Presentation ownership boundaries

| Reusable presentation | Component owns | Coordinator/domain owns | Required accessibility evidence after implementation |
|---|---|---|---|
| Story player/navigation | Focus and navigation order, responsive container, size changes, reduced-motion environment propagation | Current step/state and progression | Full flow on iPhone/iPad, rotation/resize state preservation, VoiceOver focus transitions |
| Dialogue | Semantic text layout, speaker/reference labels, Continue target and order | Dialogue content/reference and completion outcome | Dynamic Type extremes, full reading order, button target |
| Objective/question/feedback | Instruction/hint hierarchy, answer labels/traits, feedback announcement, adaptive answer layout | Answer identity, validation, retry and completion lifecycle | VoiceOver answer/retry flow, non-color status, Dynamic Type and 44-point targets |
| Scripture | Exact visible label/text presentation, scroll/reflow, source order, unavailable-content message | Approved Scripture content/reference and repository result | Full quotation/read order, ESV/source label, Dynamic Type, error recovery path |
| Mini-game adapter/view | Accessible alternative to gestures, game-object labels/values, focus, responsive mechanics, motion policy | Typed result, attempt/retry lifecycle and Story Engine progression | Per-game VoiceOver path, reduced-motion equivalence, touch targets, both device families |
| Reflection | Interpretation/Scripture distinction, question order, readable layout and continuation control | Completion gate, reference linkage, lifecycle | VoiceOver reading order, content labels, Dynamic Type, iPhone/iPad layout |
| Completion/progress | Neutral gameplay-status wording, readable summary, next action and focus | Completed gameplay records and unlock decisions | Non-spiritual wording review, VoiceOver, Dynamic Type, target sizes |
| Recoverable error presentation | Accessible message, focus, retry/cancel controls | Typed error and recovery decision | Error announcement, operable recovery, no internal detail exposure |

A domain model or coordinator must not encode font size, device model, VoiceOver focus, or animation mechanics. A view must not invent domain outcomes to solve accessibility.

## Evidence rule

Use `Documentation/Acceptance/ACCESSIBILITY-DEVICE-VALIDATION-MATRIX.md` for every approved presentation implementation. Record actual device/simulator, OS, orientation/window size, Dynamic Type size, VoiceOver state, Reduce Motion state, procedure, and result. A row left unexecuted is `NOT RUN` or `BLOCKED`, never `PASS`.
