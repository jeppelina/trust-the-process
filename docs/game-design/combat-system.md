# Combat System Design

## Overview

Turn-based combat. The humor IS the mechanic — every attack name, status effect, and interaction should deliver a joke or reinforce the satire. Combat should feel like a conversation that escalated, not a random encounter.

## Core Philosophy

1. **Every fight should be avoidable or have a non-combat resolution.** Steve is an accountant, not a warrior. The funniest moments come from him reluctantly engaging.
2. **Enemies don't think they're enemies.** They think they're helping, sharing, healing, or teaching. Combat starts because someone won't leave Steve alone.
3. **Steve's "weapons" are mundane skills weaponized.** Accounting, scheduling, corporate jargon — things that are boring in the real world but devastatingly effective here.
4. **The player should sometimes feel bad about winning.** Some enemies are more sad than threatening. The game should acknowledge that.

---

## Stats

### Primary Stats

| Stat | What It Does | Steve's Flavor |
|------|-------------|----------------|
| **HP (Homeostasis Points)** | Health. Reaches 0, Steve has a breakdown. Not death — he just sits on the floor and refuses to continue. | "Steve's grip on normality" |
| **EP (Energy Points)** | Used to perform special abilities. Recovers between fights or with consumables. | "Emotional bandwidth remaining" |
| **Normality** | Steve's core defense stat. High Normality makes him resistant to spiritual attacks. As it drops, spiritual attacks hurt more but spiritual skills become available. | This is the central tension — the more Steve resists the world, the safer he is but the less he can do. The more he opens up, the more powerful but more vulnerable. |
| **Insight** | Determines which NPCs take you seriously, which areas you can access, and which dialogue options are available. Functions as the game's "level" equivalent. | Gained through surviving encounters, completing quests, and reluctantly participating in spiritual activities. |

### Secondary Stats

| Stat | What It Does |
|------|-------------|
| **Vibe** | Social stat. Determines NPC reactions. Low vibe = people avoid you or try to "fix" you. High vibe = people trust you. Can be buffed with items/equipment. |
| **Credibility** | Separate from Vibe. How much people believe you. Corporate items boost credibility with normal people but lower it with spiritual people, and vice versa. |
| **Charisma** | Affects dialogue success rates and shop prices. Steve starts with almost none. |
| **Agility** | Turn order and dodge chance. Steve is slow. Yoga pants help. |
| **Awareness** | Detect hidden items, see through scams, notice environmental clues. Steve's accounting background gives him decent base Awareness for financial deception. |

### The Normality Tension (Core Mechanic)

This is the game's central progression dilemma:

**High Normality (Steve resists the spiritual world)**
- Strong defense against psychic/spiritual attacks
- Corporate skills deal full damage
- NPCs find Steve confusing/amusing
- Locked out of some areas and dialogue options
- Cannot use spiritual skills

