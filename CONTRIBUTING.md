# Contributing — Trust the Process

How to add content, update docs, and keep everything in sync. This applies to both human and AI contributors.

## The Golden Rule

**Every change to game code should be reflected in docs, and vice versa.** If you add a dialogue tree in `dialogue_manager.gd`, update the matching file in `docs/lore/dialogue/`. If you design a new enemy in the docs, note that the code doesn't implement it yet.

## Updating CHANGELOG.md

Add an entry for every change. Put new entries at the top within the `[Unreleased]` section.

Format:
```markdown
### Added / Changed / Fixed / Removed — YYYY-MM-DD
- **Short title**: Description of what changed and which files were affected.
```

Group related changes together. Be specific about files so others can find what changed.

## Updating CLAUDE.md

Update `CLAUDE.md` when any of these change:

- A new singleton/autoload is added or an existing one's API changes
- The scene flow changes (new scenes, changed transitions)
- A new system is introduced (e.g., save/load, audio, particle effects)
- The character factory gets new registration patterns
- A new common pitfall is discovered
- Code conventions are established or changed

You don't need to update it for every new dialogue tree or item — keep it architectural.

## Updating README.md

Update `README.md` when:

- The project status/phase changes
- An open question gets decided (move it to Decided)
- A new major feature is playable
- The project structure changes (new top-level folders)
- Contributors change

## Adding New Content

### New Character

1. **Design doc**: Add or update a file in `docs/lore/characters/`
2. **Character class**: Create `game/godot/scripts/characters/char_yourname.gd` extending `StickCharacter`
3. **Register in factory**: Add the NPC ID → class mapping in `character_factory.gd`
4. **Dialogue**: Add dialogue tree(s) in `dialogue_manager.gd` and document in `docs/lore/dialogue/`
5. **Room placement**: Add the NPC entry to the room dict in `exploration.gd`
6. **CHANGELOG**: Log it

### New Enemy Type

1. **Design doc**: Add to `docs/game-design/enemy-archetypes.md` or `docs/lore/characters/zone1-enemies.md`
2. **Battle data**: Define the enemy dict in `battle.gd` (or a future enemy data file)
3. **Battle dialogue**: Add to `docs/lore/dialogue/zone1-enemies.md`
4. **Encounter trigger**: Wire it up in `exploration.gd` (NPC click → dialogue → callback → battle)
5. **CHANGELOG**: Log it

### New Item

1. **Design doc**: Add to `docs/lore/items/zone1-items.md` with stats and flavor text
2. **Code**: If it's a starting item, add to `game_state.gd` `_init_inventory()`. If it's a drop, add to the enemy's `drops` array in `battle.gd`. If it's a quest reward, add via `GameState.add_item()` in the relevant callback.
3. **CHANGELOG**: Log it

### New Dialogue Tree

1. **Write the tree** as a Godot Dictionary array in `dialogue_manager.gd`
2. **Document it** in the appropriate file under `docs/lore/dialogue/`
3. **Wire the trigger**: Usually an NPC click in `exploration.gd` calling `DialogueManager.start_dialogue("tree_id")`
4. **Add callbacks** if the dialogue sets flags or triggers events
5. **CHANGELOG**: Log it

### New Scene / Room

1. **Scene file**: Create `.tscn` in `game/godot/scenes/` — use VBoxContainer layouts, unique node names
2. **Script**: Create matching `.gd` in `game/godot/scripts/`
3. **Transition**: Wire it into `SceneManager.change_scene()` calls from the appropriate trigger
4. **Room data**: If it's an exploration room, add to the `rooms` dict in `exploration.gd`
5. **Scene doc**: Document the location in `docs/lore/world/scene-bank.md`
6. **Update CLAUDE.md** scene flow section if the overall flow changes
7. **CHANGELOG**: Log it

### New Zone

This is a big one. You'll need:

1. Faction doc in `docs/lore/factions/`
2. Enemy roster in `docs/lore/characters/`
3. Item list in `docs/lore/items/`
4. Quest definitions in `docs/lore/quests/`
5. Full dialogue trees in `docs/lore/dialogue/`
6. Ambient dialogue in `docs/lore/dialogue/`
7. Boss design in `docs/lore/characters/`
8. All the corresponding code implementations
9. Update `docs/lore/world/setting-overview.md` with zone status
10. Major CHANGELOG entry

## Decisions Log

When a design question comes up, add it to `docs/planning/decisions-log.md`:

- If it's undecided: add to OPEN QUESTIONS with options and any current leaning
- If it's decided: add to DECIDED with date and rationale
- If it's a wild idea for later: add to PARKING LOT

## File Naming Conventions

- Docs: `zone{N}-{topic}.md` (e.g., `zone1-enemies.md`, `zone2-items.md`)
- Character scripts: `char_{name}.gd` (e.g., `char_steve.gd`, `char_oil_warrior.gd`)
- Scenes: `{scene_name}.tscn` matching the script name
- Keep names lowercase with underscores in code, hyphens in docs

## Before You Push

Quick sanity check:

1. Does the game still launch? (Title → Intro → Exploration → Battle → back)
2. Can you click through a full NPC dialogue without getting stuck?
3. Did you update CHANGELOG.md?
4. If you changed architecture, did you update CLAUDE.md?
5. No hardcoded node paths — use `%UniqueName` references?
6. No `fit_content = true` on RichTextLabels in fixed containers?
