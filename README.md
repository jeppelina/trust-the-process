# Trust the Process

A dark humor 2D RPG satirizing the Burning Man / spiritual retreat / new-age wellness pipeline. Inspired by West of Loathing and South Park: The Stick of Truth.

## Premise

You are Steve Stevens. You are 38 years old. You work in accounting. You are adequate at most things.

Three weeks ago your wife went to an Ayahuasca retreat in the mountains. She said it would be "just a weekend." She did not come back by Monday. Then the texts stopped. The credit card did not stop — $2,400 for a "Transformational Immersion," $800 for a "Sacred Sound Healing Intensive," $340 for an "Artisanal Cacao Ceremony Kit."

You have packed sensible shoes, a change of clothes, and the quiet certainty of a man who has filed fourteen years of tax returns without a single error. You are going to find your wife. You are going to bring her home. You are not going to "open" anything.

## Play It

**HTML Prototype (browser):** Host `prototype/trust-the-process.html` or open it locally. Self-contained, no dependencies.

**GitHub Pages:** [https://jeppelina.github.io/trust-the-process/prototype/trust-the-process.html](https://jeppelina.github.io/trust-the-process/prototype/trust-the-process.html)

**Godot (full version):** Open `game/godot/` as a project in Godot 4.3+. Hit Play.

## Current Status

**Phase: Prototype / Vertical Slice**

Zone 1 (The Sanctuary of Infinite Becoming) is playable with 3 explorable rooms, NPC dialogue trees, one full combat encounter, and stick figure characters drawn procedurally in code.

### Decided
- Engine: **Godot 4.3+** (GDScript, GL Compatibility)
- Art style: **Procedural stick figures** via `_draw()` — no sprite assets needed
- Combat: **Turn-based** with 3 damage types (Physical, Psychic, Spiritual) and FIGHT/MOUTH/SPIRIT/ITEM/ENDURE/FLEE menu
- Progression: **Insight** as XP, **Normality** as tension meter, three skill branches (Physical, Verbal, Spiritual — spiritual is involuntary)
- Economy: Triple currency — **Cacao Coins**, Karma Points, real USD

### Open Questions
- Does Steve change through the journey or remain stubbornly mundane?
- Is magic real in-world? (Ambiguous is probably funniest)
- Multiple endings structure
- Party members / companion system

### MVP Target
A 20–30 minute playable vertical slice of one complete zone with 5–8 NPCs, 3–4 enemy types, 1 boss fight, branching dialogue, inventory, and a main quest. Success = someone plays it and laughs at least 3 times.

## Project Structure

```
CLAUDE.md              — Agent instructions (read this if you're an AI)
CHANGELOG.md           — What changed and when
CONTRIBUTING.md        — How to update docs and code
README.md              — You are here

docs/
  game-design/         — Combat, progression, items, puzzles, enemy archetypes
  lore/
    characters/        — Steve, the wife, Zone 1 enemies, boss, idea bank
    dialogue/          — Full NPC/enemy/boss/ambient dialogue trees
    factions/          — Zone 1: The Sanctuary of Infinite Becoming
    items/             — Zone 1 items with stats and flavor text
    quests/            — Main quest + side quests
    world/             — 10-zone setting overview, scene bank
  art-direction/       — Visual language and style guide
  planning/            — MVP scope, decisions log

game/godot/            — Open this folder in Godot 4.3+
  scripts/             — GDScript: singletons, scene controllers, combat
  scripts/characters/  — StickCharacter subclasses (one file per character)
  scenes/              — .tscn files: title, intro, exploration, battle

prototype/             — Single-file HTML/JS browser prototype

art/concepts/          — HTML visual experiments for character design
```

## Tech Overview

Three autoload singletons manage global state: **GameState** (stats, inventory, flags), **DialogueManager** (dialogue trees, branching, callbacks), **SceneManager** (fade transitions). Characters are rendered as procedural stick figures using GDScript's `_draw()` with a factory pattern for spawning.

See `CLAUDE.md` for full architecture details and `CONTRIBUTING.md` for how to add content.

## Contributors
- Jesper
- [Friend]
