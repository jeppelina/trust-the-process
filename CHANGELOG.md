# Changelog

All notable changes to this project are documented in this file. Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

When updating: add new entries at the TOP of the relevant section. If today's date already has an entry, append to it. Always note which files were affected.

---

## [Unreleased]

### Added — 2026-03-14
- **Full retreat center implementation** — 10 connected rooms (pavilion, path, garden, kitchen, dorms, studio, main_hall, firepit, ceremony, back_office) with dynamic navigation, flag-based exit requirements, and room-specific background colors
- **5 new character designs** — Maya (terracotta skeptic, arms-crossed), Brandon (eager convert, teal polo), Dharma John/Gatekeeper (dark indigo, long beard, judging stare), all registered in CharacterFactory with unique accent colors
- **Complete dialogue system** — 35+ dialogue trees totaling ~650 lines covering: receptionist family (phone/name/wife branches), oil warrior, frank family (wife/long/unusual), maya arc (kitchen → return → firepit revelation → post-boss), brandon arc (arrival → act2 → night → post-boss), cacao dealer shop with item purchases, meditator challenge + post, full sharing circle (3 rounds × 3 choices each), gatekeeper confrontation (reason/challenge/expose paths), back office discovery, founder prefight/battle/3 endings (walk/restructure/destroy), departure, breathwork monk healing, frank quest (pipe/done)
- **Data-driven battle system** — Rewritten battle.gd supports 4 enemies via ENEMY_DB: Oil Warrior (45 HP, bureaucratic weakness, spreadsheet instakill), Competitive Meditator (60 HP, psychic weakness), Gatekeeper (80 HP, bureaucratic weakness, corporate past), Founder boss (3-phase: Brandon shield 30HP → Paul direct 50HP → Desperate Paul with phase3 attacks)
- **Ego death mechanic** — On HP=0 in battle, calls GameState.ego_death(): respawn in dorms, 50% HP/EP, -5 Normality, rotating funny death messages. Battle returns to exploration instead of restarting
- **Stick figure characters in battle** — Replaced emoji Labels with dynamically spawned StickCharacter nodes via CharacterFactory in battle scene
- **Bright theme battle scene** — battle.tscn updated: white UI panel, warm cream background, Liberation Mono font, dark text on light backgrounds
- **Item and flag system** — Full inventory with proper Dictionary items (coffee, cacao drink, kombucha, wifi password, wrench, master key, etc.), flag-based progression (has_map unlocks areas, circle_done unlocks ceremony, etc.), map given by receptionist
- **Dynamic exit navigation** — Replaced fixed 2-button nav with dynamically generated exit buttons supporting rooms with 3+ exits
- **HTML prototype v2** — Complete single-file browser playable at prototype/trust-the-process.html with ALL dialogue trees, 4 battle enemies + 3-phase boss, ego death, item shop, skill/talk submenus, 3 game endings
- **Speaker color system** — 14 unique speaker colors including Meditator, Facilitator, The Oversharer, Cacao Dealer

### Fixed — 2026-03-14
- **Choice callbacks not executing** — select_choice() in dialogue_manager.gd now handles callback fields on choices (was ignoring them, breaking Cacao Dealer shop)
- **Item callbacks passing strings** — Fixed all add_item() calls in dialogue_manager.gd to pass proper Dictionary objects instead of bare strings
- **Map not given** — Added map-giving dialogue lines and add_retreat_map callback to receptionist conversation
- **Post-battle dialogues unreachable** — meditator_post and brandon_post_boss now properly routed via flag checks in exploration.gd
- **Meditator stays visible** — Removed hide_flag from meditator NPC so post-battle dialogue is accessible
- **Auto-trigger back office discovery** — Entering back_office now auto-starts back_office_discover dialogue when documents not yet found

### Added — 2026-03-14 (earlier)
- **Procedural scenery system** (`scenery_drawer.gd`): Room-specific background art drawn via `_draw()` with subtle animations. Pavilion: mountains, prayer flags (animated sway), reception desk with Dell laptop, crystals, incense with smoke, "WELCOME HOME" banner, potted plant, stool. Path: treeline silhouettes, gravel path, "YOU ARE ENOUGH" / "PLEASE COMPOST" signs, prayer flags, oil bottles, wildflowers (animated), stone lantern with glow. Garden: bushes, partially repaired fence, red toolbox, loose nails, sawhorse with plank, coffee thermos with steam, meditation cushions, crystal grid, wind chimes (animated), hanging plant with trailing vines.
- **SceneryDrawer integration**: Added SceneryDrawer node to `exploration.tscn` (inside SceneBG, behind NPCContainer) and wired `set_room()` call in `exploration.gd` on room entry.

