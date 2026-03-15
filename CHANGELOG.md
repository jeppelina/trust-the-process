# Changelog

All notable changes to this project are documented in this file. Format loosely follows [Keep a Changelog](https://keepachangelog.com/).

When updating: add new entries at the TOP of the relevant section. If today's date already has an entry, append to it. Always note which files were affected.

---

## [Unreleased]

### Changed — 2026-03-15 (Patch 5: Dialogue Polish & Bug Fixes)
- **Rotating combat log messages** — Slap, Complain, Set Boundary, Panic Breathing, Endure, Flee, and boundary-blocking messages now draw from pools of 4-7 rotating lines each. DOT expiry messages also rotate. Victory screen title rotates between VICTORY/RESOLVED/BOUNDARY ENFORCED/INTERACTION SURVIVED
- **Varied random encounter intro text** — 6 per-area rotating encounter introduction lines for Path and Garden (replaces generic "Something stirs..." text)
- **Room flavor text** — All 10 rooms now show rotating ambient descriptions on entry (2-3 per room), displayed as grey italicized text in the dialogue panel
- **NPC return dialogue polish** — Receptionist (5 rotating lines), Frank (5 rotating lines), Brandon generic (4 rotating lines), Breathwork Monk (3 rotating lines with EP restore). All return dialogues now use function-based dialogue data (`() => [...]`) to re-evaluate `pickRandom()` on each visit instead of once at page load
- **Dialogue copy improvements** — Richer Oil Warrior fight intro, Steve's circus audit line at fire pit, Gatekeeper "lateral move" beat, Founder defeat text expanded ("Canva flyer" origin story), intro page 6 button ("You packed a pen. For forms."), Breathwork Monk return visits restore EP
- **BUG FIX (CRITICAL): Boss Phase 2 HP reset** — `advanceBossPhase()` now resets `battleState.enemy.hp = battleState.enemy.maxHp` when transitioning from Phase 1 (Brandon) to Phase 2 (Paul). Previously Phase 2 inherited Phase 1's remaining HP, making the boss trivially easy
- **BUG FIX: Ego death day cycle reset** — Ego death now properly resets `timeOfDay`, `actionsLeft`, `eveningActionsLeft`, and clears `night_mode` flag (same as `goToSleep`). Previously ego death left the action economy in whatever state it was in
- **BUG FIX: Breathwork Monk return dialogue** — Added `talked_breathwork_monk` flag and callback so the Monk's return dialogue triggers correctly on subsequent visits
- **Added `getLogText()` and `pickRandom()` utility functions** for combat log variety system

### Added — 2026-03-15 (Patch 4: Zone 1 Extension)
- **Zone 1 Extension Plan** — Full design doc at `docs/planning/zone1-extension-plan.md` covering: nerfed starting stats (HP 60, EP 30, Normality 95), 6 Max HP/EP growth sources, Meditator as Day 3 skill-check wall with Stillness Shield, two grinding areas (Path + Garden) with weighted random encounter pools, 9 new random encounter enemies, action economy (4 day + 2 evening actions), Brandon's 5-day conversion arc with Timex watch, equipment drop system
- **9 new random encounter enemies in prototype** — Aggressive Hugger, Pamphlet Pusher, Feral Sound Healer, The Oversharer (combat), Yoga Snob, Boundary Violator, Shadow Work Enthusiast (with mirror mechanic), Kombucha Evangelist, Instagram Yogi — each with unique attacks, loot drops, and defeat dialogue
- **Random encounter system** — `ENCOUNTER_POOLS` with day-gated weighted pools for Path and Garden, `rollRandomEncounter()`, `triggerRandomEncounter()`, "Take a Walk" grinding buttons in Path and Garden rooms
- **Nerfed starting stats** — HP 100→60, EP 50→30, Normality 90→95, Slap 5→4 dmg, Panic Breathing gate 85→90 (unlocks earlier now)
- **Meditator Stillness Shield** — HP 45→60, ATK 10→12, new 50% damage reduction shield; broken by Throw Rock/Punch/Headbutt (crude physical), 50% break chance on Shove, psychic halved through shield, basic slap halved
- **Action economy** — 4 day actions + 2 evening actions per day, auto-transition to evening phase, time-of-day display in HUD
- **Brandon's 5-day conversion arc** — Dynamic daily dialogue: Day 1 (happy tourist, dad's watch), Day 2 (retreat whites), Day 3 (watch donated to gratitude fund), Day 4 (glazed eyes, fasting, "special sensitivity"), Day 5 (Surya Dev, won't talk). Flag tracking: `brandon_watch_seen`, `brandon_watch_donated`, `brandon_day[1-5]_done`
- **Max HP/EP growth events** — +5 HP from first night's sleep, +5 EP from forced meditation (Day 2), +5 HP from surviving Sharing Circle. Each tracked by bonus flags to prevent double-granting
- **Equipment drop system** — First-kill guaranteed drops, subsequent kills use dropChance (30-50%). Loot notifications. 9 unique drops: Consent Card, Workshop Flyer, Off-Key Ukulele, Emotional Baggage, Overpriced Yoga Mat, Consent Pamphlet, Jung Book, Homemade Kombucha, Ring Light
- **Shadow Work Enthusiast mirror mechanic** — Mirror attack reflects 30% of player's next attack back at Steve

### Changed — 2026-03-15
- **Old skill/damage type purge across all docs** — Replaced all references to old 5-type damage system (Physical, Psychic, Bureaucratic, Spiritual, Cringe) with new 3-type system (Physical, Psychic, Spiritual) across: `CLAUDE.md`, `README.md`, `roguelite-loop.md`, `items-and-loot.md`, `skill-tree.md`, `retreat-center-plan.md`, `puzzles-and-dialogue.md`, `zone1-enemies.md` (characters), `zone1-boss.md`, `zone1-elites.md` (dialogue), `zone1-boss-battle.md` (dialogue), `scene-bank.md`, `zone1-items.md`. Old skill names (Spreadsheet Analysis, Risk Assessment, Schedule Optimization, Audit) replaced with new verbal branch equivalents (Cold Read, Manipulate, Insult). Orientation Pamphlet changed from starting weapon to evidence item. Battle menu references updated from Attack/Skills/Talk/Analyze/Items/Endure to FIGHT/MOUTH/SPIRIT/ITEM/ENDURE/FLEE. Note: `game/godot/scripts/battle.gd` still has old references — will be updated in Godot patch.

### Added — 2026-03-15
- **Skill tree redesign v2** — Major restructure of `docs/game-design/skill-tree.md`: Physical and Verbal are now the two player-choice branches ("warrior or wizard"), Spiritual is mandatory/involuntary progression gated by Normality drop. Replaced standalone combo skills with "Spiritual Enhancements" that automatically transform Physical and Verbal skills as Normality drops (e.g. Slap → Energy Slap, Insult → Accurate Insult). Added enhancement notification system with Steve's horrified reactions. Standalone spiritual abilities (healing, defense, utility) remain in SPIRIT menu.
- **Skill system in HTML prototype (Patch 3)** — Complete battle system rewrite in `prototype/trust-the-process.html`: new FIGHT/MOUTH/SPIRIT/ITEM/ENDURE/FLEE battle menu with branch submenus, SKILL_DB with 11 skills across 3 branches (Physical tiers 0-3, Verbal tiers 0-2, Spiritual tiers 0-2), ENHANCEMENT_DB with 3 spiritual transformations (Energy Slap, Mindful Complaint, Force Push), use-based unlock system with permanent physicalAttacks/verbalAttacks counters, Normality-gated spiritual abilities and skill enhancements, Skills tab in ☰ menu with progress bars and Normality ticker, skill unlock/transformation notification overlays, enemy rebalance (Oil Warrior 30HP weak to psychic, Meditator 45HP weak to physical, Gatekeeper 60HP weak to psychic), Normality drops on sleep (-1) and ceremony (-3), flee mechanic, DOT/stun/smoke/block/pin combat effects
- **Day cycle + quest menu in HTML prototype** — Day counter in HUD, sleep button in Dorms, ego death advances day, enemy respawn on sleep, boss gated behind Day 3 + all story flags, ☰ menu with Quests and Items tabs, progressive quest reveal
- **Roguelite loop design document** — Comprehensive game design doc at `docs/game-design/roguelite-loop.md` covering: Hades 2-inspired day/night cycle, multi-day zone structure, ego death as roguelite reset, two-branch skill progression tree (Practical Skills + Reluctant Spiritual Skills starting from Basic Slap), 4-tier enemy difficulty curve starting with pathetic pushover enemies, mutual antagonism/Vibe mechanic, daily schedule system, carry-limit item strategy, Evidence-based boss triggering, zone escalation ("overstay" pressure), cross-zone scaling for 10 zones, meta-progression vs daily reset design, and wife's journal as narrative backbone

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
