# Accessibility and device validation matrix

Copy this matrix into the implementing task's acceptance record or link a completed task-specific copy. Replace every placeholder; do not use this blank plan as evidence that a UI passed.

## Build and scope

- Task/requirement: `<ID>`
- Commit/build: `<identifier>`
- Tested flow/components: `<scope>`
- Excluded flow/components: `<limitations>`
- Tester/date: `<name or role / YYYY-MM-DD>`

## Device and responsive-layout matrix

| Configuration | Orientation/window | Dynamic Type | VoiceOver | Reduce Motion | Procedure/evidence | Result |
|---|---|---|---|---|---|---|
| Narrowest supported iPhone | Portrait | Default | Off | Off | Complete scoped flow; inspect clipping, safe areas, scrolling, and 44-point targets. | NOT RUN |
| Narrowest supported iPhone | Portrait | accessibility5 | Off | Off | Complete scoped flow; inspect full text, adaptive stacking, scrolling, and reachable controls. | NOT RUN |
| Supported iPhone | Landscape | accessibility5 | Off | Off | Complete scoped flow; inspect constrained height, keyboard/safe areas, and rotation state. | NOT RUN |
| Representative large iPhone | Portrait | Default | On | Off | Complete scoped flow nonvisually; record labels, values, traits, order, focus, and custom controls. | NOT RUN |
| Supported iPad | Portrait | Default | Off | Off | Complete scoped flow; inspect readable width, use of space, targets, and state. | NOT RUN |
| Supported iPad | Landscape | accessibility5 | On | Off | Complete scoped flow; inspect reflow and full VoiceOver operation. | NOT RUN |
| Narrowest supported iPad multitasking width | Windowed | accessibility5 | Off | Off | Resize during the flow; inspect reflow, content reachability, and state preservation. | NOT RUN |
| Supported iPhone and iPad | Applicable layouts | Default | Off | On | Complete every animated/gesture activity; verify equivalent state cues and mechanics without disallowed motion. | NOT RUN |

## Component checks

| Check | Measurable pass condition | Result/evidence |
|---|---|---|
| Text | No missing, clipped, overlapping, or unreadably scaled Scripture, prompt, instruction, feedback, or control label through accessibility5. | NOT RUN |
| Reading/focus order | Context precedes interaction, feedback follows action, and focus changes are deliberate and repeatable. | NOT RUN |
| Labels and traits | Every meaningful image/control exposes an accurate label/trait; decorative duplicates are hidden. | NOT RUN |
| Nonvisual operation | Every scoped action and completion path is possible with VoiceOver and without a precision-only gesture. | NOT RUN |
| Non-color communication | Selection, status, correctness, and completion remain understandable without color or animation. | NOT RUN |
| Touch targets | Every actionable region measures at least 44 by 44 points with no overlapping hit areas. | NOT RUN |
| Responsive state | Rotation/resizing preserves domain state, selection, retry state, and relevant focus. | NOT RUN |
| Reduced motion | Disallowed motion stops; equivalent cues/actions remain; progression and completion behavior are unchanged. | NOT RUN |

## Defects, blockers, and conclusion

- Defects/findings: `<IDs or none>`
- Environment blockers: `<condition, diagnostic evidence, affected rows, and rerun condition or none>`
- Overall result: `<PASS / FAIL / BLOCKED / NOT RUN>`
- Limitations/follow-up: `<remaining configurations or components>`
