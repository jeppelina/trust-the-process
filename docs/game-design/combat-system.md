# Combat System Design

## Overview

Turn-based combat. The humor IS the mechanic — every attack name, status effect, and interaction should deliver a joke or reinforce the satire. Combat should feel like a conversation that escalated, not a random encounter.

## Core Philosophy

1. **Every fight should be avoidable or have a non-combat resolution.** Steve is an accountant, not a warrior. The funniest moments come from him reluctantly engaging.
2. **Enemies don't think they're enemies.** They think they're helping, sharing, healing, or teaching. Combat starts because someone won't leave Steve alone.
3. **Steve fights with his body and his mouth.** Physical violence and verbal cruelty are the two player-choice branches. Spiritual abilities arrive involuntarily — Steve can't stop the retreat from seeping in.
4. **The player should sometimes feel bad about winning.** Some enemies are more sad than threatening. The game should acknowledge that.

---

## Stats

### Primary Stats

| Stat | What It Does | Steve's Flavor |
|------|-------------|----------------|
| **HP (Homeostasis Points)** | Health. Reaches 0 = ego death. Steve doesn't die — he has a breakdown and wakes up in the dorms. | "Steve's grip on normality" |
| **EP (Energy Points)** | Used to perform special abilities. Restores fully on sleep. | "Emotional bandwidth remaining" |
| **Normality** | Drops over time from sleeping at the retreat (-1/night), attending ceremonies (-3), and ego deaths (-5). As it drops, spiritual abilities appear and existing skills transform. Never goes back up. | The central mechanic: Steve is becoming what he came to save his wife from, and neither he nor the player can stop it. |
| **Insight** | Determines which NPCs take you seriously, which verbal skills unlock, and which dialogue options are available. Gained from winning battles and completing quests. | Functions as the game's "level" equivalent, but also gates verbal skill progression. |

### The Normality Mechanic (Central Design)

Normality only goes down. It drops from:
- Sleeping at the retreat: -1 per night
- Attending ceremonies/sharing circles: -3
- Ego death: -5
- Certain NPC interactions: -1 here and there

As Normality drops, two things happen:
1. **Standalone spiritual abilities unlock** (healing, defense, utility) — appear in the SPIRIT menu
2. **Existing Physical and Verbal skills transform** into spiritual-enhanced versions — Steve's Slap becomes Energy Slap, his Complain becomes Mindful Complaint

The player never chooses this. It happens. That's the joke and the emotional engine.

---

## Battle Menu

```
┌──────────────────────────────┐
│  FIGHT   MOUTH   SPIRIT     │
│  ITEM    ENDURE  FLEE       │
└──────────────────────────────┘
```

- **FIGHT** → Opens submenu of all unlocked physical skills. Enhanced versions replace originals (shown with ✦ marker).
- **MOUTH** → Opens submenu of all unlocked verbal skills. Enhanced versions replace originals.
- **SPIRIT** → Standalone spiritual abilities only (Panic Breathing, Sage Toss, Sound Bath, etc.). Starts greyed out: "Steve doesn't do... whatever this would be." Fills involuntarily as Normality drops.
- **ITEM** → Use a consumable from inventory.
- **ENDURE** → Defend. 50% damage reduction for the turn. Some enemies lose interest if Steve endures 3+ turns.
- **FLEE** → 70% success rate. Always available. No shame. Can't flee boss fights.

### Skill Submenus

When the player clicks FIGHT, MOUTH, or SPIRIT, a submenu opens listing all unlocked skills for that branch. Each skill shows its name, EP cost, and damage. Skills the player can't afford (insufficient EP) are greyed out. A "← Back" button returns to the main menu.

---

## Damage Types

Three types. Clean and simple.

| Type | Source | Strong Against | Weak Against |
|------|--------|---------------|-------------|
| **Physical** | Punching, throwing, tackling, headbutting | Anyone with no combat training (most hippies) | Trained practitioners, bosses with shields |
| **Psychic** | Insults, guilt, manipulation, complaints, social damage | Anyone with insecurity or a persona to protect | True believers (immune to doubt), psychopaths |
| **Spiritual** | Crystals, breathwork, sound, energy, enhanced skill bonuses | Anyone spiritually "open" (everyone here except early-Steve) | Grounded people, high-Normality characters |

Enhanced skills deal their original type PLUS spiritual. This is why spiritual progression makes everything stronger — it adds a second damage type to attacks.

### Weakness System

Each enemy has one weakness type. Attacks matching the weakness deal 50% bonus damage. The player discovers weaknesses by experimenting early game; later, Empathic Read (spiritual ability, Normality ≤ 45) reveals them.

---

## Combat Effects

| Effect | Applied By | Mechanic |
|--------|-----------|----------|
| **Stun** | Shove (30% chance), Change Subject, Force Push | Enemy skips next turn |
| **Pin** | Tackle | Enemy skips next turn (guaranteed) |
| **DOT (Damage Over Time)** | Nag, Mindful Complaint, Mantra Nag | X damage per turn for N turns |
| **Block** | Set Boundary, Sacred Boundary | Blocks enemy attacks for 2 turns. Doesn't end Steve's turn. |
| **Smoke Screen** | Sage Toss | -20% enemy accuracy for 2 turns |
| **Buff Next** | The Nod | +30% damage on next attack. Doesn't end Steve's turn. |
| **Self-Damage** | Headbutt | Steve takes 5 damage (removed when enhanced to Third Eye Headbutt) |
| **Endure** | Endure action | 50% damage reduction for the turn |
| **Smudged** | Enemy sage/incense attacks | Accuracy -20% for 3 turns |

