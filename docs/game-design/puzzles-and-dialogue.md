# Puzzle & Dialogue Mechanics

## Core Principle

Puzzles in this game are social, not mechanical. Steve doesn't push blocks or solve rune sequences. He navigates bureaucracy, social dynamics, and the gap between what people say and what they mean. The player has to read between the lines, gather information, and use the right approach with the right person.

---

## Puzzle Types

### 1. The Gatekeeper Puzzle

**Pattern:** Someone blocks Steve's path. The block isn't physical — it's social/spiritual authority. Steve needs to find the right combination of evidence, Insight level, dialogue choices, or items to get through.

**Zone 1 Example:** Dharma John guards the Ceremony Space. Solutions:
- Raise Insight to required level through gameplay
- Complete Frank's side quest for the master key (bypasses entirely)
- Use Cold Read to discover John's real backstory, then talk him down
- Find a specific dialogue path that resonates with John's buried corporate identity

**Design Rule:** Always at least 3 solutions. One combat-adjacent, one social, one clever/exploratory. Never require a specific path.

### 2. The Hypocrisy Puzzle

**Pattern:** Someone claims one thing but does another. Steve has to find proof of the contradiction and use it — either to help someone, expose something, or unlock a path.

**Zone 1 Examples:**
- The Sanctuary preaches non-hierarchy but operates a caste system → Find evidence in the Back Office
- A healer charges $300 for crystals bought for $0.50 → Find the Alibaba receipts
- The Founder preaches non-attachment from inside the only private cabin with Wi-Fi → Observe and document

**Mechanics:**
- Steve's Awareness stat helps him notice contradictions (highlighted in the environment)
- The Analyze ability in combat shows an enemy's stated values vs. actual behavior
- Documents, receipts, and records are the "keys" that unlock these puzzles
- Presenting evidence to the right NPC at the right time triggers results

### 3. The Social Navigation Puzzle

**Pattern:** Steve needs something from an NPC who won't give it directly. He has to figure out what they actually want (which is never what they say they want) and fulfill that need.

**Example — Getting Info from a Facilitator:**
- Facilitator says: "I can't share about other people's journeys. It would violate the container."
- What they actually want: To feel important and validated
- Solution: Attend their workshop, compliment their method, THEN ask about the wife
- Alternative: Find someone who has gossip about the facilitator (everyone gossips at the fire pit) and use that as leverage

**Example — Convincing a Karma Yogi to Help:**
- They say: "I'm not allowed to talk about internal operations."
- What they actually want: Someone to acknowledge they're being exploited
- Solution: Validate their experience first ("This doesn't seem fair"), then they open up
- Alternative: Offer a practical kindness (bring them actual coffee)

**Design Rule:** Spiritual people respond to emotional/social approaches. Practical people (Frank, locals) respond to direct requests and fair trades. Nobody responds to Steve being corporate at them unless that's the joke.

### 4. The Ritual Puzzle (Performance Encounters)

**Pattern:** Steve must participate in a ceremony or workshop and make the right choices to survive/succeed. These are multi-step sequences where each step has consequences.

**Example — The Sharing Circle (Zone 1):**
1. Sit down (automatic)
2. Listen to Share 1 → Choose response (nod, validate, or question)
3. Listen to Share 2 → Choose response (harder — must resist reacting)
4. Your turn to share → Choose what to say (this is the puzzle — what level of honesty/performance gets the best result?)
5. Close the circle → Outcome based on cumulative choices

**Example — The Breathwork Session:**
1. Lie down. Follow the breathing pattern (rhythm mini-game?)
2. Resist or surrender to the "experience" (choice affects Normality)
3. Respond to the facilitator's prompts ("What do you see?" → choosing the right answer based on what you've learned)
4. Post-session integration → What you say here determines NPC relationships going forward

