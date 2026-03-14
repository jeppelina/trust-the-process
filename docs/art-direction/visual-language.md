# Art Direction — Visual Language

## Core Principle

**The writing is the star. The art supports the comedy.**

Every visual decision should serve the joke or the atmosphere. We don't need beautiful — we need *expressive*. Think West of Loathing: crude drawings that act brilliantly.

---

## Style: Expressive Stick Figures

Characters are hand-drawn-feeling stick figures with **distinct body shape languages**. They are NOT identical bodies with different hats — each character's silhouette alone should tell you who they are.

### Shape Language Rules

Every character starts from a **shape metaphor**:

| Character Type | Shape | Why |
|---|---|---|
| Steve | Vertical lines, right angles | He's a spreadsheet. Rigid, orderly, doesn't bend. |
| Flowing/spiritual NPCs | S-curves, waves | They pour like essential oil. Everything sways. |
| Immovable/guru types | Triangle, wide base | Mountains. Rooted. You go around them. |
| Shady/trickster NPCs | Diagonals, hunched angles | Leaning in, off-balance. Something's not right. |
| Aggressive/warrior types | Jagged lines, sharp angles | Energy, tension, broken glass. |
| Blissed-out NPCs | Circles, soft round shapes | Boneless. They've "let go" of structure. |

### Body Variation

Characters vary in:
- **Shoulder width** (narrow = uptight, wide = grounded/imposing)
- **Posture** (ramrod straight, slouched, leaning, floating)
- **Weight distribution** (top-heavy, bottom-heavy, balanced)
- **Line quality** (Steve = rigid straight lines; spiritual characters = organic curves)

### Faces

Faces are minimal but highly expressive:
- Eyes carry 80% of the expression (size, shape, direction)
- Mouths are simple (line, curve, open circle)
- Eyebrows do the heavy lifting for emotion
- Each character has a **default face** that defines their personality

### Expression System

Each character needs **5 face states**:

| State | Eyes | Mouth | Use |
|---|---|---|---|
| Neutral | Character default | Character default | Idle, conversation |
| Happy | Squint/closed | Smile curve | Positive moments |
| Angry | Small, brows V-shaped | Tight line or teeth | Combat, frustration |
| Scared | Wide, whites showing | Grimace or open | Danger, shock |
| Special | Unique per character | Unique per character | Signature moment |

### Signature Props

Every character has ONE defining prop that's always visible:
- Steve: Briefcase (it acts — he grips it, hides behind it, drops it)
- Oil Warrior: Purple oil bottle (she holds it like a holy relic)
- Breathwork Monk: Visible breath wisps (they pulse with his state)
- Cacao Dealer: Trench coat (open/closed tells you his mood)

---

## Color Palette

### Philosophy — Bright & Inverted
The palette is **bright, airy, and warm** — like an actual sunlit retreat center. Backgrounds are light creams, soft sages, and warm naturals. Characters are drawn in **dark charcoal** lines, giving them clear contrast and a hand-drawn-on-paper feel. The UI uses warm earth tones on light panels, like a handwritten journal.

**Key inversion**: Characters are dark ink on bright backgrounds, not bright lines on dark. This gives the game an open, illustrated-storybook quality.

### Background Palette
- **HUD background**: `rgba(240, 232, 214, 0.95)` — warm cream, slight transparency
- **Scene backgrounds**: Bright warm tones per room:
  - Pavilion: `(0.88, 0.84, 0.76)` — warm cream, wooden reception hall
  - Garden Path: `(0.82, 0.88, 0.78)` — soft sage, dappled light
  - Sacred Garden: `(0.78, 0.85, 0.75)` — light garden green, peaceful
- **Dialogue panel**: `rgba(245, 240, 224, 0.97)` — warm parchment, high readability
- **Dialogue border**: `(0.72, 0.65, 0.48)` — warm gold-brown separator

### Text & UI Colors
- **Dark brown (primary accent)**: `(0.52, 0.38, 0.12)` — headers, location names, highlights
- **Dark body text**: `(0.22, 0.20, 0.16)` — dialogue, descriptions
- **Muted label**: `(0.50, 0.45, 0.35)` — HUD labels (HP, EP, NORM)
- **Stat values**: `(0.22, 0.20, 0.16)` — numbers, bar labels
- **Thought text**: `(0.50, 0.54, 0.48)` — muted sage, narrator voice
- **Choice text**: `(0.30, 0.26, 0.18)` — dark, clear, clickable
- **Continue prompt**: `(0.55, 0.50, 0.38)` — subtle but visible

### Speaker Colors — Full Dialogue Coloring

Each speaker gets a unique color applied to **both the name label AND the entire dialogue text**. This makes it instantly clear who's talking from across the room:

| Speaker | Color | Notes |
|---|---|---|
| Steve | `(0.25, 0.42, 0.25)` forest green | The normal guy — green like a spreadsheet cell |
| Receptionist | `(0.62, 0.38, 0.12)` warm brown-amber | Welcoming, official |
| Essential Oil Warrior | `(0.65, 0.22, 0.38)` deep rose | Matches her headband |
| Frank | `(0.38, 0.36, 0.30)` tool gray | Grounded, no-nonsense |
| Breathwork Monk | `(0.18, 0.38, 0.62)` deep blue | Matches his breath wisps |
| Cacao Dealer | `(0.28, 0.52, 0.18)` deep green | Matches his beanie |
| The Founder | `(0.62, 0.48, 0.15)` dark gold | Authority, ego |

