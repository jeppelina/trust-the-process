# Roguelite Loop Design — "Trust the Process"

## THE CORE IDEA

Steve doesn't just visit each zone once and move on. He **lives through days**. Each zone is a multi-day experience — a retreat, a festival, a camp — and the roguelite structure mirrors how these places actually work: you arrive confused, survive the first day, sleep, wake up, and each day you understand a little more, can do a little more, and the place reveals new layers.

Inspired by Hades 2's loop of "attempt → die/succeed → return to hub → grow → try again," but reframed through the lens of spiritual retreat culture where **the loop IS the satire**. The retreat wants Steve to keep cycling through "the process." Steve wants to escape. The player wants to get stronger. All three goals align mechanically but conflict narratively — and that's where the humor lives.

---

## THE DAY/NIGHT CYCLE

Each zone plays out over multiple **Days**. A Day is one complete run through the zone's content.

### Structure of a Day

```
MORNING  →  DAYTIME  →  EVENING PROGRAM  →  NIGHT  →  SLEEP  →  (next day)
```

**Morning (Hub Phase)**
- Steve wakes up in the zone's dormitory/sleeping area
- Brief NPC interactions (bunkmates, kitchen breakfast, morning announcements)
- Choose what to bring for the day (limited carry slots — see Items)
- Check the Daily Schedule board (procedurally shuffled events and encounters)
- Optional: spend meta-currency on permanent upgrades before heading out

