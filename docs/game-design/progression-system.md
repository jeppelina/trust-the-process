# Character Progression System

## Overview

Steve's progression has three interlocking systems:

1. **Physical and Verbal skill trees** — the player's choice ("warrior or wizard"), unlocked through use
2. **Spiritual progression** — involuntary, gated by Normality drop, enhances existing skills
3. **Insight** — the game's XP/level equivalent, gates verbal unlocks and NPC interactions

The key insight: Physical and Verbal are what Steve CHOOSES to get better at. Spiritual is what HAPPENS to him. Everyone learns hippie stuff. There is no build that avoids it.

---

## The Two Player-Choice Branches

### Physical (Fists)

Unlocked by USING physical attacks. A permanent counter (`physicalAttacks`) increments each time Steve uses any physical skill. It never resets.

| Tier | Skill | Unlock At | EP | Damage |
|------|-------|-----------|----|--------|
| 0 | Slap | Start | 0 | 5 |
| 1 | Shove | 3 attacks | 0 | 8 |
| 2 | Throw Rock | 8 attacks | 2 | 14 |
| 3 | Punch | 15 attacks | 3 | 18 |
| 4 | Headbutt | 25 attacks + Insight 3 | 4 | 22 (+ 5 self-damage) |
| 5 | Tackle | 40 attacks + Day 4 | 6 | 28 + pin |
| 6 | Rage | 60 attacks + Insight 6 + Day 6 | 8 | 35 + 2 turns +50% phys |

The arc: Steve has never been in a fight. He starts pathetic (open-palm slap). Each level is him snapping a little harder, from embarrassing flailing to genuine frightening competence.

### Verbal (Mouth)

Unlocked by USING verbal attacks plus meeting Insight thresholds. A permanent `verbalAttacks` counter increments on each verbal skill use.

| Tier | Skill | Unlock At | EP | Damage | Effect |
|------|-------|-----------|----|--------|--------|
| 0 | Complain | Start | 0 | 4 | — |
| 0 | Set Boundary | Start | 0 | 0 | Block 2 turns (free action) |
| 1 | Nag | 5 verbal + Insight 1 | 2 | 8/turn | DOT 3 turns |
| 2 | Insult | 12 verbal + Insight 2 | 3 | 15 | — |
| 2 | Change Subject | 12 verbal + Insight 2 | 2 | 0 | Stun 1 turn |
| 3 | Mock | 20 verbal + Insight 3 + Day 3 | 4 | 12 | -25% enemy atk |
| 3 | Guilt Trip | 20 verbal + Insight 3 + Day 3 | 5 | 18 | — |
| 4 | Gaslight | 35 verbal + Insight 5 | 6 | 10 | 30% self-attack |
| 4 | Cold Read | 35 verbal + Insight 5 | 5 | 0 | Reveal all stats |
| 5 | Manipulate | 50 verbal + Insight 7 + Day 5 | 8 | 0 | Control enemy 2 turns |
| 5 | Destroy | 50 verbal + Insight 7 + Day 5 | 10 | 30 | Psychic nuke |
| 6 | Silence | 70 verbal + Insight 9 + Day 7 | 12 | 0 | All enemies lose 2 turns |

The arc: Steve starts with polite deflection and escalates to psychological warfare. The progression mirrors how people actually escalate: boundaries → complaints → insults → cruelty → manipulation.

---

## Spiritual Progression (Involuntary)

This is NOT a player choice. It's what happens to Steve from being immersed in the retreat.

### How Normality Drops

| Source | Drop |
|--------|------|
| Sleeping at the retreat | -1 per night |
| Attending ceremony/sharing circle | -3 |
| Ego death | -5 |
| Certain NPC interactions | -1 each |

Normality only goes DOWN. It never recovers. Steve can't un-learn what the retreat teaches him.

### Standalone Spiritual Abilities

These appear in the SPIRIT menu when Normality crosses thresholds.

| Normality ≤ | Skill | EP | Effect |
|-------------|-------|----|--------|
| 85 | Panic Breathing | 2 | Heal 15 HP |
| 80 | Sage Toss | 2 | 8 spiritual dmg + smoke screen |
| 70 | The Nod | 2 | +30% next attack (free action) |
| 60 | Sound Bath | 6 | Heal 20 HP + cleanse 1 debuff |
| 60 | Somatic Release | 5 | Cure all negative status effects |
| 45 | Empathic Read | 5 | Reveal enemy weaknesses |
| 30 | Hold Space | 8 | 50% damage reduction, 3 turns |
| 30 | Mirror | 10 | Reflect all attacks, 1 turn |
| 20 | Genuine Vulnerability | 15 | Massive AOE + heal. Once per zone. |

### Spiritual Enhancements (Skill Transformations)

As Normality drops, Steve's existing Physical and Verbal skills TRANSFORM. The old skill is replaced by an enhanced version that adds spiritual damage and bonus effects. The player doesn't choose this — they open their skill menu one morning and something has changed.

Each enhancement triggers a one-time notification with Steve's horrified reaction.

