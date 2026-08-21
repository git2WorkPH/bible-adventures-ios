# Bible Adventure — Foundation Architecture

## Architectural Goal

Create a reusable foundation so new Bible stories can be added primarily through content and story configuration rather than duplicated gameplay engines.

## High-Level Architecture

```text
SwiftUI Views
      │
      ▼
Story Player
      │
      ▼
Story Engine
      │
      ├── Dialogue
      ├── Scripture
      ├── Objectives
      ├── Questions
      ├── Mini-games
      ├── Reflection
      └── Progress
              │
              ▼
        Content Repositories
              │
              ▼
       JSON / Local Content
```

## Foundation Principle

Views present state.

Engines manage gameplay behavior.

Repositories provide content.

Story definitions configure the experience.

## Desired Separation

```text
Foundation
├── Models
├── Engines
├── Repositories
├── Services
└── Reusable Views

Stories
├── Noah
│   ├── Content
│   ├── Configuration
│   └── Story-specific assets
│
└── Future Stories
```

## Important Rule

Do not put Noah-specific rules into a reusable foundation component unless the capability is genuinely reusable.

## Current Known Components

The existing project has included concepts such as:

- StoryRepository
- StoryPlayerView
- ScriptureView
- Objective model
- ObjectiveView
- QuestionRepository
- BuildArkView
- RainbowCovenantView
- EnterArkView
- WoodSelection
- MeasureArkView
- MemoryGameEngine

These should be reviewed against the foundation requirements before further implementation.
