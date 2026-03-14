extends StickCharacter
class_name CharOilWarrior
## Essential Oil Warrior. All curves and flow, the visual opposite of Steve.
## Signature props: headband with gem, oil bottle, flowing skirt, crystal pendant.

func _ready() -> void:
	accent_color = Color(0.83, 0.42, 0.54)  # rose pink
	character_id = "oil_warrior"
	display_name = "???"
	# Idle: gentle floating bob
	_bob_amplitude = 3.0
	_bob_speed = 1.0
	_sway_amplitude = 0.8
	_sway_speed = 0.7
	super._ready()

const PURPLE := Color(0.54, 0.42, 0.83, 0.7)
const ROSE := Color(0.83, 0.42, 0.54)
const GOLD := Color(0.83, 0.64, 0.29)

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Feet (barely visible — she floats) ──
	draw_arc(o + Vector2(-10, -2) * s, 6 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, THIN_LINE, true)
	draw_arc(o + Vector2(10, -2) * s, 6 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, THIN_LINE, true)

	# ── Flowing skirt ──
	var waist = o + Vector2(0, -50) * s
	var skirt_pts = PackedVector2Array([
		waist + Vector2(-14, 0) * s,
		o + Vector2(-26, -6) * s,
		o + Vector2(-18, -2) * s,
		o + Vector2(0, -4) * s,
		o + Vector2(18, -2) * s,
		o + Vector2(26, -6) * s,
		waist + Vector2(14, 0) * s,
	])
	draw_polyline(skirt_pts, ROSE, THIN_LINE, true)
	# Inner flow lines
	var wave_t = _idle_time * 0.8
	for i in 2:
		var sx = -6.0 + i * 12.0
		draw_arc(waist + Vector2(sx, 16) * s, 14 * s, 0.3 + sin(wave_t + i) * 0.1, PI - 0.3 + sin(wave_t + i) * 0.1, 12, Color(ROSE, 0.3), HAIR_LINE, true)

	# ── Torso: S-curve ──
	var shoulder = o + Vector2(0, -82) * s
	var torso_pts = PackedVector2Array([
		waist,
		waist + Vector2(-3, -10) * s,
		shoulder + Vector2(2, 8) * s,
		shoulder,
	])
	draw_polyline(torso_pts, LINE_COLOR, LINE_WIDTH, true)

	# ── Crystal pendant ──
	draw_arc(shoulder + Vector2(0, 5) * s, 10 * s, 0.3, PI - 0.3, 12, PURPLE, THIN_LINE, true)
	var pendant_pts = PackedVector2Array([
		shoulder + Vector2(-2, 12) * s,
		shoulder + Vector2(2, 12) * s,
		shoulder + Vector2(0, 18) * s,
	])
	draw_colored_polygon(pendant_pts, PURPLE)

	# ── Shoulders: sloped, relaxed ──
	var sh_l = shoulder + Vector2(-22, 8) * s
	var sh_r = shoulder + Vector2(22, 8) * s
	draw_polyline(PackedVector2Array([
		sh_l,
		shoulder + Vector2(-8, 0) * s,
		shoulder + Vector2(8, 0) * s,
		sh_r
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms ──
	match expression:
		Emotion.ANGRY, Emotion.SPECIAL:
			_draw_arms_attack(o, s, sh_l, sh_r)
		_:
			_draw_arms_blessing(o, s, sh_l, sh_r)

	# ── Neck: graceful, longer ──
	var neck_top = shoulder + Vector2(0, -12) * s
	draw_polyline(PackedVector2Array([
		shoulder + Vector2(0, -2) * s,
		shoulder + Vector2(-1, -7) * s,
		neck_top
	]), LINE_COLOR, 2.0, true)

	# ── Head ──
	var hc = neck_top + Vector2(0, -15) * s
	_draw_circle_outline(hc, 15 * s)

	# ── Flowing hair ──
	draw_polyline(PackedVector2Array([
		hc + Vector2(-15, -2) * s,
		hc + Vector2(-18, 8) * s,
		hc + Vector2(-16, 20) * s,
		hc + Vector2(-14, 30) * s,
	]), LINE_COLOR, 2.0, true)
	draw_polyline(PackedVector2Array([
		hc + Vector2(15, -2) * s,
		hc + Vector2(18, 8) * s,
		hc + Vector2(16, 20) * s,
		hc + Vector2(14, 30) * s,
	]), LINE_COLOR, 2.0, true)

	# ── Headband with gem ──
	draw_arc(hc, 16 * s, PI + 0.6, TAU - 0.6, 16, ROSE, 3.0, true)
	draw_circle(hc + Vector2(0, -15) * s, 3 * s, ROSE)

	# ── Face ──
	_draw_face(hc, s)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL, Emotion.HAPPY:
			# Serene half-closed eyes
			draw_arc(hc + Vector2(-6, -1) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.8, true)
			draw_circle(hc + Vector2(-6, 0) * s, 1.0 * s, LINE_COLOR)
			draw_arc(hc + Vector2(6, -1) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.8, true)
			draw_circle(hc + Vector2(6, 0) * s, 1.0 * s, LINE_COLOR)
			# Knowing arched brows
			draw_arc(hc + Vector2(-6, -5) * s, 5 * s, PI + 0.8, TAU - 0.8, 8, LINE_COLOR, 1.2, true)
			draw_arc(hc + Vector2(6, -5) * s, 5 * s, PI + 0.8, TAU - 0.8, 8, LINE_COLOR, 1.2, true)
			# Slight knowing smile
			draw_arc(hc + Vector2(0, 5) * s, 6 * s, 0.3, PI - 0.3, 12, LINE_COLOR, 1.3, true)

		Emotion.ANGRY, Emotion.SPECIAL:
			# Eyes open, intense, still smiling
			_draw_circle_outline(hc + Vector2(-6, 0) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(-6, 0) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(6, 0) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(6, 0) * s, 1.5 * s, LINE_COLOR)
			# Wider smile — unhinged
			draw_arc(hc + Vector2(0, 4) * s, 8 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.5, true)
			_draw_line_seg(hc + Vector2(-7, 6) * s, hc + Vector2(7, 6) * s, 0.8)

		Emotion.SCARED:
			# Eyes wide (rare — only if her oils fail)
			_draw_circle_outline(hc + Vector2(-6, 0) * s, 4 * s, THIN_LINE)
			draw_circle(hc + Vector2(-6, 1) * s, 2 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(6, 0) * s, 4 * s, THIN_LINE)
			draw_circle(hc + Vector2(6, 1) * s, 2 * s, LINE_COLOR)
			# Mouth: small O
			_draw_circle_outline(hc + Vector2(0, 8) * s, 3 * s, 1.3)

func _draw_arms_blessing(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Left arm: raised, holding oil bottle high
	var elbow_l = sh_l + Vector2(-8, -10) * s
	var hand_l = elbow_l + Vector2(-2, -14) * s
	_draw_line_seg(sh_l, elbow_l)
	_draw_line_seg(elbow_l, hand_l)
	# Fingers
	_draw_line_seg(hand_l, hand_l + Vector2(-4, -2) * s, HAIR_LINE)
	_draw_line_seg(hand_l, hand_l + Vector2(-2, -4) * s, HAIR_LINE)
	_draw_line_seg(hand_l, hand_l + Vector2(2, -4) * s, HAIR_LINE)

	# Oil bottle
	var bottle = hand_l + Vector2(-4, -20) * s
	draw_rect(Rect2(bottle, Vector2(12, 16) * s), PURPLE, false, 2.0)
	draw_rect(Rect2(bottle + Vector2(3, -6) * s, Vector2(6, 7) * s), PURPLE, false, THIN_LINE)
	# Sparkles
	var sparkle_color = Color(GOLD, 0.6)
	draw_circle(bottle + Vector2(-4, 2) * s, 1.5 * s, sparkle_color)
	draw_circle(bottle + Vector2(16, 0) * s, 1.0 * s, sparkle_color)
	draw_circle(bottle + Vector2(6, -8) * s, 1.2 * s, sparkle_color)

	# Right arm: gracefully extended, blessing
	var elbow_r = sh_r + Vector2(10, 12) * s
	var hand_r = elbow_r + Vector2(6, 8) * s
	_draw_line_seg(sh_r, elbow_r)
	_draw_line_seg(elbow_r, hand_r)
	# Spread fingers (blessing gesture)
	_draw_line_seg(hand_r, hand_r + Vector2(4, -4) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(6, -1) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(5, 3) * s, HAIR_LINE)

func _draw_arms_attack(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Left arm: hurling bottle
	var hand_l = sh_l + Vector2(-18, -8) * s
	_draw_line_seg(sh_l, sh_l + Vector2(-8, 2) * s)
	_draw_line_seg(sh_l + Vector2(-8, 2) * s, hand_l)

	# Bottle mid-air with motion arc
	var bottle_pos = hand_l + Vector2(-14, -6) * s
	draw_rect(Rect2(bottle_pos, Vector2(10, 14) * s), PURPLE, false, 2.0)
	# Motion lines
	_draw_line_seg(hand_l + Vector2(-2, 0) * s, bottle_pos + Vector2(12, 6) * s, HAIR_LINE, DIM_COLOR)

	# Right arm: reaching for belt of bottles
	var hand_r = sh_r + Vector2(6, 26) * s
	_draw_line_seg(sh_r, sh_r + Vector2(4, 14) * s)
	_draw_line_seg(sh_r + Vector2(4, 14) * s, hand_r)

	# Belt of backup bottles
	for i in 3:
		var bx = sh_r.x + (2 + i * 10) * s
		var by = sh_r.y + 24 * s
		draw_rect(Rect2(Vector2(bx, by), Vector2(7, 9) * s), PURPLE, false, 1.2)
