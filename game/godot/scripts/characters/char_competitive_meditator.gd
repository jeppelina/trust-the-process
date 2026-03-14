extends StickCharacter
class_name CharCompetitiveMeditator
## The Competitive Meditator. A PERFECT CIRCLE of self-satisfaction in lotus position.
## Signature: spherical body mass, embroidered meditation cushion, topknot with wrap,
## oversized mala beads, smug meditation aura (concentric circles).

func _ready() -> void:
	accent_color = Color(0.83, 0.64, 0.29)  # gold mala beads
	character_id = "competitive_meditator"
	display_name = "Competitive Meditator"
	# Idle: almost no movement — the stillness IS the animation
	_bob_amplitude = 0.3
	_bob_speed = 0.6
	custom_minimum_size = Vector2(140, 130)
	super._ready()

const ROSE := Color(0.83, 0.42, 0.54)  # meditation cushion
const GOLD := Color(0.83, 0.64, 0.29)  # mala beads
const GOLD_DIM := Color(0.83, 0.64, 0.29, 0.4)

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Meditation cushion (embroidered, rose pink) ──
	# Base ellipse for cushion
	draw_arc(o + Vector2(0, 4) * s, 38 * s, 0.0, PI, 32, ROSE, LINE_WIDTH, true)
	# Side detail — stitching
	for i in range(0, 11, 2):
		var x = -36 + i * 8
		_draw_line_seg(o + Vector2(x, 2) * s, o + Vector2(x, 8) * s, HAIR_LINE, Color(ROSE.r * 0.7, ROSE.g * 0.7, ROSE.b * 0.7))
	# Cushion edge (bottom line)
	_draw_line_seg(o + Vector2(-38, 4) * s, o + Vector2(38, 4) * s, THIN_LINE, ROSE)

	# ── Body: nearly perfect circle (lotus position) ──
	# Main elliptical body mass
	_draw_circle_outline(o + Vector2(0, -22) * s, 28 * s)

	# ── Crossed ankles visible below ──
	# Left ankle/foot
	_draw_line_seg(o + Vector2(-16, 0) * s, o + Vector2(-20, 4) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(-20, 4) * s, o + Vector2(-18, 8) * s, HAIR_LINE)
	# Right ankle/foot (crossed over)
	_draw_line_seg(o + Vector2(16, 0) * s, o + Vector2(20, 4) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(20, 4) * s, o + Vector2(18, 8) * s, HAIR_LINE)

	# ── Hands on knees in mudra ──
	# Left hand: thumb to index on left knee
	var left_knee = o + Vector2(-18, -18) * s
	_draw_line_seg(left_knee + Vector2(-4, -2) * s, left_knee + Vector2(-2, 0) * s, HAIR_LINE)  # thumb
	_draw_line_seg(left_knee + Vector2(-2, 0) * s, left_knee + Vector2(0, -1) * s, HAIR_LINE)  # index
	_draw_line_seg(left_knee + Vector2(2, 0) * s, left_knee + Vector2(3, -2) * s, HAIR_LINE)  # other fingers
	_draw_line_seg(left_knee + Vector2(3, -2) * s, left_knee + Vector2(2, -3) * s, HAIR_LINE)

	# Right hand: same mudra on right knee
	var right_knee = o + Vector2(18, -18) * s
	_draw_line_seg(right_knee + Vector2(4, -2) * s, right_knee + Vector2(2, 0) * s, HAIR_LINE)  # thumb
	_draw_line_seg(right_knee + Vector2(2, 0) * s, right_knee + Vector2(0, -1) * s, HAIR_LINE)  # index
	_draw_line_seg(right_knee + Vector2(-2, 0) * s, right_knee + Vector2(-3, -2) * s, HAIR_LINE)  # other fingers
	_draw_line_seg(right_knee + Vector2(-3, -2) * s, right_knee + Vector2(-2, -3) * s, HAIR_LINE)

	# ── Oversized mala beads around shoulders ──
	_draw_mala_beads(o, s)

	# ── Neck: barely visible ──
	var neck_top = o + Vector2(0, -50) * s
	_draw_line_seg(o + Vector2(0, -48) * s, neck_top, 2.0)

	# ── Head: perfect circle ──
	var hc = neck_top + Vector2(0, -14) * s
	_draw_circle_outline(hc, 14 * s)

	# ── Neat topknot with hair wrap ──
	# Main topknot knot
	_draw_circle_outline(hc + Vector2(0, -18) * s, 3.5 * s, THIN_LINE)
	# Hair wrap (wrapped around topknot)
	_draw_arc_seg(hc + Vector2(0, -18) * s, 5 * s, 0.2, PI - 0.2, HAIR_LINE)

	# ── Face ──
	_draw_face(hc, s)

	# ── Meditation aura ──
	_draw_aura(o, s)