| Original | Normality ≤ | Becomes | Key Change |
|----------|-------------|---------|------------|
| Slap | 75 | Energy Slap | +5 spiritual dmg, palm glows |
| Complain | 75 | Mindful Complaint | Becomes DOT (I-statements are more devastating) |
| Shove | 65 | Force Push | Guaranteed stun, extra spiritual dmg |
| Throw Rock | 55 | Crystal Launch | Rocks hum in Steve's hand, pierces resistance |
| Punch | 45 | Chakra Strike | Reveals weakness, spiritual bonus |
| Insult | 55 | Accurate Insult | Guaranteed "Exposed" debuff, Steve can see auras now |
| Set Boundary | 55 | Sacred Boundary | Blocks ALL attacks for 1 turn, visible shimmer |
| Headbutt | 35 | Third Eye Headbutt | No more self-damage, spiritual bonus |
| Guilt Trip | 45 | Karmic Guilt | Adds "Karmic Debt" DOT |
| Gaslight | 35 | Spiritual Gaslighting | 50% self-attack, uses their language against them |
| Tackle | 25 | Grounding Tackle | 2-turn pin, heals Steve on contact |
| Rage | 15 | Transcendent Rage | AOE, +50% ALL types, simultaneously furious and at peace |

---

## Insight Levels

Insight is the game's XP equivalent. It's gained from defeating enemies and completing quests.

| Level | Title | What Unlocks |
|-------|-------|-------------|
| 0 | The Uninitiated | Starting state. NPCs treat Steve like a lost tourist. |
| 1 | Mildly Curious | Nag (verbal tier 1). People stop asking "is this your first time?" |
| 2 | Cautiously Open | Insult + Change Subject (verbal tier 2). Can use spiritual jargon (badly). |
| 3 | Reluctantly Aware | Mock + Guilt Trip (verbal tier 3). Access to intermediate areas. Steve accidentally says "holding space." |
| 4 | Uncomfortably Fluent | Full dialogue access. Enemies sometimes mistake Steve for a facilitator. |
| 5 | Accidentally Awakened | Gaslight + Cold Read (verbal tier 4). Hidden dialogue, secret areas, best jokes. |
| 7+ | Beyond Help | Manipulate + Destroy (verbal tier 5). Steve can navigate any spiritual social situation. |
| 9+ | The Abyss | Silence (verbal tier 6). Steve has become genuinely frightening and doesn't know it. |

### How Insight Is Gained

| Source | Insight Gain |
|--------|-------------|
| Defeating Oil Warrior | +2 |
| Defeating Meditator | +3 |
| Defeating Gatekeeper | +4 |
| Defeating Founder (boss) | +8 |
| Completing quests | +2 to +5 |
| Attending ceremonies/events | +2 |
| Finding wife's journal entries | +3 |

---

## The "One More Day" Loop

### What the Player Sees

The Skills tab in the ☰ menu shows:
- Physical tree with progress bars ("Punch — 11/15 physical attacks")
- Verbal tree with progress bars ("Insult — 8/12 verbal attacks, Insight 1/2")
- Spiritual section showing unlocked abilities and locked "???" with Normality gates
- Normality ticker ("Normality: 72. Next transformation at ≤ 70: The Nod + Crystal Launch")
- Attack counter totals

### Pacing

```
DAY 1: Slap, Complain, Set Boundary. Scrappy fights. ~5 physical, ~3 verbal.
       Skills tab: "Shove: 3/3 ✓ — unlocks tomorrow"
       Normality: 89. Panic Breathing appears.

DAY 2: Shove + maybe Nag. Slightly easier. Normality: ~83.
       "Throw Rock: 5/8" — almost there.

DAY 3: Throw Rock + Insult. Steve feels stronger.
       Normality: ~75. Energy Slap and Mindful Complaint appear.
       "Why is my hand glowing?"

DAY 4-5: Punch unlocks. More transformations.
         Boss gate opens. Fight viable with evidence.

DAY 6+:  Higher tiers for completionists. Multiple transformations stacking.
         Steve is a different person. The player notices.
```

### What Resets and What Doesn't

**Permanent:** Attack counters, unlocked skills, spiritual enhancements, Insight, Normality (only drops), quest progress, ego death count, inventory.

**Resets on Sleep:** HP/EP (fully restored), daily perk (future feature), minor enemy defeat flags (respawn), temporary buffs/debuffs.

**Resets on Ego Death:** Same as sleep, PLUS Normality -5, 50% consumables lost, day advances.

---

## Daily Perk System (Future — Patch 4)

Each morning, Steve picks 1 of 3 random temporary bonuses lasting until next sleep:

- "Restless Night: +3 damage to all physical attacks today"
- "Overheard a Mantra: Spiritual abilities cost 1 less EP today"
- "Irritable: First verbal attack each fight does double damage"
- "Accidentally Meditated: Start each fight with +10 EP"
- "Bad Dreams: -10 max HP today but +30% psychic damage"

Creates daily variety — same zone, different Steve.

---

## The Emotional Arc

The skill tree tells a story the player doesn't fully control:

**The Brawler** (Physical focus): Effective but losing something. By endgame, his punches glow — he's a warrior monk and he's horrified.

**The Manipulator** (Verbal focus): Becoming the thing he came to rescue his wife from. His gaslighting uses their spiritual language. He's a dark guru.

**Everyone:** Regardless of build, Steve's abilities transform. There is no version of Steve that leaves the retreat unchanged. The wife, when he finally finds her, should react to what he's become.