### Character Accent Colors

Each character (or character type) gets ONE accent color used on their signature prop/detail:

| Character | Accent | Hex | Used On |
|---|---|---|---|
| Steve | Sage green | `#6a8a6a` | Tie |
| Oil Warrior | Rose pink | `#d46a8a` | Headband, skirt |
| Oil Warrior (secondary) | Purple | `#8a6ad4` | Oil bottles, crystal |
| Breathwork Monk | Calm blue | `#6a9ad4` | Breath wisps, robe details |
| Cacao Dealer | Lime green | `#8ad46a` | Beanie |
| Cacao Dealer (secondary) | Warm gold | `#d4a34a` | Cacao beans |
| Generic Receptionist | Amber | `#d4a34a` | Name tag |
| Groundskeeper Frank | Tool gray | `#9a9a8a` | Wrench/tools |

### Character Line Color
All character line work uses **dark charcoal** `(0.18, 0.16, 0.13)` — like ink on paper. Characters are drawn in dark lines against bright backgrounds, giving the game a storybook/sketchpad feel. Line width is slightly thicker (2.8px) to maintain presence at all sizes.

---

## Typography

### Font Strategy
- **Body text / Dialogue**: Serif font (Georgia-like). Warm, readable, literary.
- **HUD / Labels**: Same serif, smaller size, muted earth color.
- **Speaker names**: Serif, per-character color (see Speaker Colors above).
- **Location names**: ALL CAPS, tracked out, dark gold. Feels like a chapter title.

### Text Sizes (scaled up for readability)
- Dialogue body: 26px
- Speaker name: 18px
- HUD labels: 14–18px
- Location name: 18px
- Choice buttons: 22px
- Continue prompt: 20px

---

## Scene Composition

### Layout (960×640 viewport)
```
┌──────────────────────────────────────────┐
│  HP ██░░ 100  EP ██░░ 50  NORM ██░  🫘 0 │ ← HUD (48px, cream)
├──────────────────────────────────────────┤
│  THE WELCOME PAVILION                     │
│                                           │
│  ◀      [  NPC  ]   [  NPC  ]       ▶  │ ← Scene area (~60%, bright)
│         200% size, dark ink figures        │
│                                           │
├──────────────────────────────────────────┤
│  Speaker Name (colored)                   │
│  Dialogue text in speaker color with      │
│  typewriter effect...                     │ ← Dialogue (~40%, parchment)
│                               ▼ continue  │
└──────────────────────────────────────────┘
```

### Scene Area Rules
- Background is a bright warm color per room
- Characters stand on an implied ground line (bottom of scene area)
- NPCs are spaced evenly, centered horizontally, **200% scale** (240×200px)
- Navigation arrows on left/right edges, dark gold
- Location name top-left, dark gold, ALL CAPS

### Character Sizing
- NPCs in scene: ~200–240px tall (200% of original)
- NPC container: 600px wide, 240px tall from bottom
- Boss characters: 280–320px tall (they loom)
- Steve (if shown in scene): Same size as NPCs

---

## Animation Principles

### Idle Animation
Every character has a subtle idle motion:
- Steve: Slight nervous shift (tiny lateral sway, 0.5s cycle)
- Spiritual characters: Gentle floating bob (vertical, 2s cycle)
- Grounded characters: Breathing expansion (scale pulse, 3s cycle)
- Shady characters: Slight lean-and-return (rotation, 1.5s cycle)

### Reaction Animation
- **Appear**: Fade in + slight scale up (0.3s)
- **Disappear**: Fade out + slight scale down (0.2s)
- **Hit/Damage**: Quick shake (±4px, 3 cycles, 0.2s)
- **Speak**: Gentle bounce on each dialogue line
- **Selected/Hover**: Slight glow or outline highlight

### Room Transitions
- **Enter room**: Slight horizontal slide of all elements (0.3s ease-out)
- **Background**: Cross-fade between room colors (0.4s)

---

## Implementation: Godot `_draw()` System

Characters are rendered using Godot's built-in `_draw()` method rather than sprite sheets. This means:

1. **No external art files needed** — characters are code
2. **Perfect scaling** at any resolution
3. **Easy to animate** by tweening draw parameters
4. **Trivial to add characters** — write a new draw function
5. **Consistent visual style** guaranteed by shared constants

### Character Node Structure
```
StickCharacter (Control)  ← base class, handles shared logic
├── draws body using _draw()
├── expression: Emotion  ← NEUTRAL, HAPPY, ANGRY, SCARED, SPECIAL
├── pose: Pose           ← IDLE, TALK, ATTACK, HIT
└── accent_color: Color  ← character's signature color
```

### Shared Constants
```gdscript
const LINE_COLOR = Color(0.18, 0.16, 0.13)  # dark charcoal
const LINE_WIDTH = 2.8
const THIN_LINE = 1.8
const HEAD_RADIUS = 16.0
```

---

## Adding New Characters (Recipe)

1. **Pick a shape metaphor**: What object/shape IS this person?
2. **Choose one accent color**: What's their signature hue?
3. **Design one prop**: What do they always carry/wear?
4. **Draw the default face**: What emotion do they live in?
5. **Define idle animation**: How do they move when doing nothing?

That's it. Five decisions, and you have a character that reads clearly and fits the visual system.