**Example — The Cacao Ceremony:**
1. Accept or decline the cacao (declining offends everyone)
2. Set an "intention" (multiple choice — funny options vs. genuine options)
3. Sit through the music and sharing (endurance + dialogue choices)
4. Report your "experience" (the puzzle: what do they want to hear vs. what's true?)

### 5. The Investigation Puzzle

**Pattern:** Steve needs to find specific information. This involves exploring, talking to NPCs, collecting documents, and piecing together a story. Classic adventure game structure.

**Zone 1 Main Quest as Investigation:**
- **Clue 1:** Receptionist mentions the wife was here but won't give details
- **Clue 2:** Kitchen workers remember her, point to Maya
- **Clue 3:** Maya says the wife got close to The Founder, check the Back Office or ceremony space
- **Clue 4:** Back Office contains financial records AND a client file with the wife's notes
- **Clue 5:** Client file references a "recommendation letter" and destination
- **Resolution:** Confront The Founder with evidence or find the letter directly

Each clue is gated behind a social interaction, exploration, or mini-puzzle. The player always has multiple paths to the next clue.

### 6. The Item Delivery Puzzle

**Pattern:** An NPC needs a specific item, but getting that item requires navigating social or physical obstacles.

**Examples:**
- Maya needs her passport → It's in the Back Office → The office is locked → Frank has the key → Frank needs help with the generator
- Jade needs Wi-Fi → The password is in The Founder's cabin → Getting into the cabin requires either stealth (night mission) or social engineering (befriend a follower who cleans it)
- A guest needs actual medicine (not crystal healing) → The nearest pharmacy is in town → Steve needs to get past the "digital detox" barrier to use his phone to call a car → The phone is locked in reception

**Design Rule:** Item chains should be 2-3 steps maximum. Longer chains feel tedious. The comedy comes from WHAT the items are and WHY they're hard to get, not from the length of the chain.

---

## Dialogue System Design

### Structure

Dialogue uses a branching tree with MEMORY. NPCs remember what Steve has said and done. Being rude to someone in one conversation affects future ones. Helping someone unlocks new dialogue later.

### Dialogue Flags

The game tracks key dialogue choices as flags that persist through the zone:

| Flag | Set By | Affects |
|------|--------|---------|
| used_real_name | Insisting on "Steve" not "Akash Prem" | Some NPCs respect it, some are offended |
| helped_karma_yogi | Side quest completion | Other Karma Yogis trust Steve |
| attended_workshop | Participating in any workshop | Facilitators acknowledge Steve |
| exposed_finances | Finding the financial records | The Founder's dialogue changes, some followers become allies |
| validated_guest_3 | Sharing circle response | Guest 3 becomes info source |
| frank_ally | Completing Frank's side quest | Master key access, Frank appears in boss fight |
| used_actual_money | Paying with Steve's salary instead of cacao | Vibe drops, but some practical NPCs respect it |
| read_founders_book | Buying and reading the book | Special dialogue options with The Founder and followers |

### Dialogue Tones

Every dialogue choice Steve has falls into one of these tones:

| Tone | Icon | Effect | Example |
|------|------|--------|---------|
| **Corporate** | Briefcase | +Normality, +Credibility with normals, -Vibe | "I'd like to escalate this to your supervisor." |
| **Honest** | Plain circle | Neutral stats, but builds trust long-term | "I don't understand any of this." |
| **Spiritual** (Fake) | Sparkle with crack | +Vibe, -Normality, NPCs may see through it | "I really feel called to explore that." |
| **Spiritual** (Genuine) | Solid sparkle | -Normality, +Insight, +deep NPC trust | "That actually... resonated with me." (Steve is surprised) |
| **Sarcastic** | Raised eyebrow | Funny but risky — some NPCs love it, some become hostile | "Sure, and I'm the reincarnation of a tax auditor. Actually, I might be." |
| **Kind** | Heart | +relationship with everyone, sometimes opens unexpected paths | "Are you okay? You seem tired." |

### Hidden Dialogue Mechanic: "Steve Accidentally Means It"

At certain points in the game, a dialogue option appears that LOOKS like a typical sarcastic/corporate Steve response, but when he says it, something shifts. He means it. The voice acting (or text styling) subtly changes. The NPC reacts differently. Steve didn't plan to be vulnerable but it happened.

These moments are rare and should feel earned. They're the emotional core of the game hiding inside the comedy.

**Example:**
- NPC asks: "Why are you really here?"
- Option reads: "Because my wife left and I don't know who I am without her."
- Player expects this to be a joke setup. It's not. Steve says it quietly. The NPC goes silent. The music changes for a moment. Then the scene continues and Steve deflects ("Anyway, about those financial records—").

---

## Environmental Puzzles

### Readable Environment

The game world is full of readable objects that provide clues, comedy, and context:

- **Notice boards:** Workshop schedules (reveal timing for stealth missions), community announcements ("Lost: one sense of self. If found, please return to Cabin 4"), passive-aggressive notes ("WHOEVER is using the good coconut oil for COOKING, that is CEREMONIAL GRADE and costs $40 a bottle")
- **Bookshelves:** The Founder's office has revealing reading material. Each book title is a joke but some contain real clues.
- **Computer screens:** If Steve can access the Back Office computer, the browser tabs tell a story (Alibaba crystal orders, marketing analytics, a half-written memoir)
- **Trash cans:** Discarded drafts of The Founder's speeches, crumpled donation receipts, evidence
- **Journals left open:** NPCs' private thoughts. Ethically questionable to read. Gameplay-valuable.

### Hidden Areas

Each zone has secret areas found through observation or NPC tips:

- **Zone 1:** The maintenance tunnels (Frank's domain), The Founder's personal storage unit, the "completed" Karma Yogi graveyard (a wall of photos of volunteers who left — or "completed their seva")

### Environmental Storytelling

The environment tells stories without dialogue:

- A Karma Yogi's bunk has tally marks scratched into the bed frame (counting days)
- The kitchen whiteboard has "GRATITUDE" written at the top and nothing else
- The gift shop has a "suggested donation" jar that's actually a credit card terminal
- The ceremony space has water stains on the ceiling that The Founder claims are "sacred geometry" (they're from a leak Frank reported six months ago)