**Daytime (Exploration + Combat Phase)**
- Freely explore the zone's rooms
- NPC conversations, side quests, optional fights
- Story beats trigger based on Day number + flags
- Random encounters appear in certain rooms (pulled from the zone's encounter pool)
- Timed events: some things only happen at specific times (e.g., the 11am yoga class blocks the Movement Studio, but the teacher drops a key item if you attend)

**Evening Program (Set Piece)**
- Each Day has a mandatory or semi-mandatory evening event
- Day 1: Sharing Circle. Day 2: Sound Healing. Day 3: Guest Speaker. Etc.
- These are dialogue/choice gauntlets, not combat — but they have mechanical consequences
- Attending earns Insight and unlocks night content. Skipping is possible but has social consequences

**Night (High-Risk Phase)**
- Restricted movement. Some rooms locked, new rooms open
- Black market available (Cacao Dealer)
- Key story scenes (Fire Pit conversations, night infiltration)
- Harder random encounters (night patrol, sleepwalkers, "sacred rage" practitioners)
- This is when you attempt the zone's main objective (e.g., breaking into the Back Office)

**Sleep (Reset Phase)**
- Steve goes to bed. Fade to black.
- Health and EP fully restore
- Some buffs/debuffs carry over, most reset
- New morning dialogue reflects what happened yesterday
- Day counter advances

### What Triggers the Boss

The boss fight doesn't happen on a fixed day. It triggers when Steve has gathered enough **Evidence** — key items, conversations, and discoveries that build the case against the zone's antagonist. Evidence is tracked as a meter or checklist visible to the player.

If Steve rushes, he might reach the boss on Day 3 with minimal Evidence (hard fight, limited options). If he explores thoroughly, he might not face the boss until Day 5 or 6 but have stronger skills, more spiritual enhancements, and multiple resolution paths.

This means the loop rewards patience and exploration without punishing speed — exactly like Hades, where you can rush or farm.

---

## EGO DEATH (THE "DEATH" MECHANIC)

When Steve's HP hits 0, he doesn't die. He **Achieves Ego Death.**

The screen goes white. A gentle voice says something like: "Let go, Steve. Let go of your quarterly projections."

Steve wakes up in the Dorms. It's the next morning. A Karma Yogi is standing over him with a singing bowl.

### What Resets on Ego Death

- Current fight resets (enemy returns to full HP)
- Steve returns to Dorms with 50% HP and EP
- The current Day's time of day resets to Morning
- Temporary buffs and some consumables are lost
- **Normality drops by 5** (Steve is involuntarily "opening up")

### What Persists Through Ego Death

- All permanent upgrades and unlocked skills
- Quest progress and Evidence gathered
- NPC relationship states and dialogue flags
- Equipment and non-consumable inventory
- Day counter does NOT reset (you lose time, not progress)
- Insight gained stays

### The Humor

NPCs congratulate Steve on his ego death. They think it's spiritual growth. Brandon is deeply impressed. The Receptionist updates Steve's file. Every ego death makes Steve slightly more "spiritual" against his will, which is both mechanically useful (lower Normality unlocks spiritual skills) and narratively horrifying (Steve is becoming one of them).

**Ego Death counter is displayed in the HUD.** NPCs reference it. "I hear you've had three ego deaths this week! You're really doing the work."

---

## SKILL PROGRESSION

> **Full skill details:** See `docs/game-design/skill-tree.md` and `docs/game-design/progression-system.md` for complete skill tables, unlock conditions, and enhancement details. This section covers the roguelite loop integration.

### Starting State: Steve Is Weak

Steve arrives at Zone 1 with three skills:

- **Slap** (5 Physical damage, 0 EP) — Steve open-hand slaps someone. It's undignified for everyone involved.
- **Complain** (4 Psychic damage, 0 EP) — "The water pressure in the shower is unacceptable."
- **Set Boundary** (blocks attacks for 2 turns, free action) — "I'm not comfortable with this."

Plus: Endure (defend), Item (use consumable), Flee (70% success rate).

That's it. No special skills. No magic. Steve is a 38-year-old accountant who has never been in a fight. The SPIRIT button is greyed out: "Steve doesn't do... whatever this would be."

### The Three Progression Systems

**1. Physical (Fists) — Player Choice.** Unlocked by USING physical attacks. Permanent counter, never resets. Slap → Shove (3 attacks) → Throw Rock (8) → Punch (15) → Headbutt (25) → Tackle (40). The arc: embarrassing flailing to genuine frightening competence.

**2. Verbal (Mouth) — Player Choice.** Unlocked by USING verbal attacks + meeting Insight thresholds. Complain → Nag (5 verbal + Insight 1) → Insult (12 verbal + Insight 2) → Mock → Gaslight → Manipulate → Silence. The arc: polite deflection to psychological warfare.

**3. Spiritual (Involuntary) — Happens to Steve.** Gated by Normality drop. Normality drops from sleeping (-1/night), ceremonies (-3), ego death (-5). As it drops:
- **Standalone abilities appear** in SPIRIT menu (Panic Breathing, Sage Toss, The Nod, Sound Bath, Hold Space, Mirror, Genuine Vulnerability)
- **Existing skills TRANSFORM** — Slap becomes Energy Slap (palm glows), Complain becomes Mindful Complaint (DOT), Shove becomes Force Push (guaranteed stun). The player opens their skill menu one morning and something has changed. Steve is horrified.

### Why This Loops Well

The attack counters create "almost" moments — at end of Day 2, the player sees "Throw Rock: 5/8 physical attacks." Two more fights would unlock it. That's the "one more day" feeling.

Normality creates involuntary progression — the player can see the next transformation threshold: "Normality: 72. Next at ≤ 70: The Nod + Crystal Launch." They can't stop it. Some players will rush toward it. Others will dread it. Both reactions are correct.

The daily perk system (future) adds variety — each morning, pick 1 of 3 random temporary bonuses. Same zone, different Steve.

### Three Damage Types

| Type | Source | Strong Against |
|------|--------|---------------|
| **Physical** | Fists skills | Anyone with no combat training (most hippies) |
| **Psychic** | Mouth skills | Anyone with insecurity or a persona to protect |
| **Spiritual** | Spirit skills + enhanced skill bonuses | Anyone spiritually "open" (everyone here except early Steve) |

Enhanced skills deal their original type PLUS spiritual, hitting enemies on two fronts. This is why spiritual progression makes everything stronger.

---

## ENEMY DIFFICULTY CURVE

### Design Principle: Everyone Starts Pathetic

The early game should feel like two non-fighters awkwardly fighting. Steve can't fight. Hippies can't fight. Nobody here is a warrior. The escalation comes from:

1. Enemies getting more *delusional* (and thus more dangerous — belief is power here)
2. Enemies getting more *organized* (higher zones have structure, hierarchy, trained practitioners)
3. Steve getting dragged into progressively weirder situations

### Tier 0: Pushovers (Days 1-2 of Zone 1)

These enemies barely fight. They mostly just bother Steve until he pushes back. Steve can beat them with Basic Slap alone.

| Enemy | HP | Damage | Behavior | Why They're Easy |
|---|---|---|---|---|
| **Lost Tourist** | 15 | 2 (confused flailing) | Wanders into Steve. Doesn't know what's happening either. | Literally just another confused person. Fight ends if you Talk once. |
| **Aggressive Hugger** | 20 | 3 (squeeze) + Hugged debuff | Approaches for unsolicited hug. Won't take no for an answer. | Falls over if you push back. Literally. |
| **Feral Sound Healer** | 25 | 5 (off-key chanting) | Follows Steve playing a badly tuned ukulele. Psychic damage from cringe. | Zero physical presence. Steve can outlast them just by Enduring. |
| **Pamphlet Pusher** | 20 | 4 (throws pamphlets) | Hurls workshop flyers. Persistent but weak. | Will leave if Steve tears up one pamphlet in front of them. |

**First-fight comedy:** Steve vs. the Aggressive Hugger. Steve slaps. The Hugger tries to hug. Steve slaps again. The Hugger says "I sense a lot of resistance in your body." Steve says "Yes. That's called not wanting to be touched." The Hugger falls over. +1 Insight.

### Tier 1: Annoying (Days 2-4 of Zone 1)

Stronger than pushovers but still not threatening. They have one gimmick each.

| Enemy | HP | Damage | Gimmick | Weakness |
|---|---|---|---|---|
| **Essential Oil Warrior** | 45 | 10-12 | MLM Pitch timer (5 turns = auto-enrolled) | Psychic: verbal attacks expose finances |
| **Competitive Meditator** | 60 | 15 (psychic) | Reflects attacks while meditating | Bore: can't meditate if he's bored |
| **Kombucha Evangelist** | 35 | 8 + poison chance | Throws jars. Explode on miss (AOE) | Any Talk action. Very insecure. |
| **Instagram Yogi** | 40 | 10 (psychic) | Gains power if you watch. Weakens if ignored. | Ignore for 3 turns. Self-destructs from lack of attention. |

### Tier 2: Legitimately Dangerous (Days 4-6 / Zone 1 mid-game)

These enemies have trained in *something*, even if that something is dubious.

| Enemy | HP | Damage | Threat | How to Handle |
|---|---|---|---|---|
| **Breathwork Apostle** | 80 | 18 (spiritual) + Activated debuff | Actually hits hard. Breathwork is real physical exertion. | Endure the first wave, then exploit the crash (they hyperventilate and stun themselves) |
| **Boundary Crosser** | 70 | 15 + stun (physical contact) | Stuns through touch. Hard to avoid. | Set Boundary talk action. 3x Boundary = instant win. |
| **Shadow Worker** | 90 | 12 (psychic) + Mirror debuff | Reflects 50% damage. Forces you to hurt yourself. | Cold Read: expose *their* shadow. Or use spiritual attacks (not reflected). |
| **The Gatekeeper** | 150 | 20 (psychic authority) | Blocks attacks with "You're Not Ready." Must be debunked. | Cold Read reveals his real backstory. Each truth removes armor. |

### Tier 3: Zone Boss and Phase Bosses

Bosses follow the 3-phase pattern (Mask → Crack → Person). Their difficulty scales with how much Evidence you've gathered — more Evidence means more attack options, not necessarily an easier fight.

### Cross-Zone Scaling

Each new zone starts Steve against the local equivalent of Tier 0 enemies, but they're thematically harder:

- **Zone 1** (Retreat): Pushovers are confused tourists and aggressive huggers
- **Zone 2** (Breathwork): Pushovers are hyperventilating beginners who pass out mid-fight
- **Zone 3** (Healing): Pushovers are crystal sellers who are mostly just sad
- **Zone 5** (Tantra): Pushovers are... Steve doesn't want to talk about it
- **Zone 10** (Burning Man): Even the pushovers are on something. Unpredictable.

---

## THE ANTAGONISM MECHANIC

### Mutual Resentment

Steve resents the retreat people. The retreat people resent Steve's normality. This isn't one-directional contempt — it's a two-way social friction that drives both combat and dialogue.

### How It Works: The Vibe Meter

Each zone tracks Steve's **Vibe** — how the local community perceives him.

**Low Vibe (Steve is resisting):**
- NPCs are suspicious, dismissive, or try to "fix" Steve
- Shop prices increase ("we need to charge more for your energy cleansing")
- Random encounters are more frequent (people keep trying to help)
- Some doors/events are locked ("this space isn't for you right now")
- BUT: Steve's Normality stays high → Corporate skills are strong

**High Vibe (Steve is participating):**
- NPCs are warm, inclusive, share information freely
- Shop prices decrease (gift economy benefits)
- Fewer random encounters (people leave Steve alone)
- Access to deeper content and optional scenes
- BUT: Normality drops → Vulnerable to spiritual attacks

**The Push-Pull:** The game constantly asks: do you want to be effective in combat (high Normality, low Vibe) or effective in exploration/social (low Normality, high Vibe)? The answer, as in Hades, is "a bit of both, shifting run to run."

### NPC Hostility Triggers

Enemies don't attack Steve because he's an enemy. They attack because his normality **offends** them:

- The Crystal Healer attacks because Steve's "closed energy" is "literally poisoning the space"
- The Breathwork Apostle attacks because Steve's shallow breathing is "disrespectful to the practice"
- The Gatekeeper attacks because Steve's presence "lowers the vibration of the ceremony"
- The Competitive Meditator attacks because Steve's inability to sit still is "a personal affront"

Steve, in turn, fights back because these people won't leave him alone. He's not a warrior. He's a guy who wants to find his wife and go home. Every fight should feel like Steve has been *forced* into it by someone else's inability to respect a boundary.

---

## WHAT PERSISTS BETWEEN DAYS (META-PROGRESSION)

### Permanent (Survive Between Days and Zones)

| Element | How Gained | Notes |
|---|---|---|
| **Insight Level** | XP from fights, quests, events | Never lost. Steve's understanding only grows. |
| **Unlocked Skills** | Insight thresholds + Normality thresholds | Once unlocked, always available (if Normality still qualifies) |
| **Evidence** | Key conversations and items | Builds toward boss trigger |
| **NPC Relationships** | Dialogue choices | People remember. Brandon remembers. |
| **Quest Progress** | Quest flags | Half-finished quests persist |
| **Equipment** | Found/bought | Permanent unless sold |
| **Ego Death Count** | Deaths | Permanent. NPCs reference it. |
| **Journal Entries** | Found collectibles | Permanent story/lore items |
| **The Daily Board** | Completed entries from previous days | Shows what Steve has survived, tracks accomplishments |

### Resets Each Morning

| Element | Why It Resets | Comedy |
|---|---|---|
| **HP and EP** | "Sleep heals all wounds" | Steve slept on a yoga mat. Somehow fine. |
| **Temporary Buffs/Debuffs** | Fresh day | The "Activated" feeling from last night's breathwork has faded. Thank God. |
| **Room States** | New day, new events | The Movement Studio has a different class. The Kitchen has a new menu. |
| **Random Encounter Pool** | Procedural variety | Different weirdos on different days |
| **Daily Schedule** | Procedurally shuffled | New evening program, new workshops, new "opportunities" |
| **Consumable Restocking** | Shops refresh | Cacao Dealer has new inventory |

### Resets on Ego Death (Partial Loss)

| Element | How Much Lost | Flavor |
|---|---|---|
| **Current Day Progress** | Time of day resets to Morning | You lose the afternoon, not the week |
| **Some Consumables** | 50% of carried consumables | "Someone rearranged your bag while you were unconscious. For feng shui reasons." |
| **Normality** | -5 | Involuntary spiritual growth. Steve hates this. |
| **Temporary Buffs** | All lost | The ego death wipes the slate clean |

---

## DAILY SCHEDULE SYSTEM

Each morning, the zone's Daily Schedule board shows the day's events. These are semi-randomly generated from the zone's event pool, giving each day a different texture.

### Example Zone 1 Schedule (Day 3)

```
═══════════════════════════════════════════
   THE SANCTUARY — DAILY SCHEDULE
   Day 3 of Your Transformational Journey
═══════════════════════════════════════════

  7:00  —  Silent Breakfast (Kitchen)
  9:00  —  "Radical Honesty Workshop" (Main Hall)
 11:00  —  Advanced Meditation (Movement Studio)
  1:00  —  Karma Yoga Service (Garden)
  3:00  —  Free Time / Integration
  5:00  —  Community Dinner (Kitchen)
  7:00  —  ★ EVENING: Sound Healing Journey ★
  9:00  —  Night Activities Unlocked

           "You are exactly where you
            need to be." — Paul
═══════════════════════════════════════════
```

### Event Types

**Workshops (Optional but Rewarding)**
- Attend for Insight, NPC interactions, skill unlocks
- Sometimes boring, sometimes surreal, always satirical
- Can leave early but NPCs notice

**Karma Yoga (Work Shifts)**
- Help in the kitchen, garden, etc.
- Builds Vibe and NPC trust
- Sometimes reveals information (overhear gossip, find hidden items)
- Steve is actually good at organized labor. This surprises everyone.

**Evening Programs (Semi-Mandatory)**
- Skip at social cost (Vibe drop, NPC suspicion)
- Attend for major Insight gains and story progression
- Each is a unique set piece: Sharing Circle, Sound Healing, Guest Speaker, Fire Ceremony, Ecstatic Dance
- Some contain critical Evidence for the boss fight

**Night Activities**
- Black market shopping
- Key story conversations
- High-risk exploration (sneaking into restricted areas)
- Harder random encounters

---

## ITEM SYSTEM (ROGUELITE LAYER)

### Carry Limits

Steve has limited carry slots for each day. He can store extra items in the Dorms.

- **Active Carry:** 6 consumable slots + equipped gear
- **Dorm Storage:** Unlimited (safe, persistent)

Each morning, Steve chooses what to bring. This is a roguelite decision: bring healing items for a combat-heavy day, or bring evidence items for a social day?

### Item Sources

| Source | Type | Refresh |
|---|---|---|
| **Enemy Drops** | Random from loot table | Per fight |
| **Cacao Dealer** | Curated shop, changes daily | Each morning |
| **Gift Shop** | Fixed inventory, expensive | Doesn't refresh |
| **Quest Rewards** | Unique items | One-time |
| **Found/Stolen** | Environmental items (hidden in rooms) | Some respawn, some one-time |
| **Workshop Loot** | Attend events, get items | Daily events |

### Cacao Economy

**Cacao is the universal currency** — earned from fights, found in rooms, rewarded for quests. The Cacao Dealer is the primary shop, operating a black market out of the kitchen area at night.

The Dealer's inventory rotates daily, creating Hades-style "what's available this run" decisions:

```
Day 1: Healing items only (Kombucha, Energy Bar, Cacao Drink)
Day 2: Weapons appear (Crystal Club, Red Pen of Authority)
Day 3: Specialty items (WiFi Password, Actual Coffee, Phone Charger)
Day 4: Rare stock (Evidence Folder, Founder's Book, Bus Schedule)
```

---

## ZONE STRUCTURE IN THE ROGUELITE FRAMEWORK

### Zone 1: The Sanctuary (3-6 Days)

**Minimum Days:** 3 (if Steve rushes, gathers minimum Evidence)
**Optimal Days:** 5 (thorough exploration, all side quests)
**Maximum Days:** 7 (after Day 7, the zone auto-escalates to boss)

**Day 1:** Arrival. Check-in. Oil Warrior fight. Meet Frank. Everything is confusing.
**Day 2:** Meet Maya, Brandon. Explore deeper rooms. First evening program.
**Day 3:** Fire Pit scene unlocks. Night infiltration possible. Gatekeeper encounter.
**Day 4-5:** Side quests, secrets, Evidence gathering. Deeper NPC relationships.
**Day 6:** Boss trigger if Evidence sufficient. Otherwise, tension escalates (NPCs get suspicious of Steve, random encounters get harder).
**Day 7 (hard limit):** The Founder confronts Steve regardless. "You've been asking a lot of questions, Steve."

### Zone Escalation (The "Overstay" Mechanic)

Staying too long in a zone has consequences:

- **Day 5+:** NPCs start asking pointed questions. "You seem very interested in our operations."
- **Day 6+:** Random encounters include "concerned facilitators" who are actually zone security.
- **Day 7:** Forced boss encounter with minimal prep. Steve has been noticed.

This creates the Hades tension: do you take one more day to prepare, or do you push into the boss fight now?

### Multi-Zone Progression

```
Zone 1: The Sanctuary (Retreat Center)     — 3-7 days
Zone 2: Pranayama Peak (Breathwork Camp)   — 3-7 days
Zone 3: Crystal Vortex (Healing Center)    — 4-8 days
Zone 4: The Ashram (Spiritual Community)   — 4-8 days
Zone 5: Tantra Temple                      — 4-8 days
Zone 6: The Medicine Circle (Ayahuasca)    — 5-9 days
Zone 7: Men's Fire Camp                    — 4-8 days
Zone 8: The Poly House                     — 3-7 days
Zone 9: Spirit Fest (Music Festival)       — 5-9 days
Zone 10: Burning Man                       — 7-14 days (final zone)
```

Between zones, Steve has a **Travel Day** — a brief hub phase where he reviews his progress, makes permanent upgrades, and reads his wife's next journal entry. This is the Hades "House of Hades" equivalent.

---

## THE WIFE'S TRAIL (NARRATIVE BACKBONE)

Each zone ends with Steve finding his wife's next destination. But the roguelite structure adds a layer: **her journal entries**, found scattered through each zone, reveal that she went through the same progression Steve is going through — but willingly.

As Steve picks up spiritual skills against his will, the journal entries show his wife picking up the same skills *enthusiastically*. The parallel is the emotional core of the game:

- Zone 1 journal: "I tried breathwork today. I felt something. I don't know what."
- Zone 3 journal: "The crystals are nonsense. But holding them makes me feel calm. Is that the same thing?"
- Zone 5 journal: "I sat in a circle and said the most honest thing I've ever said. Everyone cried. I cried. Steve would never do this. That thought makes me sad."
- Zone 8 journal: "I don't know if I want to go home. That scares me."
- Zone 10 journal: "I think I understand now. Not the crystals or the breathwork. I understand why I left."

The roguelite loop mirrors this: Steve can't just pass through quickly. He has to *live* in each place, absorb it, be changed by it — just like his wife was.

---

## SAVE AND PROGRESSION SYSTEM

### Auto-Save Points

- Every morning (start of day)
- After every boss fight
- After zone completion
- After ego death (respawn point)

### No Manual Saving During a Day

Like Hades, the game auto-saves at natural break points. You can quit mid-day and resume, but you can't save-scum a conversation or fight. This reinforces the roguelite commitment: your choices stick.

### New Game+ (Post-Completion)

After beating the game, Steve can replay zones with all skills and equipment. The enemies scale up, new dialogue appears, and the wife's journal entries are replaced with Steve's own journal — revealing his internal monologue during the first playthrough.

NPCs recognize Steve. "Aren't you the accountant who restructured The Sanctuary?" Some are grateful. Some are angry. Some ask for tax advice.

---

## IMPLEMENTATION NOTES

### Priority Order

1. **Day/Night cycle for Zone 1** — morning hub, daytime exploration (already partially built), evening program (Sharing Circle exists), night phase
2. **Ego Death mechanic** — respawn in Dorms, Normality drop, NPC dialogue changes
3. **Skill unlock system** — Insight + Normality thresholds, skill menu in battle
4. **Tier 0 enemies** — 4 pushover enemies for early Days
5. **Daily Schedule board** — procedural event selection from pool
6. **Cacao Dealer daily inventory** — rotating stock
7. **Evidence tracker** — visible meter, boss trigger
8. **Boss fight with Evidence scaling** — more evidence = more options

### Compatibility with Existing Systems

This design extends rather than replaces the existing systems:

- **GameState** gets new fields: `current_day`, `ego_death_count`, `evidence_gathered`, `daily_schedule`
- **DialogueManager** gets day-aware dialogue variants: `receptionist_day1`, `receptionist_day2`, etc.
- **Battle system** gets the new Tier 0 enemies added to ENEMY_DB
- **Exploration** gets time-of-day gating for rooms and events
- **SceneManager** handles the morning/evening/night transitions

### What Stays the Same

- The 3-phase boss pattern
- The Normality tension mechanic
- The room navigation system
- The stick figure art style
- The dialogue tree structure
- The core stats (HP, EP, Normality, Insight)
- The damage type system (Physical, Psychic, Spiritual)
- Everything about the tone and humor

---

## SUMMARY: WHY THIS WORKS

The roguelite loop isn't just a gameplay layer — it's a **satire delivery mechanism**.

Real spiritual retreats work on a loop: wake up, attend programs, eat communal meals, have a "breakthrough," sleep, do it again. Each day you're a little more embedded, a little more fluent, a little more "in it." Steve's roguelite loop mirrors this exactly. He doesn't want to be here. He doesn't want to learn crystal healing. He doesn't want to have an ego death. But each day peels back another layer, and by the time he faces the boss, he's become someone who can *hold space* and *cold read someone's deepest insecurity* in the same turn.

That's the game. That's the joke. That's the process.

*Trust it.*
