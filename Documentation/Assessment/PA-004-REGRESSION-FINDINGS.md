# PA-004 regression findings

Date: 2026-10-04. Within approved T02/T03 regression and owner authorization for necessary in-scope follow-ups.

## PA-004-R01 — Wood disclosure reachability

Status: RESOLVED after final corrected reruns. Observation: phone 26.1 default full flow failed before the extracted matching activity, unable to meet the 44-point visible-control criterion for “Collect wood with buttons.” Existing unchanged wood activity used a text-only DisclosureGroup label without explicit minimum height. The same default step is being tested on iPad and the baseline accepted phone 26.5 runtime. Largest-text landscape subsequently progressed through wood and into matching. No game/content/save rule change is justified by this observation.

Decision: give the wood DisclosureGroup label a minimum 44-point height, preserving its label, behavior and game controls. Approved as bounded responsive/accessibility regression fix. Keep the test's hit-target condition and all activity assertions. Evidence: phone-v1 log/xcresult, passing reruns to be added after completion. Verify actual failure attachment geometry before resolving; simulator/test-helper issues may also contribute.

## Compile repairs

Unit v1 failed before execution because a legacy StorySelectionView caller omitted the newly required injected runtime. Updated it to use the reviewed catalogue. Unit v2 failed before execution because Swift Testing expands a mutating struct call into an immutable expression context; capture the Bool first. Unit v3 passed51 tests; subsequent iPad units passed52 including per-story switching. These are development failures with preserved logs, not passing runs. No approval scope change.

Geometry confirmed from exported phone-v1 failure AX tree: wood disclosure Button frame {{32.0,679.3},{338.0,28.3}} inside the viewport. Its height28.3 was below the required 44 points. This is a real control sizing issue, not a missing-content or offscreen-only failure. Retained phone-v1-wood-failure-tree.txt and screenshot. Phone26.5 v2 with wood fix progressed past wood then exposed the same issue for Assemble with buttons. Applied equivalent minimum 44-point labels to build/enter disclosures. Rules/content/assertions unchanged. Initial runs deliberately cancelled after default failure; summary includes interrupted next test as a failure and exit 73, which must not be counted as another diagnosed product failure.

Additional geometry confirmed: phone 26.5-v2 Assemble disclosure Button {{32.0,244.3},{338.0,28.3}}, retained phone26-v2-default-failure-failure-accessibility-tree.txt. Final corrected source passes phone 26.1 default and all four iPad 26.1 UI configurations; exact phone 26.5 default rerun pending.

Final resolution: phone 26.1-v3/default, phone 26.5-v4/exact failed default and iPad-v2/all configurations pass. Source fix preserves game controls/copy/rules. See T02/T03 final verification for counts and limits.
