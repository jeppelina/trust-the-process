# Enemy Archetypes & Type System

## Enemy Types (Classes)

Every enemy belongs to a TYPE that determines their damage profile, weaknesses, and behavior patterns. Types persist across zones — you'll encounter variations of these archetypes at every stop on the spiritual pipeline.

| Type | Primary Damage | Weakness | Resistance | Immunity | Behavior |
|------|---------------|----------|------------|----------|----------|
| **MLM Zealot** | Psychic + Gold drain | Bureaucratic (financial truth) | Psychic (they've rationalized everything) | Spiritual (think they know energy) | Pushy. Won't fight but won't leave. Escalates sales pitch each turn. |
| **Boundary Crosser** | Physical + Psychic | Boundaries (Set Boundary talk action) | Psychic (they think they're empathetic) | — | Approaches and touches without consent. Stuns through physical contact. |
| **True Believer** | Spiritual + Psychic | Bureaucratic (facts), Questions | Spiritual (deep conviction) | Cringe (they don't get embarrassed) | Genuinely believes. Hard to fight because they're not malicious, just wrong. |
| **Status Climber** | Psychic (ego attacks) | Being ignored, Honest kindness | Bureaucratic (they don't care about rules) | — | Competitive. Everything is about hierarchy. Attacks are flexes and one-ups. |
| **Wounded Healer** | Psychic (guilt + manipulation) | Genuine compassion | Physical (fragile), Bureaucratic | — | Uses their pain as a weapon. Attacks are guilt trips. Defeating them feels bad. |
| **Gatekeeper** | Psychic (authority, denial) | Exposure (reveal their real backstory) | Spiritual, Psychic | Physical (you can't punch your way past social authority) | Blocks progress. Can't be fought directly — must be outsmarted or undermined. |
| **Facilitator** | Psychic + Spiritual | Bureaucratic (financial exposure), Cringe (catch them being fake) | Psychic (they've "done the work") | Talk actions below Insight Level 3 | Trained in deflection. Every attack you make gets reframed. Must be exposed. |
| **Karma Worker** | Psychic (guilt) | Kindness (can be turned into ally) | Physical (they're exhausted, low HP) | — | Tragic enemy. Low HP, low damage, but guilt attacks are effective. Not fighting them is usually better. |
| **Guru/Boss** | All types | Bureaucratic (especially Forensic Accounting) | Spiritual + Psychic (years of practice) | First-turn attacks (phase-based bosses) | Multi-phase. Each phase strips away a layer of persona. Must be fought with escalating evidence. |

## Type Interactions (Damage Matrix)

Some attack types are extra effective or ineffective against certain enemy types:

```
                    TARGET TYPE
                    MLM    Boundary  True     Status   Wounded  Gate    Facil.  Karma
ATTACK TYPE         Zealot Crosser   Believer Climber  Healer   keeper  itator  Worker
─────────────────────────────────────────────────────────────────────────────────────
Physical            1x     1x        1x       1x       1.5x     0x      1x      1.5x
Psychic             0.5x   0.5x      1x       1.5x     0.5x     1x      0.5x    0.5x
Bureaucratic        2x     1x        2x       0.5x     1x       1x      2x      1x
Spiritual           0x     1x        0.5x     1x       1x       0.5x    0.5x    1x
Cringe              1x     1x        0x       2x       0.5x     1x      1.5x    0x

Talk: Boundary      0.5x   3x        0.5x     0x       1x       0x      1x      1x
Talk: Validate      1x     0.5x      1x       0x       2x       1x      0.5x    3x
Talk: Question      1.5x   1x        2x       1x       0.5x     2x      1.5x    0.5x
Talk: Bore          1x     1.5x      0.5x     1.5x     1x       0.5x    1x      0x
```

Key takeaways:
- **Bureaucratic beats almost everything.** Steve's core strength. These people are financially exposed.
- **Psychic is unreliable.** Most spiritual enemies have some psychic resistance because they've "done the work."
- **Physical works on the fragile.** Wounded Healers and Karma Workers are physically weak.
- **Talk actions are specialized.** Boundaries destroy Boundary Crossers. Validation converts Karma Workers. Questions crack True Believers.
- **Cringe is niche but devastating** against Status Climbers who live and die by social perception.
- **Nothing works well against Gatekeepers** through direct assault. They require investigation + specific dialogue.

## Enemy Variants Across Zones

Each archetype appears in every zone but with zone-specific theming:

### MLM Zealot Variants

| Zone | Variant | Selling |
|------|---------|---------|
| Zone 1 (Retreat) | Essential Oil Warrior | doTERRA/Young Living |
| Zone 2 (TBD) | Supplement Shaman | Adaptogenic mushroom powders |
| Zone 5 (Tantra) | Sacred Intimacy Coach | $5,000 couples workshop package |
| Zone 9 (Festival) | Conscious DJ | Their Soundcloud link + booking fees |
| Zone 10 (Burning Man) | Gifting Economy Evangelist | Nothing (but they make you feel guilty for not gifting enough) |

### True Believer Variants

| Zone | Variant | Believes In |
|------|---------|-------------|
| Zone 1 (Retreat) | Competitive Meditator | Meditation as competitive sport |
| Zone 3 (Breathwork) | Breathwork Apostle | "I literally died and came back" |
| Zone 4 (Healing) | Crystal Devotee | Rocks are sentient and healing them |
| Zone 6 (Ayahuasca) | Medicine Purist | "Grandmother Aya told me personally" |
| Zone 7 (Men's Camp) | Initiated Man | "I've done the warrior training" |

### Wounded Healer Variants

| Zone | Variant | Wound |
|------|---------|-------|
| Zone 1 (Retreat) | Karma Yogi | Exploitation disguised as service |
| Zone 4 (Healing) | The Client Who Became a Healer | "I healed myself so I can heal you (I haven't healed myself)" |
| Zone 5 (Tantra) | The Heartbroken Tantrika | Uses intimacy practice to avoid intimacy |
| Zone 8 (Poly House) | The Relationship Anarchist | "I don't need anyone (I need everyone)" |
| Zone 10 (Burning Man) | The Burned-Out Burner | 15 years of burns, lost everything for this, can't stop |

---

## Boss Design Pattern

Every zone boss follows a 3-phase structure:

### Phase 1: The Mask
- Boss presents their public persona
- Deflects all attacks through spiritual framing
- Must be broken with evidence/investigation, not brute force
- Steve's combat abilities are less effective; Talk and Analyze are key

### Phase 2: The Crack
- Mask slips. The real person emerges, angry and defensive
- Standard combat with boss-specific mechanics
- Boss uses weaponized versions of their spiritual practice
- Evidence-based attacks (Audit, Forensic Accounting) are most effective

### Phase 3: The Person
- The human underneath. Scared, sad, or lost
- Boss becomes erratic — mix of genuine vulnerability and last-ditch manipulation
- Player chooses resolution: destroy, leave, or something creative
- Resolution choice affects zone epilogue and potentially future zones

### The Emotional Rule
Every boss should have a moment where the player thinks: "Oh. They're just a person." Not to excuse their behavior — but to complicate the victory. This is what separates the game from pure mockery.

---

## Companion Combat Role

If companions are implemented, each fills a classic RPG role but flavored:

| Role | Companion | Combat Style |
|------|-----------|-------------|
| **Tank** | Frank (Groundskeeper) | High HP, physical attacks with tools, taunts enemies by being relentlessly normal |
| **Support** | Maya (Skeptical Karma Yogi) | Heals, buffs, reveals enemy info, sarcastic commentary on every turn |
| **DPS** | Disillusioned Facilitator (TBD) | High spiritual damage, fragile, needs Steve's encouragement to not have a crisis mid-fight |
| **Hybrid** | The Wife (endgame) | Can use both corporate AND spiritual skills. The only character who bridges both trees. |

Companions have their own Talk actions during combat:
- Frank: "Have you tried just being normal?" (Deals cringe damage to spiritual enemies)
- Maya: "I worked in the kitchen for seven months. You think I'm afraid of YOU?" (Intimidation)
- Frank on seeing The Founder: "Morning, Derek." (Targeted ego damage)
