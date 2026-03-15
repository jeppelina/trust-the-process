# Zone 1 Extension Plan — "The Sanctuary"

## The Core Problem Right Now

The prototype has a battle system that works, but it's a series of encounters strung together with flags. There's no *zone*. No sense of days passing, power growing, relationships forming. The player doesn't feel the grind because there's nothing to grind against and no reason to care.

This plan turns Zone 1 into a place you *live in* for 5-7 in-game days, where every morning you wake up slightly different, slightly less normal, slightly more capable — and slightly more attached to people you didn't expect to care about.

---

## DESIGN PILLAR: Steve Is Weak. The World Is Strong.

### Starting Stats (Nerfed)

Steve arrives exhausted, underfed, and completely out of his element.

| Stat | Old Value | New Value | Why |
|------|-----------|-----------|-----|
| HP | 100 | 60 | Steve is a desk worker. He has never been in a fight. |
| Max HP | 100 | 60 | Grows through the zone (see below) |
| EP | 50 | 30 | He has the emotional reserves of a man who just drove 6 hours |
| Normality | 90 | 95 | Higher starting point = more room to fall |
| Slap damage | 5 | 4 | He's slapping people with an accountant's wrist |

### How Steve Gets Stronger (Not Through Leveling)

Steve doesn't "level up." He adapts. His body and mind change because the retreat *forces* them to change. Every HP/EP increase has a narrative reason:

**Max HP Increases:**

| Source | HP Gained | When | Flavor |
|--------|-----------|------|--------|
| First full night's sleep at retreat | +5 (→65) | End of Day 1 | "The yoga mat smells like someone else's journey. Steve sleeps anyway." |
| Eating retreat food for 2 days | +5 (→70) | Morning Day 3 | "Steve's body has accepted the turmeric. His urine is a color he's never seen before, but he feels... okay?" |
| Surviving first ego death | +10 (→80) | After first death | "Something broke. Something healed. Steve can't tell the difference." |
| Completing Frank's pipe quest | +5 (→85) | Quest reward | "Physical labor. Real physical labor. Steve remembers he has a body." |
| Winning the Sharing Circle | +5 (→90) | After circle | "Surviving that took more endurance than anything Steve has ever done. Including his marriage." |
| Breathwork session (involuntary) | +10 (→100) | Day 4+ event | "Steve hyperventilated for 40 minutes and saw his dead grandmother. She told him to stop being a baby. He feels incredible." |

So Steve reaches 100 HP, but he *earns* every point. Each increase is a joke AND a character moment.

**Max EP Increases:**

| Source | EP Gained | When |
|--------|-----------|------|
| First meditation (forced) | +5 (→35) | Day 1 event |
| Kitchen coffee from Frank | +5 (→40) | Side quest |
| Cacao ceremony attendance | +10 (→50) | Day 3+ event |
| Ego death | +5 per death | Permanent |

### The Meditator Wall

The Competitive Meditator guards the path to the Movement Studio, which is the gateway to Act 2 content. On Day 1, he's a wall:

**Day 1 Meditator (Overtuned Boss-lite):**
- HP: 60
- ATK: 14 (psychic)
- Weakness: Physical
- Special: **Stillness Shield** — While meditating (default state), takes 50% reduced damage. Attacking him with verbal/psychic while he's meditating *heals* him ("Thank you for the energy").
- Breaking Stillness: Must use physical attacks to break concentration. But Steve's Slap does 4 damage, halved to 2. That's 30 hits. Impossible before he kills you.
- His attack pattern: Humble Brag Sutra (10 psychic), Spiritual One-Upmanship (8 + Insight drain), Om Barrage (14 psychic, the big one)

**The intended experience:** Steve tries to fight the Meditator on Day 1 or 2. Gets destroyed. Learns he needs to come back stronger. This is the skill-check that teaches the player: *you need to grind*.

