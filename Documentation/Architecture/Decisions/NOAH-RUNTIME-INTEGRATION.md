# Noah runtime integration

Status: APPROVED for implementation under the owner's 2026-10-03 authorization of PA-003-T01–T08 and their in-scope follow-ups.
Tasks: PA-003-T03, T05–T07.

Use a story-neutral observable coordinator that owns StoryEngine, objective sessions, activity attempt tokens, reflection and persistence. Noah supplies content, question lookup and reflection configuration. Views forward typed actions; no view increments a story index. Legacy mini-game completion closures are adapted to typed success at the presentation boundary. Incorrect local attempts remain retryable within each existing game; no new failure branches are invented.

Use a local JSON file in Application Support through ProgressDataStoring and atomic writes. Save after start, each accepted step outcome, reflection completion and scene deactivation. Resume validates schema, story content version, step range and objective identities. It restores the current story step; unfinished activities restart with fresh attempt tokens and answer order. Mid-drag/memory/animation restoration is excluded. Completed objectives and reflection opportunity completion are persisted as gameplay records only.

New Adventure explicitly replaces the saved session; Continue restores it. Restart explicitly clears that story's prior progress. A malformed/outdated save is retained until the player explicitly chooses a new adventure; restore never overwrites it. Write failures retain in-memory play and display Retry save. Reflection is offered after story completion and stays available on resume until the player finishes it. Reopening an already completed reflection displays neutral completion and a way to read the source again.

No cloud, accounts, telemetry, spiritual scoring, new stories or publication is included. Content-policy decisions remain those of SCRIPTURE-INTEGRITY-POLICY.md. Local implementation choices above make the approved tasks concrete; no external publication rights are assumed.