---

## Turn Structure

Each turn, Steve performs ONE action from the battle menu. After Steve acts, the enemy takes their turn (unless stunned/pinned). Turn order is fixed: player → enemy → player → enemy.

### Exceptions (Free Actions)
- **Set Boundary** doesn't end Steve's turn — he can block and then attack.
- **The Nod** doesn't end Steve's turn — he can buff and then attack.
- **Analyze** no longer exists as an action. Use Empathic Read (spiritual, Normality ≤ 45) or Cold Read (verbal, tier 4) instead. Early game, you fight blind.

---

## Combat Flow Example (Updated)

### "The Essential Oil Warrior — Day 1"

**[ENCOUNTER START]**
*Steve is walking past the gift shop when someone steps into his path holding a tiny bottle.*

**Essential Oil Warrior:** Have you tried peppermint oil for your energy? You look like your chi is STAGNANT.

**[TURN 1 — Player's Turn]**

```
FIGHT: Slap (5 dmg)
MOUTH: Complain (4 dmg) | Set Boundary (block)
SPIRIT: [greyed out — "Steve doesn't do... whatever this would be."]
ITEM | ENDURE | FLEE
```

*Player chooses: MOUTH > Complain*
"The water pressure in the shower is unacceptable." 4 psychic damage!
EFFECTIVE! Oil Warrior is weak to psychic! 6 damage!

**[TURN 1 — Enemy's Turn]**
**Essential Oil Warrior uses ANOINT.**
"RECEIVE THIS BLESSING!" She hurls peppermint oil at Steve. 10 damage!

**[TURN 2 — Player's Turn]**
*Player chooses: FIGHT > Slap*
Steve slaps with an open palm. It's not a punch. It's a punctuation mark. 5 damage!
*(gameState.physicalAttacks is now 1)*

**[TURNS 3-6]**
*Player alternates Slap and Complain. Each attack increments the counter.*
*Oil Warrior goes down.*

**VICTORY!** +2 Insight, +20 Cacao.
*Skills tab now shows: Shove — 3/3 physical attacks ✓*
*Steve goes to sleep. Day 2. Shove unlocks. Normality: 89.*

### "The Essential Oil Warrior — Day 3"

*Same enemy, different Steve. Normality is now 75.*

**[Before battle]**
Notification: "SKILL TRANSFORMED: Slap → Energy Slap"
*Steve notices his hands tingling before he strikes. The impact leaves a faint shimmer.*

**[TURN 1 — Player's Turn]**

```
FIGHT: Energy Slap ✦ (10 dmg) | Shove (8 dmg) | Throw Rock [2 EP] (14 dmg)
MOUTH: Mindful Complaint ✦ (DOT) | Set Boundary (block) | Nag [2 EP] (DOT)
SPIRIT: Panic Breathing [2 EP] (heal 15) | Sage Toss [2 EP] (8 dmg + smoke)
ITEM | ENDURE | FLEE
```

*Steve has gone from 2 skills to 8. His slap glows. His complaint is an I-statement. The Oil Warrior doesn't stand a chance.*

---

## Encounter Design Principles

### Every Fight Has Multiple Resolution Paths

| Path | Method | Reward |
|------|--------|--------|
| **Combat win** | Reduce HP to 0 through attacks | Standard drops, Insight, Cacao |
| **Talk down** | Use MOUTH skills to de-escalate | Bonus dialogue/info, sometimes more Insight |
| **Endure** | Endure 3+ turns until enemy loses interest | Unique resolution, pacifist achievement |
| **Flee** | 70% success rate | No reward, no penalty. Steve is not a hero. |

### Enemy Aggression Levels

- **Passive:** Won't fight unless provoked. Brandon, random guests.
- **Pushy:** Will keep bothering Steve but won't attack first. Essential Oil Warrior, Oversharer.
- **Territorial:** Attacks if Steve enters their space or challenges authority. Competitive Meditator, Gatekeeper.
- **Aggressive:** Initiates combat on sight. Rare. Maybe only in later zones.
- **Tragic:** Fighting them feels wrong. Some broken followers. The game should make the player uncomfortable.

---

## Status Effects (Condensed for Prototype)

### Applied to Enemies
| Effect | Source | Duration |
|--------|--------|----------|
| Stunned | Shove/Change Subject/Force Push | 1 turn |
| Pinned | Tackle | 1 turn |
| DOT | Nag/Mindful Complaint | 3-4 turns |
| Exposed | Accurate Insult (enhancement) | Permanent |
| Smoke-screened | Sage Toss | -20% accuracy, 2 turns |

### Applied to Steve
| Effect | Source | Cured By |
|--------|--------|----------|
| Smudged | Enemy sage attacks | Wait it out |
| Blocked | Set Boundary | Decrements per turn |
| Enduring | Endure action | One turn |
| Buffed | The Nod | Next attack |

---

## Boss Design Pattern

Every zone boss follows a 3-phase structure:

### Phase 1: The Mask
- An ally or shield defends the boss (Brandon in Zone 1)
- Must be broken through with combat or talk
- Separate HP pool

### Phase 2: The Real Person
- Boss fights directly. Standard combat with boss-specific mechanics.
- Boss uses weaponized versions of their spiritual practice.
- Hitting weaknesses is effective.

### Phase 3: The Desperation
- Boss becomes erratic — mix of genuine vulnerability and last-ditch manipulation
- High damage but also self-defeating attacks
- Player chooses resolution: destroy, leave, or something creative

### The Emotional Rule
Every boss should have a moment where the player thinks: "Oh. They're just a person." Not to excuse their behavior — but to complicate the victory.