### Added — 2026-03-13
- **The Founder character** (`char_founder.gd`): Zone 1 boss with 3-phase visual design — welcoming (arms wide, intact mala beads, aura glow), mask slipping (intense eyes, pointing, beads breaking), and broken/Paul (collapsed, hugging self, beads scattered). Triangle silhouette that collapses across phases. 180px tall boss scale.
- **The Oversharer character** (`char_oversharer.gd`): Zone 1 enemy built from circles. Round head, huge watery eyes with permanent streaming tears, open mouth (never stops talking), messy hair, grabby reaching arms, tear-stained journal. Trauma Dump attack pose with word fragments flying out.
- **The Competitive Meditator character** (`char_competitive_meditator.gd`): Zone 1 enemy — perfect lotus position on embroidered cushion. Smugly closed eyes, oversized mala beads, concentric aura rings. "Performative Stillness" defense with one eye peeking to check if anyone notices.
- **Groundskeeper Frank character** (`char_frank.gd`): Upgraded from generic NPC to detailed custom class. All rectangles and straight lines. Square jaw, baseball cap, flat unimpressed eyes, work shirt with "FRANK" name tag, belt with key ring, wrench in one hand, coffee mug in the other, heavy work boots. The least spiritual character in the game.
- **New character factory registrations**: All 4 new characters registered in `character_factory.gd` with proper class mappings and accent colors.
- **Project documentation**: CLAUDE.md (agent instructions), CHANGELOG.md (this file), CONTRIBUTING.md (how to update docs and code), updated README.md with current project state.

### Fixed — 2026-03-13
- **Expression enum collision**: Renamed `Expression` enum to `Emotion` across all 7 character scripts to avoid collision with Godot's built-in `Expression` class.

### Previously added — 2026-03-13
- **Project scaffolding**: Full folder structure for docs, game, art, audio, scripts, prototype
- **Design documentation** (26 markdown files):
  - Game design: combat system, progression, items/loot, puzzles/dialogue, enemy archetypes
  - Lore: Steve character sheet, the wife's transformation trail, Zone 1 faction (The Sanctuary), Zone 1 enemies (8 types + 2 elites + 4 NPCs), Zone 1 boss (The Founder/Paul, 3-phase fight, 3 endings), character idea bank (27+ concepts)
  - World: 10-zone setting overview, 20 scene/encounter concepts
  - Dialogue: Zone 1 NPC dialogue trees, enemy battle dialogue, elite encounters, boss battle dialogue (3 phases), 50+ ambient snippets
  - Items: 30+ Zone 1 items with stats and flavor text
  - Quests: Main quest + 4 side quests + optional encounters
  - Planning: MVP scope definition, decisions log
  - Art direction: visual language and style guide
- **HTML prototype** (`prototype/trust-the-process.html`): Single-file browser playable with title screen, 6-page intro, 3-room exploration, NPC dialogue trees, turn-based combat vs Essential Oil Warrior
- **Godot project** (`game/godot/`):
  - Project configuration: 960x640 viewport, GL Compatibility, 3 autoloads, input mappings
  - `GameState` singleton: HP, EP, Normality, Insight, Cacao stats with signals; inventory system; flag/quest tracking
  - `DialogueManager` singleton: All Zone 1 dialogue trees with branching, choices, callbacks, goto redirects
  - `SceneManager` singleton: Fade-to-black transitions
  - Title screen with blinking prompt
  - Intro screen with 6-page typewriter backstory
  - Exploration scene: 3-room navigation (Pavilion, Path, Garden), NPC interaction, dialogue display, HUD
  - Battle scene: Full turn-based combat with 6 action types, status effects, victory/defeat overlays, item usage
- **Stick figure character system**:
  - `StickCharacter` base class: expressions, poses, idle animation, hover/click, reactions
  - `CharacterFactory`: NPC spawning by ID with preset configurations
  - Character subclasses: Steve (rigid accountant), Oil Warrior (flowing MLM zealot), Breathwork Monk, Cacao Dealer, Generic NPC (configurable body/hair/props)
- **Git repository** initialized and pushed to `https://github.com/jeppelina/trust-the-process.git`

### Fixed — 2026-03-13
- **Dialogue advancement bug**: `DialogueManager.is_typing` was never cleared by exploration's local typewriter, causing `advance()` to eat clicks (user had to click twice per line). Fixed by setting `DialogueManager.is_typing = false` when exploration's typewriter finishes or is skipped.
- **Intro text cutoff**: IntroText RichTextLabel had fixed 700x200px centered box — too small for longer pages (credit card charges page). Changed to anchor-based sizing (8% margins, 82% bottom) with scroll enabled.
- **Battle submenu not appearing**: `_show_submenu()` toggled inner `SubMenu` VBoxContainer but parent `SubMenuPanel` PanelContainer stayed hidden. Added `%SubMenuPanel` unique name reference and toggled it instead.
- **Dialogue text overflow**: DialogueBox in exploration used `fit_content=true` on RichTextLabel causing overflow. Replaced with proper VBoxContainer layout, MarginContainer padding, and ScrollContainer wrapping.
- **No mouse input for dialogue**: Only Space key advanced dialogue — no clickable area for mouse users. Added invisible ClickArea Button over dialogue panel, connected to `_handle_advance()`.
- **HUD background not containing content**: Was a sibling ColorRect, not properly wrapping. Replaced with PanelContainer hierarchy.
- **Battle log overflow**: Log text could overflow its container. Wrapped in ScrollContainer with `scroll_active=true`.
- **Continue prompt unclear**: Changed from just "▼" to "▼ Click or press SPACE to continue".