func _draw_mala_beads(o: Vector2, s: float) -> void:
	# Oversized mala beads looped around shoulders/torso
	# Large beads at regular intervals
	var bead_positions = [
		o + Vector2(-28, -20) * s,  # left shoulder
		o + Vector2(-18, -32) * s,  # upper left
		o + Vector2(0, -36) * s,    # top
		o + Vector2(18, -32) * s,   # upper right
		o + Vector2(28, -20) * s,   # right shoulder
	]

	for bead_pos in bead_positions:
		_draw_circle_outline(bead_pos, 4 * s, THIN_LINE, GOLD)
		draw_circle(bead_pos, 2.5 * s, GOLD)

	# Connecting string (faint)
	var string_pts = PackedVector2Array(bead_positions)
	draw_polyline(string_pts, Color(GOLD, 0.3), 0.8, true)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Eyes CLOSED smugly (curved lines with slight upturn at edges)
			draw_arc(hc + Vector2(-5, -1) * s, 3.5 * s, PI - 0.2, TAU + 0.2, 8, LINE_COLOR, 1.5, true)
			draw_arc(hc + Vector2(5, -1) * s, 3.5 * s, PI - 0.2, TAU + 0.2, 8, LINE_COLOR, 1.5, true)
			# Tiny self-satisfied smile
			draw_arc(hc + Vector2(0, 4) * s, 3 * s, 0.2, PI - 0.2, 8, LINE_COLOR, 1.2, true)

		Emotion.HAPPY:
			# One eye slightly peeking open (small dot visible)
			_draw_circle_outline(hc + Vector2(-5, -1) * s, 2 * s, HAIR_LINE)
			draw_circle(hc + Vector2(-5, -1) * s, 0.8 * s, LINE_COLOR)
			# Other eye still closed
			draw_arc(hc + Vector2(5, -1) * s, 3.5 * s, PI - 0.2, TAU + 0.2, 8, LINE_COLOR, 1.5, true)
			# Smirk
			draw_arc(hc + Vector2(0, 4) * s, 3.5 * s, 0.2, PI - 0.2, 8, LINE_COLOR, 1.3, true)

		Emotion.ANGRY:
			# Both eyes open, offended that meditation was disturbed
			_draw_circle_outline(hc + Vector2(-5, -1) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(-5, -1) * s, 1.2 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(5, -1) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(5, -1) * s, 1.2 * s, LINE_COLOR)
			# Offended mouth
			draw_arc(hc + Vector2(0, 6) * s, 2.5 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.2, true)

		Emotion.SCARED:
			# Eyes wide open, aura gone, posture breaks slightly
			_draw_circle_outline(hc + Vector2(-5, -1) * s, 4 * s, THIN_LINE)
			draw_circle(hc + Vector2(-5, -1) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(5, -1) * s, 4 * s, THIN_LINE)
			draw_circle(hc + Vector2(5, -1) * s, 1.5 * s, LINE_COLOR)
			# Shocked O mouth
			_draw_circle_outline(hc + Vector2(0, 7) * s, 2 * s, 1.2)

		Emotion.SPECIAL:
			# "Performative Stillness" defense mode
			# One eye peeking with pupil dot
			_draw_circle_outline(hc + Vector2(-5, -1) * s, 2.5 * s, HAIR_LINE)
			draw_circle(hc + Vector2(-5, -1) * s, 1.0 * s, LINE_COLOR)
			# Other eye closed in meditation
			draw_arc(hc + Vector2(5, -1) * s, 3.5 * s, PI - 0.2, TAU + 0.2, 8, LINE_COLOR, 1.5, true)
			# Smirk of invincible calm
			draw_arc(hc + Vector2(0, 4) * s, 3.5 * s, 0.2, PI - 0.2, 8, LINE_COLOR, 1.4, true)

func _draw_aura(o: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Normal aura: 3 concentric circles, fading opacity
			_draw_circle_outline(o + Vector2(0, -22) * s, 42 * s, 1.2, Color(GOLD, 0.15))
			_draw_circle_outline(o + Vector2(0, -22) * s, 50 * s, 1.0, Color(GOLD, 0.1))
			_draw_circle_outline(o + Vector2(0, -22) * s, 58 * s, 0.8, Color(GOLD, 0.06))

		Emotion.HAPPY:
			# Still subtle aura
			_draw_circle_outline(o + Vector2(0, -22) * s, 42 * s, 1.2, Color(GOLD, 0.15))
			_draw_circle_outline(o + Vector2(0, -22) * s, 50 * s, 1.0, Color(GOLD, 0.1))
			_draw_circle_outline(o + Vector2(0, -22) * s, 58 * s, 0.8, Color(GOLD, 0.06))

		Emotion.ANGRY:
			# Aura intensifies
			_draw_circle_outline(o + Vector2(0, -22) * s, 42 * s, 1.5, Color(GOLD, 0.25))
			_draw_circle_outline(o + Vector2(0, -22) * s, 50 * s, 1.2, Color(GOLD, 0.18))
			_draw_circle_outline(o + Vector2(0, -22) * s, 58 * s, 1.0, Color(GOLD, 0.12))

		Emotion.SCARED:
			# Aura collapses (no aura drawn)
			pass

		Emotion.SPECIAL:
			# Massive defense aura: 4 concentric circles, stronger opacity
			_draw_circle_outline(o + Vector2(0, -22) * s, 46 * s, 1.8, Color(GOLD, 0.3))
			_draw_circle_outline(o + Vector2(0, -22) * s, 54 * s, 1.4, Color(GOLD, 0.2))
			_draw_circle_outline(o + Vector2(0, -22) * s, 62 * s, 1.2, Color(GOLD, 0.15))
			_draw_circle_outline(o + Vector2(0, -22) * s, 70 * s, 1.0, Color(GOLD, 0.1))