**Low Normality (Steve is "opening up")**
- Vulnerable to psychic/spiritual attacks
- Spiritual skills become available (and some are very powerful)
- NPCs take Steve seriously
- Access to advanced areas and deeper lore
- Corporate skills deal less damage (he's losing his edge)
- Funnier dialogue options (Steve accidentally uses spiritual jargon)

**The player must balance this.** Going full corporate or full spiritual both have drawbacks. The sweet spot — and the funniest outcome — is Steve awkwardly straddling both worlds.

---

## Turn Structure

Each turn, Steve can do ONE of:

1. **Attack** — Use a basic or special ability
2. **Item** — Use a consumable from inventory
3. **Talk** — Attempt a dialogue-based action (persuade, confuse, bore, set boundaries)
4. **Analyze** — Scan the enemy for weaknesses, backstory, and financial information
5. **Endure** — Defend. Reduces damage. Steve grits his teeth and waits it out. Some enemies lose interest if Steve endures long enough.
6. **Flee** — Leave combat. Always available. No shame. Steve is not a hero.

### Talk Actions (Unique to This Game)

Combat isn't always solved by hitting. Talk actions let Steve interact with enemies mid-fight:

| Talk Action | Effect | Example |
|-------------|--------|---------|
| **Set Boundary** | Blocks one enemy attack type for 2 turns. Some enemies are completely neutralized by boundaries. | "I'm not comfortable with this." The Oversharer can't use Trauma Dump. |
| **Corporate Jargon** | Confuses spiritual enemies. Chance to stun. | "Let's take this offline and circle back after we've aligned on deliverables." Enemy loses a turn trying to parse this. |
| **Validate** | De-escalates. Reduces enemy attack power. Some enemies can be fully talked down. | "I hear you. That sounds really hard." The Karma Yogi stops fighting. |
| **Question** | Reveals information. Sometimes breaks enemy logic. | "But who certified YOUR healer?" The Crystal Healer has an existential crisis. |
| **Bore** | Steve talks about accounting. Enemy loses interest over multiple turns. Low damage but consistent. | "The thing about amortization schedules is—" Enemy's eyes glaze over. |

---

## Attack Types (Damage Categories)

### Physical
Normal physical damage. Hitting someone with a singing bowl, throwing a sage bundle, etc. Straightforward.

### Psychic
Emotional and psychological damage. Guilt trips, unsolicited advice, armchair psychology, weaponized vulnerability. Most spiritual enemies deal psychic damage.

### Bureaucratic
Steve's specialty. Audits, tax analysis, compliance checks, spreadsheet attacks. Devastating against anyone with financial exposure (which is everyone here — none of these operations are properly structured).

### Spiritual
Attacks that target the soul/energy/vibe. Breathwork blasts, mantra attacks, crystal beams. Steve can't use these at high Normality but they become available as Normality drops.

### Cringe
Social damage. Embarrassment, awkwardness, secondhand shame. Steve is both a source of cringe (he's SO out of place) and vulnerable to it. The Influencer's poorly staged "authentic moment" deals cringe damage. Steve standing silently during ecstatic dance deals cringe damage to everyone nearby.

---

## Status Effects

### Negative (Applied to Steve)

| Effect | What It Does | Caused By | Cured By |
|--------|-------------|-----------|----------|
| **Activated** | Takes 10% more psychic damage per turn. The spiritual equivalent of "on fire." | Breathwork, intense sharing circles, unsolicited insights | Actual coffee, setting a boundary, "I have a meeting" |
| **Smudged** | Accuracy -20% for 3 turns. The sage smoke is in your eyes. | Sage bundles, incense attacks | Waiting it out, fresh air |
| **Guilt-Tripped** | Can't attack the enemy who applied it for 2 turns. | Karma Yogis, martyrs, anyone who says "after everything I've done for you" | Steve's "Not My Problem" passive (unlocked later) |
| **Overshared On** | Psychic damage over time. Someone told you something you can't unhear. | Oversharers, sharing circles, tantra TMI | Changing the subject, fleeing the conversation |
| **Gaslit** | Confusion. 30% chance each turn that Steve's action targets himself instead. "Maybe they're right. Maybe I AM the problem." | Facilitators, The Founder, anyone who says "I'm just reflecting back what I see" | Spreadsheet Analysis (ground yourself in facts) |
| **Enrolled** | Gold drain each turn. You've been signed up for something. | MLM pitches, workshop recruiters | Cancellation (requires Bureaucratic skill) |
| **Mirrored** | 50% of Steve's attacks reflect back to him. "That's YOUR projection." | Shadow Work Enthusiasts, therapist-adjacent enemies | Audit (expose THEIR projections) |
| **Hugged** | Immobilized for 1 turn. Can't attack or flee during unsolicited physical contact. | Boundary Violators, over-huggers | Consent Card item, Set Boundary talk action |

### Negative (Applied to Enemies)

| Effect | What It Does | Caused By |
|--------|-------------|-----------|
| **Audited** | Defense drops to 0. All financial records exposed. Psychic damage over time from shame. | Steve's Audit ability |
| **Bored** | Lose 1 turn. Steve has been talking about depreciation methods and the enemy has checked out. | Steve's Bore talk action, extended corporate jargon |
| **Boundary'd** | Specific attack type disabled for 2-3 turns. | Steve's Set Boundary talk action |
| **Existential Crisis** | Enemy questions their own beliefs. Attack power -50%. May flee combat. | Steve asking simple, direct questions that puncture the narrative |
| **Validated** | Attack power -30%. Enemy feels heard and is less hostile. Can stack. | Steve's Validate talk action |
| **Exposed** | Takes 2x damage from all sources. Their facade has cracked. | Finding evidence, completing analysis, or specific dialogue options |
| **Defunded** | Cannot use abilities that cost EP. Financial resources cut off. | Bureaucratic attacks targeting their income |
| **Grounded** | Spiritual attacks disabled. Connected to material reality against their will. | Steve's mundane presence, coffee items, factual statements |

### Neutral/Double-Edged

| Effect | What It Does |
|--------|-------------|
| **Resonating** | Applied by singing bowls. Stuns for 1 turn BUT increases target's Insight by 1. Even Steve's attacks accidentally cause spiritual growth. |
| **Caffeinated** | +30% damage and speed for 3 turns, then -20% for 2 turns (crash). From actual coffee. |
| **Opened Up** | Normality -5, but +3 to all social stats. Steve accidentally had a genuine moment. |

---

## Combat Flow Example

### "The Essential Oil Warrior Encounter"

**[ENCOUNTER START]**
*Steve is walking past the gift shop when someone steps into his path holding a tiny bottle.*

**Essential Oil Warrior:** Have you tried peppermint oil for your energy? You look like your chi is STAGNANT.

**Steve:** My chi is fine. I don't have chi. I have cholesterol.

**[TURN 1 — Player's Turn]**

Options:
- Attack: Orientation Pamphlet (basic attack, 5 dmg)
- Talk > Set Boundary: "I'm not interested, thank you."
- Talk > Bore: Begin explaining tax-deductible business expenses
- Analyze: Check this enemy's stats and weaknesses
- Item: Use consumable
- Flee: Walk away

*Player chooses: Analyze*

**[ANALYZE RESULT]**
> **Essential Oil Warrior**
> HP: 45/45 | Type: MLM Zealot
> Weakness: Bureaucratic (financial analysis), Facts
> Immunity: Spiritual (they think they already know everything about energy)
> Resistance: Psychic (they've "done the work" on themselves — poorly, but they believe it)
> Status: Enrolled (passive) — if this fight goes longer than 5 turns, Steve is auto-signed up for a $150 starter kit
> Note: Can be defeated instantly with Spreadsheet Analysis if available.

**[TURN 1 — Enemy's Turn]**
**Essential Oil Warrior uses ANOINT.**
*Hurls peppermint oil. Steve takes 12 damage + Smudged status (accuracy -20% for 3 turns).*
"RECEIVE THIS BLESSING! That tingling is your third eye WAKING UP!"
**Steve:** "That tingling is a chemical burn."

**[TURN 2 — Player's Turn]**
*Player chooses: Talk > Question*
"How much do you actually make from this?"

**Essential Oil Warrior:** "Well it's not about the MONEY, it's about — I mean there IS money, it's a business OPPORTUNITY — last month I made... well, after expenses... look, the REAL value is—"
*Enemy takes 8 psychic damage (self-inflicted from cognitive dissonance). Attack power -10%.*

**[TURN 3 — Enemy's Turn]**
**Essential Oil Warrior uses MLM PITCH.**
"Okay forget the oils for a second. What if I told you that for a one-time investment of—"
*Steve takes 10 psychic damage. Enrolled status timer starts: 5 turns until auto-purchase.*

**[TURN 4 — Player's Turn]**
*Player chooses: Special Ability > Spreadsheet Analysis*
*Steve pulls out a spreadsheet showing the enemy's actual profit/loss.*

"You've invested $6,000 in inventory. Total sales: $340. Net position: negative $5,660. Your hourly rate for time spent is approximately negative $4.20."

**Essential Oil Warrior:** "..."
**Essential Oil Warrior takes 45 damage (CRITICAL — Bureaucratic type vs financial weakness). DEFEATED.**

"My mother bought out of pity, didn't she."
*Drops: Tiny bottle of overpriced oil.*
*Enrolled status removed.*
*+3 Insight.*

---

## Encounter Design Principles

### Every Fight Has Multiple Resolution Paths

| Path | Method | Reward |
|------|--------|--------|
| **Combat win** | Reduce HP to 0 through attacks | Standard drops, XP |
| **Talk down** | Use Talk actions to de-escalate | Bonus dialogue/info, sometimes better items, more XP |
| **Bore to death** | Use Bore repeatedly until enemy leaves | Unique "Bored Away" achievement per enemy type |
| **Flee** | Run away | No reward but no penalty. Steve is not ashamed. |
| **Special resolution** | Use a specific item or ability for instant win | Hidden humor reward, achievement |

### Enemy Aggression Levels

Not every enemy is hostile. Some encounters start as conversations and only become combat if Steve says the wrong thing:

- **Passive:** Won't fight unless provoked. The Newcomer (Brandon), random guests.
- **Pushy:** Will keep bothering Steve but won't attack first. Essential Oil Warrior, Oversharer.
- **Territorial:** Attacks if Steve enters their space or challenges their authority. Yoga Snob, Gatekeeper.
- **Aggressive:** Initiates combat on sight. Rare. Maybe only in later zones.
- **Tragic:** Fighting them feels wrong. Karma Yogi, some broken followers. Game should make the player uncomfortable.