**How the Meditator becomes beatable:**
- Day 2: Steve has Shove (8 damage, halved to 4, stun chance breaks Stillness)
- Day 3: Throw Rock (14 damage, ranged, bypasses Stillness because it's undignified — the Meditator flinches, breaking concentration)
- Day 3+: With Set Boundary blocking his big hits and Panic Breathing for sustain, it's a real fight
- Secret solution: If Steve has attended a yoga class (Day 2 event), he can use "Attempt Meditation" in dialogue before the fight, which the Meditator respects — fight starts with Stillness already broken

---

## THE GRINDING GROUNDS: The Sacred Garden + The Path

Two areas serve as the grinding zones where random encounters happen.

### The Path (Early Grind — Days 1-3)

The path between the Pavilion and the Garden. Steve walks it multiple times a day. Every trip has a chance of a random encounter.

**Encounter Pool — The Path:**

| Enemy | HP | Appear | Drop | Notes |
|-------|-----|--------|------|-------|
| **Aggressive Hugger** | 15 | Day 1+ | Consent Card | Tutorial-tier. Falls over if you Set Boundary. |
| **Pamphlet Pusher** | 18 | Day 1+ | Workshop Flyer (evidence) | Throws paper. Tearable. Weak to literally anything. |
| **Essential Oil Warrior** | 30 | Day 1+ | Tiny Oil Bottle (consumable) | The first real fight. MLM pitch timer adds urgency. |
| **Feral Sound Healer** | 25 | Day 2+ | Off-Key Ukulele (weapon, +3 psychic) | Pure psychic damage. Zero physical threat. Endure wins. |
| **The Oversharer** | 22 | Day 2+ | Emotional Baggage (accessory) | Trauma dump DOT. Set Boundary is the counter. |

**Design intent:** The Path is where you learn the basics. Enemies are low-HP, have one gimmick each, and teach you one mechanic. The Hugger teaches Set Boundary. The Oil Warrior teaches urgency (timed enrollment). The Oversharer teaches DOT management. By Day 3, Path encounters feel easy — that's the grind paying off.

### The Sacred Garden (Mid Grind — Days 2-5)

The garden is where more serious NPCs hang out. Encounters here are harder and more varied.

**Encounter Pool — Sacred Garden:**

| Enemy | HP | Appear | Drop | Notes |
|-------|-----|--------|------|-------|
| **Yoga Snob** | 35 | Day 2+ | Overpriced Yoga Mat (+2 DEF) | Physical attacks + ego damage. "In Mysore we..." |
| **Boundary Violator** | 30 | Day 2+ | Consent Workshop Pamphlet | Stun through uninvited contact. Set Boundary ×3 = instant win. |
| **Shadow Work Enthusiast** | 40 | Day 3+ | Dog-Eared Jung Book (+3 Insight on read) | Reflects 30% psychic damage. Cold Read destroys them. |
| **Karma Yogi (Broken)** | 35 | Day 3+ | Tattered T-Shirt (+5 DEF) | *Can be talked down instead of fought.* Kindness wins. |
| **Kombucha Evangelist** | 30 | Day 3+ | Homemade Kombucha (heal, 10% poison) | Throws jars. Explode on miss. AOE risk. |
| **Instagram Yogi** | 40 | Day 4+ | Ring Light (accessory, +5 charisma) | Gains power if you watch. Ignore 3 turns = self-destruct. |

### Random Encounter System

Each time Steve enters a grinding area, there's a **60% chance** of an encounter. The encounter is drawn from the area's pool, weighted by day (later enemies appear more as days progress, early enemies appear less). Steve can also choose to **"Take a Walk"** from the Dorms or Garden, which guarantees an encounter — this is the explicit grind button.

After combat, there's a **20% chance** of a bonus NPC interaction (see Ambient NPCs below). These are non-combat encounters that give small rewards and build the world.

---

## THE CHARACTERS THAT MAKE YOU FEEL THINGS

### Relationship NPCs (Recurring, Evolving)

These NPCs appear in specific rooms and their dialogue changes every day. They're the emotional backbone.

#### Brandon — The Slow Conversion

Brandon is Steve's bunkmate. He's a nice guy. He's also losing himself.

| Day | Where | What Happens | Emotional Beat |
|-----|-------|-------------|----------------|
| 1 | Dorms (morning) | Introduces himself. Excited tourist. Mentions his watch (gift from his dad). | Likeable. Normal. |
| 1 | Main Hall (evening) | Attended first session. "The teacher said my energy was really open!" | Cute enthusiasm. |
| 2 | Dorms (morning) | Wearing retreat whites. "I'm trying to be more open." Still has the watch. | Hmm. |
| 2 | Garden (afternoon) | Doing yoga badly but earnestly. Asks Steve to join. | Endearing. |
| 3 | Kitchen (morning) | Volunteering. "I thought I'd help out. They said it's good karma." Not wearing the watch. | Wait. |
| 3 | Dorms (evening) | Has a new name: "Surya Dev." Gets defensive if Steve questions it. | Concern. |
| 4 | Main Hall | Actively recruiting others. Parrots Founder's phrases. Donated the watch. | Alarm. |
| 5 | Ceremony Space | Standing guard with Gatekeeper. Won't talk to Steve. | Heartbreak. |
| Boss | Phase 1 shield | Fights alongside Founder. Can be saved with "Where's your watch, Brandon?" | Payoff. |

**Design intent:** Brandon is the game's emotional core for Zone 1. You watch a normal person get absorbed. Each day the dialogue is a little more alarming. When he fights you in the boss battle, you should feel something. When you say "Where's your watch, Brandon?" and he snaps out of it, you should feel *relief*. And then guilt — because you couldn't stop it from happening.

#### Maya — The Trapped Skeptic

Maya is already past the point of conversion. She sees everything clearly. She just can't leave.

| Day | Where | What Happens | Emotional Beat |
|-----|-------|-------------|----------------|
| 1 | Kitchen | Brief exchange. She's guarded. "I'm fine. We're all fine." | Suspicious. |
| 2 | Kitchen | Opens up slightly. "Seven months is not a long time." (It is.) | Sad. |
| 2 | Path (night) | Catches Steve sneaking around. Doesn't report him. Doesn't explain why. | Trust. |
| 3 | Fire Pit | KEY SCENE. Full info dump about wife, Founder, recommendation letter. | Revelation. |
| 3 | Kitchen (after) | "Don't tell anyone I told you. They'll move me to the garden crew." | Fear. |
| 4 | Dorms hallway | Has Steve's wife's old journal. Gives it to him. "She left this. I kept it." | Connection. |
| 5+ | Kitchen (if quest active) | "My passport is in the filing cabinet. The one marked 'Sacred Documents.'" | Trust complete. |
| Post-boss | Pavilion | If rescued: "I don't know what I'm going to do." Steve: "Do you need a ride?" | Relief. |

**Design intent:** Maya is the person who makes you care about the Sanctuary's victims. She's not a joke. She's smart, capable, and trapped. Her side quest (retrieve her passport) should feel urgent. The player should *want* to get her out.

#### Frank — The Constant

Frank doesn't change. That's the point.

| Day | Where | What Happens |
|-----|-------|-------------|
| Any | Garden | Always available. Always dry. Always calls Founder "Paul." |
| 1 | Garden | Intro. "You're new. Guest or volunteer?" Gives backstory of "Paul." |
| 2 | Garden | Pipe quest available. Physical problem, physical solution. |
| 3+ | Garden | After quest: gives master key. "Twelve years I've been watching people find themselves. Mostly they just find each other's leftovers." |
| Any | Garden (night) | Night walks. "See that star? That's the only honest thing in this place." Genuine moment. |

**Design intent:** Frank is the anchor. When everything is weird, Frank is normal. When Steve doubts himself, Frank's practical kindness reminds him what "real" looks like. His quest reward (master key) is the best reward in the zone — not because it's powerful, but because it represents a real person helping another real person.

### Ambient NPCs (Non-combat, World-building)

These appear as random post-combat or room-specific encounters. Short interactions, no branching, but they make the world feel alive.

| NPC | Where | Interaction | Reward |
|-----|-------|-------------|--------|
| **The Crying Facilitator** | Dorms hallway (night) | Catches a facilitator sobbing. They compose themselves: "Sorry. I was just processing." Steve: "Processing what?" "Everything." | -1 Normality. +1 Insight. Steve sees behind the curtain. |
| **The Parking Lot Realist** | Path (rare) | A guest standing by their car, keys in hand. "I'm leaving. I think. I've been standing here for twenty minutes." They don't leave. | Kombucha (free). They hand Steve a drink they were saving for the drive. |
| **The Karma Yogi Whisperers** | Kitchen (night) | Two volunteers whispering about escape. They go silent when Steve appears. If Steve has helped Maya, they nod at him. | If helped Maya: Volunteer Schedule (evidence item). Trust earned. |
| **The Dad Who Brought His Kid** | Garden (Day 3+) | A man awkwardly watching his teenage daughter do yoga. "My ex-wife said this would be 'good for her.' I'm just here to make sure nobody puts crystals on her." | +2 Insight. Steve sees himself. He came here for someone too. |
| **Jade's Photo Shoot** | Various (Day 2+) | @JadeAligns setting up a "spontaneous" shot. "Can you hold this crystal? No — higher. Can you look like you're NOT holding a crystal? Perfect." | +1 Cacao if you help. She tags you on Instagram. Nobody sees it because she has 4,200 followers. |
| **The Guy Who's Been Here "Forever"** | Fire Pit (night) | Old man by the fire. Doesn't talk much. Everyone calls him "The Elder." Frank says he showed up two years ago and never left. He's 34. | -2 Normality. This place changes you. |
| **Mattis** (Multi-zone setup) | Dorms (Day 4+) | A massive, sad Swedish man sitting on his bunk. "My girlfriend left for the breathwork intensive. Six months ago. She texts sometimes." | +1 Insight. Foreshadows Zone 2. Steve realizes: this is what he could become. |

---

## THE DAY LOOP — HOW A DAY ACTUALLY FEELS

### Morning Phase

1. **Wake Up** — HP/EP fully restored. Normality -1. Any new skill unlocks or enhancements trigger here with notification overlays.
2. **Morning Announcement** — The Daily Board shows today's schedule. 2-3 events are available. One is always a grind option.
3. **Room Access** — Some rooms have time-gated content (Fire Pit = night only, Ceremony Space = Day 3+). New rooms unlock as days progress.

### Day Phase (3-4 actions)

Steve gets **3-4 actions per day phase**. Each action is one of:

- **Visit a Room** — Talk to an NPC, advance a quest, trigger an event
- **Take a Walk** — Go to Path or Garden for a guaranteed encounter (grinding)
- **Attend an Event** — Schedule-board events: yoga class, sharing circle, breathwork session, kitchen shift
- **Shop** — Visit the Gift Shop or the Cacao Dealer

Events are the key pacing tool. They provide Insight, Normality drops, Max HP/EP increases, and story beats. But they also cost an action — so the player has to choose between grinding (more XP, more skill unlocks) and progressing (more story, more stat boosts). Both feed into each other.

### Evening Phase (2 actions)

- **Fire Pit** (Night only) — Key story scenes happen here
- **Night Walk** — Random ambient NPC encounter
- **Dorms** — Talk to Brandon, overhear conversations
- **The Kitchen** — Steal coffee from Frank's stash (+EP next morning)

### Sleep

- Full HP/EP restore
- Normality -1
- Check skill unlocks + enhancements
- Advance to next day
- Re-roll random encounter pools
- Brandon dialogue advances

### Example: Day 1

**Morning:** Wake up. Assigned spiritual name "Akash Prem." Phone confiscated. Receptionist gives orientation. Tutorial popups explain HUD.

**Action 1:** Walk to Path → Oil Warrior encounter (tutorial fight). Win. Get Retreat Map. Unlock Garden, Kitchen rooms.

**Action 2:** Visit Garden → Meet Frank. Learn wife was here. Frank is dry and wonderful.

**Action 3:** Visit Kitchen → Meet Maya. She's guarded. "I'm fine." Brief exchange. Unlocks her as a recurring NPC.

**Evening 1:** Visit Dorms → Meet Brandon. He's enthusiastic, normal, wearing his dad's watch.

**Evening 2:** Main Hall → Forced "Welcome Circle" event. Light dialogue, -1 Normality, +1 Insight. Meet the Oversharer (non-combat here, just dialogue). Meet the Receptionist again who's almost human for a moment.

**Sleep:** HP/EP restore. Normality 95→94. Day 2.

### Example: Day 3

**Morning:** Wake up. Normality 89. **Panic Breathing unlocks** (Normality ≤ 90... actually wait, let's adjust the gate to ≤90 since we start at 95). Energy Slap notification if physical attacks ≥ threshold. Daily Board shows: "Advanced Meditation (Movement Studio)" and "Kitchen Work Exchange" and "Free Time."

**Action 1:** Take a Walk (Garden) → Shadow Work Enthusiast fight. Good XP. Drop: Jung Book.

**Action 2:** Attend Kitchen Work Exchange → +5 Max HP event. Chop vegetables with Maya. She opens up slightly. "Your wife? She was kind. Kinder than most people who come here."

**Action 3:** Attempt Competitive Meditator (Movement Studio) → NOW you have Throw Rock + Set Boundary + Panic Breathing. It's tough but winnable. Victory: +3 Insight. Studio unlocked for future yoga class events.

**Evening 1:** Fire Pit → Maya's big reveal scene. Full info about wife, Founder, recommendation letter.

**Sleep:** Normality 89→85. Day 4. Multiple enhancement checks trigger. The Nod might unlock.

---

## EVENTS — THE RETREAT PROGRAM

Events are the retreat schedule come to life. Each one is a set-piece that combines story, stat changes, and comedy.

### Yoga Class (Movement Studio, Day 2+)

- Steve attempts yoga. He cannot touch his toes. The instructor keeps adjusting him. Other students are suspiciously flexible.
- **Reward:** +5 Max HP (first time), +1 Insight, -1 Normality
- **Comedy:** The instructor says "Breathe into your hips." Steve: "I don't think that's how breathing works." Instructor: "It is if you believe it is." Steve: "It isn't."
- **Mechanical bonus:** Unlocks "Attempt Meditation" dialogue option vs. Competitive Meditator

### Sharing Circle (Main Hall, Day 2, required for Act 2)

- The big endurance challenge. Steve sits in a circle while people share increasingly intense personal revelations.
- 3 rounds. Each round: someone shares, Steve must choose a response (Validate / Deflect / Boundary).
- **Validate** = -1 Normality, +2 Insight, NPC likes Steve
- **Deflect** = neutral, mildly funny
- **Boundary** = +1 Normality, -1 Insight, NPC is hurt (but respects it)
- Round 3: The Oversharer goes nuclear. Regardless of choice, Steve takes psychic damage. If he survives: +5 Max HP, +2 Insight, unlocks Fire Pit access.
- **Design intent:** This is a combat encounter disguised as a social event. Set Boundary and Endure are literally the skills you need.

### Cacao Ceremony (Main Hall, Day 3+)

- Group drinks ceremonial cacao. Facilitator guides a "journey." People start crying, laughing, seeing colors.
- Steve drinks the cacao. It's... actually good? He feels warm. His hands tingle. The facilitator says "Let whatever wants to come, come."
- **Choice:** Resist (hold Normality) or Surrender (lose Normality, gain power)
  - **Resist:** Normality holds. +2 Insight. Steve thinks: "That was just chocolate. Really strong chocolate."
  - **Surrender:** -5 Normality. +10 Max EP. +1 Spiritual skill check. Steve thinks: "I am not going to tell anyone about this."
- **Design intent:** First real temptation. The game offers power at the cost of Normality. Surrender is mechanically better but narratively terrifying.

### Breathwork Session (Movement Studio, Day 4+)

- The big one. 40 minutes of guided hyperventilation. Steve does it because the room is locked and he can't leave.
- Involuntary. Steve can't choose to skip this once triggered.
- **Reward:** +10 Max HP (reaching 100 if everything else was done). Permanent Spiritual skill check.
- **Comedy:** Steve sees a vision of his dead grandmother. She says: "Steven, stop being a baby. Also, you have my nose." Steve: "Grandma?" Vision: "Also tell your mother I want my casserole dish back." Steve: "This isn't real." Vision: "THE DISH, STEVEN."
- -3 Normality (ceremony penalty)
- **Design intent:** The point of no return for Steve's body. He's physically transformed by the retreat. He hates it. He's also never felt better. This is the game's thesis in miniature.

### Kitchen Work Exchange (Kitchen, any day)

- Steve helps cook. Chops vegetables. Washes dishes. Maya talks to him.
- Low-key scene. More about relationship-building than mechanics.
- **Reward:** +5 Max HP (first time), free meal (full HP restore), Maya dialogue advance
- **Comedy:** "What is this?" "Jackfruit." "It looks like pulled pork." "Please don't say that here." "Why not?" "Three people will cry."

---

## THE SET BOUNDARY + PANIC BREATHING LOOP

These two skills define early-game survival and teach the player the game's fundamental rhythm.

### Set Boundary (Verbal, Tier 0, Free Action)

- Blocks the next incoming attack (100% damage reduction for 1 hit)
- Costs 0 EP
- Free action (doesn't end turn)
- Unlocked from the start

**Why it's critical:** Steve's HP is 60. Enemies hit for 8-14. Without Set Boundary, Steve dies in 4-5 hits. With it, he can block one big attack per turn while still attacking. It's the shield that makes 60 HP survivable.

**The comedy:** Every time Steve uses Set Boundary, the log text is him saying something painfully reasonable:
- "I need you to not do that."
- "I'm going to ask you to step back."
- "That's not appropriate for a professional setting." (Steve forgets he's not at work.)
- "I have explicitly asked you to stop."
- "My therapist said I should practice this."

### Panic Breathing (Spiritual, Normality ≤ 90)

- Heals 10 HP
- Costs 3 EP
- Steve hyperventilates. It accidentally works.
- First spiritual skill to unlock (Day 2-3, after 2-5 Normality drops)

**Why it's critical:** Steve's only heal in early game. Energy Bar heals 20 but is consumable (limited). Panic Breathing is infinite but costs EP. The loop becomes: Set Boundary to survive → attack → Panic Breathing to sustain → repeat.

**The comedy:** Steve is not doing breathwork. He is having a panic attack. It just happens that controlled hyperventilation has physiological effects that the game interprets as healing.
- "Steve breathes rapidly and shallowly. A facilitator nearby nods approvingly."
- "Steve can't feel his fingers. His HP goes up. He doesn't understand why."
- "Is this what they mean by 'pranayama'? Steve hopes not."

### The Loop in Action (vs. Oil Warrior, Day 1)

```
Turn 1: Steve uses Slap (4 dmg). Oil Warrior HP: 26/30.
Turn 1: Set Boundary (free action). Block active.
Turn 2: Oil Warrior uses MLM Pitch. Blocked! "I appreciate your enthusiasm but I'm not interested."
Turn 2: Steve uses Slap (4 dmg). Oil Warrior HP: 22/30.
Turn 3: Oil Warrior uses Essential Oil Splash (8 dmg). Steve HP: 52/60.
Turn 3: Steve uses Slap (4 dmg). Oil Warrior HP: 18/30. Set Boundary (free action).
Turn 4: Oil Warrior uses MLM Pitch. Blocked!
...
```

It's slow. It's grinding. But it works. And every few turns Steve says something dry ("Please stop trying to sign me up for things") that makes the grind entertaining.

By Day 3 with Shove (8 dmg) + Throw Rock (14 dmg) + Panic Breathing for sustain, the same Oil Warrior fight takes 3 turns. That's the power curve.

---

## LOOT AND ECONOMY

### Drop System

Every enemy has a **guaranteed drop** (first kill) and a **chance drop** (subsequent kills, 30%).

First kills also give **Insight XP** — the primary reason to fight new enemies rather than farm old ones.

### The Cacao Economy

Cacao Coins are the currency. Sources:
- Enemy drops (1-3 per fight)
- Quest rewards (10-25)
- Selling items to Gift Shop (50% value)
- Helping Jade with photos (5 per session)
- Kitchen Work Exchange (3 per shift)

Spending:
- Gift Shop items (consumables, equipment, cosmetics)
- Cacao Dealer (special consumables, rotating stock)
- Bribe the Receptionist for information (50 cacao — she pretends to be above it, then pockets it)

### Key Equipment Progression

| Day | Likely Loadout | Source |
|-----|---------------|--------|
| 1 | Polo Shirt (+2 DEF), Energy Bars ×3 | Starting |
| 2 | + Consent Card (block 1 hit), Off-Key Ukulele (+3 psychic) | Drops |
| 3 | + Overpriced Yoga Mat (+2 DEF), Jung Book (+3 Insight) | Drops |
| 4 | + Tattered T-Shirt (+5 DEF) or Sanctuary Hoodie (+8 DEF) | Quest / Shop |
| 5 | + Singing Bowl (+8 ATK, stun) or Really Big Crystal (+15 ATK) | Quest |

---

## PACING: THE 6-DAY ARC

| Day | Story | Grind | Emotional Arc |
|-----|-------|-------|--------------|
| **1** | Arrive, lose phone, meet Frank/Maya/Brandon. Oil Warrior tutorial. | Path enemies only. Slap + Set Boundary. Steve is pathetic. | Fish out of water. Comedy. |
| **2** | Brandon in retreat whites. Yoga class. Sharing Circle. Garden unlocks. | Path + Garden enemies. Shove unlocks. Panic Breathing appears. | Starting to engage. Curiosity. |
| **3** | Brandon donates watch. Maya fire pit reveal. Meditator beatable. | Full grind available. Throw Rock + Insult. Steve can fight. | The turn. Stakes become real. |
| **4** | Brandon unreachable. Breathwork forced. Ceremony Space accessible. | Harder Garden enemies. Punch + Mock. Enhancements stacking. | Dread. Steve is changing too. |
| **5** | Gatekeeper confrontation. Back Office infiltration. Evidence found. | Optional grind. Cold Read coming online. Steve is dangerous. | Determination. |
| **6** | Boss fight. Brandon in Phase 1. Three endings. Departure. | No grind needed. Final boss. | Catharsis. |
| **7+** | Optional. Completionist. Side quests. Ambient NPCs. Over-grinding. | Everything. Steve is overpowered. The zone is his. | Comedy of mastery. |

---

## BOSS GATE

The Founder fight requires three flags:
1. `maya_firepit` — Talked to Maya at the fire pit (Day 3+)
2. `back_office_found` — Entered the Back Office (Day 5+)
3. `day >= 3` — Minimum 3 days passed (can't speedrun the emotional arc)

Optional but impactful:
- `brandon_watch_seen` — Saw Brandon wearing watch on Day 1 (enables "Where's your watch?" in Phase 1)
- `maya_passport` — Retrieved Maya's passport (changes post-boss Maya dialogue)
- `frank_quest_done` — Completed Frank's quest (gives alternate boss-room entry + Frank shows up in ending)

---

## IMPLEMENTATION PRIORITY (Patch 4 Scope)

### Must-Have (Core Loop)

1. **Day system with action economy** — 3-4 day actions, 2 evening actions, sleep advances day
2. **Random encounter system** — Weighted pools per area, 60% chance on enter, "Take a Walk" guarantee
3. **Nerfed starting stats** — HP 60, EP 30, Normality 95
4. **Max HP/EP increase events** — 6 sources for HP, 4 for EP, each with flavor text
5. **Meditator as skill-check wall** — 60 HP, Stillness Shield, beatable Day 3
6. **Brandon daily dialogue** — 6 days of progression, watch tracking flag
7. **Maya daily dialogue** — 5 stages, fire pit key scene, passport quest
8. **Set Boundary + Panic Breathing early loop** — These two skills carry Days 1-3

### Should-Have (Depth)

9. **Events system** — Yoga Class, Sharing Circle, Cacao Ceremony, Breathwork, Kitchen Exchange
10. **Frank quest** — Pipe repair, master key reward, HP increase
11. **Ambient NPCs** — Post-combat random encounters, 7+ ambient characters
12. **Cacao economy** — Gift shop, drops, quest rewards, spending
13. **Equipment drops** — 10+ items from enemies, all with flavor text
14. **Daily Board** — Morning schedule display with available events

### Nice-to-Have (Polish)

15. **Jade's side quest** — WiFi password, photo shoot comedy
16. **Crystal Audit quest** — Healing Hut investigation
17. **Mattis appearance** — Zone 2 foreshadowing
18. **Night walk system** — Evening ambient encounters with unique pool
19. **Dad-with-kid NPC** — Steve's mirror moment
20. **The Guy Who's Been Here "Forever"** — Fire pit ambient

---

## WHY THIS WORKS

The grind isn't just combat. It's *living at the retreat*. Every day Steve:
- Fights people who annoy him (combat grind → skill unlocks)
- Talks to people who matter (relationship grind → emotional investment)
- Attends events he hates (stat grind → HP/EP growth)
- Loses a little more Normality (spiritual grind → enhancement transformations)

Four parallel progression systems, all feeding into each other, all producing jokes. The player grinds because they want to beat the Meditator. They stay because they want to save Brandon. They keep going because they want to see what Steve becomes.

And through it all, Steve keeps saying things like "I just want to find my wife" while his hands glow and his breathing heals wounds and his slap leaves afterimages. The grind IS the comedy. The comedy IS the character development. The character development IS the game.
