# Bible Adventure — AI Development Configuration

This project uses the AI Project Continuity Kit with Bible Adventure-specific product rules.

## Product mission

The game exists to encourage children and other players to genuinely read the Bible with the intention of seeking GOD. Gameplay, puzzles, quizzes, and story progression are means to support that goal, not replacements for Scripture.

## AI workflow

```text
Bible Adventure Requirement
        ↓
Repository Assessment
        ↓
Foundation / Story Task Proposal
        ↓
Human Approval
        ↓
Codex Implementation
        ↓
Tests
        ↓
Review
        ↓
Session Memory
```

## Foundation-first rule

Before adding story-specific functionality, determine whether the capability belongs in the reusable foundation.

A story should consume foundation capabilities rather than create parallel implementations.

## Scripture-first rule

When a gameplay mechanic is derived from a Biblical account, identify the relevant Scripture reference in the requirement. Do not invent Biblical facts to make gameplay easier.

## Product integrity

- Do not alter Biblical meaning for game convenience.
- Clearly distinguish Scripture from game mechanics, assumptions, and fictional presentation.
- Avoid turning Scripture into merely a reward, collectible, or trivia answer.
- Gameplay should encourage curiosity and engagement with the source passage.
- Requirements should define the intended spiritual/product outcome without making claims about a player's personal faith response.

## Scope control

AI recommendations are proposals until approved.
Codex must implement approved tasks only.

## Documentation

```text
Documentation/
├── Requirements/
├── Tasks/
├── Assessments/
├── Architecture/
└── SessionMemory/
```
