# CLAUDE.md — Agent Instructions for Trust the Process

This file is the onboarding guide for any AI agent (Claude, Copilot, etc.) working on this project. Read this before touching anything.

## What This Project Is

"Trust the Process" is a dark humor 2D RPG satirizing the Burning Man / spiritual retreat / new-age wellness pipeline. Inspired by West of Loathing and South Park: The Stick of Truth. The player is Steve Stevens, a bland accountant whose wife disappeared into hippie land after an Ayahuasca retreat. He goes to retrieve her, traveling through yoga retreats, breathwork camps, healing courses, and ultimately Burning Man.

The tone is dry, absurdist, and dark — never preachy, never mean-spirited. Steve is aggressively normal. The world is aggressively not. Every game mechanic exists to serve a joke or narrative beat.

## Tech Stack

- **Engine:** Godot 4.3+ (GDScript, .tscn scene files, GL Compatibility renderer)
- **Resolution:** 960x640, stretch mode "canvas_items"
- **Art style:** Procedurally drawn stick figures via GDScript `_draw()` — no sprite assets
- **HTML prototype:** Single-file browser playable at `prototype/trust-the-process.html`
- **No external dependencies.** No addons, no C#, no plugins.

## Project Structure

```
docs/                    — Design docs, lore, dialogue, planning
  game-design/           — Combat, progression, items, puzzles, enemies
  lore/                  — Characters, factions, dialogue trees, quests, items, world
  art-direction/         — Visual style guide
  planning/              — MVP scope, decisions log
game/godot/              — The actual Godot project (open this folder in Godot)
  scripts/               — All GDScript files
  scripts/characters/    — StickCharacter subclasses (one per character)
  scenes/                — .tscn scene files (title, intro, exploration, battle)
prototype/               — HTML/JS browser prototype
art/concepts/            — HTML visual experiments for character design
```

## Architecture

### Singletons (Autoloads)

Three autoload singletons defined in `project.godot`:

1. **GameState** (`scripts/game_state.gd`) — All player data: HP, EP, Normality, Insight, Cacao, inventory, flags, current room. Emits signals on every change (e.g., `hp_changed`, `flag_set`). Other scripts connect to these signals — never poll.
2. **DialogueManager** (`scripts/dialogue_manager.gd`) — Stores all dialogue trees as nested Dictionaries. Handles branching (choices, goto), callbacks (setting flags, triggering battles), and typewriter state. Emits `dialogue_line_shown`, `choices_shown`, `dialogue_finished`.
3. **SceneManager** (`scripts/scene_manager.gd`) — Fade-to-black scene transitions using a CanvasLayer overlay.

### Scene Flow

```
title_screen.tscn → intro_screen.tscn → exploration.tscn ↔ battle.tscn
```

- **title_screen:** Blinking prompt, Space/click to begin.
- **intro_screen:** 6-page typewriter backstory. Uses anchor-based text area (8% margins, scroll enabled).
- **exploration:** Room-based navigation (pavilion → path → garden). Click stick figure NPCs for dialogue. Typewriter text with click/Space to advance. HUD shows all stats.
- **battle:** Turn-based. 6 action types (Fight, Mouth, Spirit, Item, Endure, Flee). Status effects (Stun, Pin, DOT, Block, Smoke Screen, Buff Next). SubMenuPanel toggles for branch skill lists and item lists.

### Stick Figure Character System

Characters are drawn procedurally in `_draw()`, not from sprites:

- **StickCharacter** (`stick_character.gd`) — Base class. Handles expressions (NEUTRAL, HAPPY, ANGRY, SCARED, SPECIAL), poses (IDLE, TALK, ATTACK, HIT), idle animation (bob, sway, breath), hover/click interaction, shake/bounce reactions.
- **CharacterFactory** (`character_factory.gd`) — Spawns characters by NPC ID string. Maps IDs to classes and configuration.
- **Character subclasses** in `scripts/characters/`: `char_steve.gd`, `char_oil_warrior.gd`, `char_breathwork_monk.gd`, `char_cacao_dealer.gd`, `char_generic_npc.gd`.

To add a new character: create a new `char_*.gd` extending `StickCharacter`, implement `_draw_character()`, and register it in `character_factory.gd`.

### Dialogue System

Dialogue trees live in `dialogue_manager.gd` as a Dictionary of Arrays. Each entry is a dict:

```gdscript
{"speaker": "Name", "text": "Line", "thought": true/false}     # Normal line
{"speaker": "", "text": "", "choices": [{"text": "...", "next": "tree_id"}]}  # Choice
{"speaker": "", "text": "", "goto": "tree_id"}                  # Redirect
{"speaker": "Name", "text": "...", "callback": "flag_name"}     # Triggers callback
```

**Important:** `exploration.gd` runs its own typewriter effect. When the typewriter finishes, it MUST set `DialogueManager.is_typing = false` or dialogue advancement will break (the user has to click twice). This has been fixed — don't revert it.

### Combat System

Three damage types: Physical, Psychic, Spiritual. Each enemy has a weakness type. Steve has three skill branches: Physical (use-based unlocks, Slap→Rage), Verbal (use + Insight unlocks, Complain→Silence), and Spiritual (involuntary, Normality-gated). Verbal skills deal Psychic damage. Spiritual enhancements transform existing skills as Normality drops. Battle menu: FIGHT/MOUTH/SPIRIT/ITEM/ENDURE/FLEE.

### Key Flags

- `talked_receptionist` — Unlocked after first receptionist conversation
- `talked_frank` — Unlocked after first Frank conversation
- `oil_defeated` — Hides the Oil Warrior NPC from the path
- `start_oil_battle` — Triggers battle scene transition on dialogue end

## Code Conventions

- GDScript style: tabs for indentation, snake_case for variables/functions, PascalCase for classes
- Use `%NodeName` (unique name) references, not hardcoded paths
- Signals for cross-system communication — never direct function calls between singletons
- All UI layouts use VBoxContainer/HBoxContainer hierarchies with proper containment (no floating nodes)
- Dialogue panels must have ScrollContainer wrapping text and a ClickArea Button for mouse input
- Keep `.tscn` files hand-editable — avoid deeply nested or auto-generated node trees

## Common Pitfalls

1. **Dialogue stuck:** If `DialogueManager.is_typing` isn't cleared when exploration's typewriter finishes, `advance()` eats clicks. Always sync that flag.
2. **SubMenu not showing:** Battle submenu requires toggling `SubMenuPanel` (the PanelContainer parent), not just the inner `SubMenu` VBoxContainer.
3. **Text overflow:** Never use `fit_content = true` on RichTextLabel inside a fixed container — use ScrollContainer instead.
4. **Node references after tscn rewrite:** If you rewrite a `.tscn`, check that all `%UniqueNames` still exist and that `@onready` references in the `.gd` match.
5. **Scene UID conflicts:** Each `.tscn` has a `uid://` — don't duplicate these when creating new scenes.

## What To Update When You Change Things

See `CONTRIBUTING.md` for the full checklist. The short version:

- Changed gameplay mechanics? → Update the relevant doc in `docs/game-design/`
- Added/changed a character? → Update `docs/lore/characters/` and `character_factory.gd`
- Added/changed dialogue? → Update `docs/lore/dialogue/` AND `dialogue_manager.gd`
- Added items? → Update `docs/lore/items/` AND `game_state.gd` (if default inventory)
- Made any change at all? → Add an entry to `CHANGELOG.md`

## Humor Guidelines

- Steve's dialogue is deadpan, literal, accounting-metaphor-heavy
- NPCs speak in spiritual jargon, buzzwords, and toxic positivity
- Stage directions (thought text) are the narrator's dry commentary
- Items have dual descriptions: a "spiritual" name and Steve's internal reaction
- Never punch down — the satire targets systems, groupthink, and hypocrisy, not individuals seeking meaning
- The funniest moments come from Steve accidentally being right for the wrong reasons
