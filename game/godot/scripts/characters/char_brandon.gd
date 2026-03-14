extends StickCharacter
class_name CharBrandon
## Brandon the Spiritual Convert. Clean-cut and preppy, increasingly loose as he's absorbed.
## Signature: polo shirt, nice hair (parted), bright eager eyes, NO WATCH (watch_gone state).
## Starts enthusiastic, ends glazed and eerie with full conversion.

func _ready() -> void:
	accent_color = Color(0.20, 0.65, 0.65)  # bright teal
	character_id = "brandon"
	display_name = "Brandon"
	# Idle: eager forward lean, slight bounce
	_sway_amplitude = 0.8
	_sway_speed = 1.5
	_bob_amplitude = 2.2
	_bob_speed = 2.2
	custom_minimum_size = Vector2(140, 160)
	super._ready()

const TEAL := Color(0.20, 0.65, 0.65)
const POLO_WHITE := Color(0.90, 0.90, 0.92)

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Athletic shoes (sleek) ──
	var foot_l = o + Vector2(-12, 0) * s
	var foot_r = o + Vector2(12, 0) * s
	_draw_line_seg(foot_l + Vector2(-4, 0) * s, foot_l + Vector2(3, -2) * s, THIN_LINE)
	_draw_line_seg(foot_r + Vector2(-3, -2) * s, foot_r + Vector2(4, 0) * s, THIN_LINE)

	# ── Legs (athletic build) ──
	var hip = o + Vector2(0, -52) * s
	_draw_line_seg(foot_l, hip + Vector2(-5, 0) * s, 2.4)
	_draw_line_seg(foot_r, hip + Vector2(5, 0) * s, 2.4)

	# ── Polo shirt (collared, teal accent) ──
	_draw_polo(hip, s)

	# ── Torso ──
	var shoulder = o + Vector2(0, -88) * s
	_draw_line_seg(hip, shoulder, 2.8)

	# ── Shoulders (athletic, square) ──
	var sh_l = shoulder + Vector2(-24, 0) * s
	var sh_r = shoulder + Vector2(24, 0) * s
	draw_polyline(PackedVector2Array([
		sh_l,
		shoulder + Vector2(-6, -2) * s,
		shoulder + Vector2(6, -2) * s,
		sh_r
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms ──
	match expression:
		Emotion.ANGRY:
			_draw_arms_confused(o, s, sh_l, sh_r)
		Emotion.SCARED:
			_draw_arms_lost(o, s, sh_l, sh_r)
		Emotion.SPECIAL:
			_draw_arms_converted(o, s, sh_l, sh_r)
		_:
			_draw_arms_default(o, s, sh_l, sh_r)

	# ── Neck ──
	var neck_base = shoulder + Vector2(0, -2) * s
	var neck_top = shoulder + Vector2(0, -10) * s
	_draw_line_seg(neck_base, neck_top, 2.2)

	# ── Head ──
	var head_center = neck_top + Vector2(0, -18) * s
	var head_rx = 15.0 * s
	var head_ry = 17.0 * s
	_draw_head_oval(head_center, head_rx, head_ry)

	# ── Nice parted hair ──
	var part = head_center.x
	var hair_l = PackedVector2Array([
		head_center + Vector2(-15, -8) * s,
		head_center + Vector2(-12, -18) * s,
		head_center + Vector2(-4, -16) * s,
		head_center + Vector2(-1, -14) * s,
	])
	draw_polyline(hair_l, LINE_COLOR, 2.2, true)
	var hair_r = PackedVector2Array([
		head_center + Vector2(1, -14) * s,
		head_center + Vector2(4, -16) * s,
		head_center + Vector2(12, -18) * s,
		head_center + Vector2(15, -8) * s,
	])
	draw_polyline(hair_r, LINE_COLOR, 2.2, true)

	# ── Face ──
	_draw_face(head_center, s)

func _draw_polo(hip: Vector2, s: float) -> void:
	# Polo shirt outline
	var shoulder = hip + Vector2(0, -36) * s
	var polo_pts = PackedVector2Array([
		hip + Vector2(-14, 0) * s,
		hip + Vector2(-16, -2) * s,
		shoulder + Vector2(-22, 0) * s,
		shoulder + Vector2(-8, -3) * s,
		shoulder + Vector2(0, -2) * s,
		shoulder + Vector2(8, -3) * s,
		shoulder + Vector2(22, 0) * s,
		hip + Vector2(16, -2) * s,
		hip + Vector2(14, 0) * s,
	])
	draw_polyline(polo_pts, LINE_COLOR, 2.6, true)

	# Teal collar detail
	_draw_line_seg(shoulder + Vector2(-8, -3) * s, shoulder + Vector2(8, -3) * s, 2.2, TEAL)
	# Collar shape
	draw_arc(shoulder + Vector2(0, -1) * s, 10 * s, PI + 0.3, TAU - 0.3, 10, TEAL, 1.8, true)

	# Polo buttons
	for i in 2:
		var by = hip.y + (-4 - i * 6) * s
		draw_circle(Vector2(hip.x, by), 1.2 * s, DIM_COLOR)

func _draw_head_oval(center: Vector2, rx: float, ry: float) -> void:
	var points := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		points.append(center + Vector2(cos(angle) * rx, sin(angle) * ry))
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Wide eager eyes, open smile
			draw_circle(hc + Vector2(-6, 0) * s, 2.0 * s, LINE_COLOR)
			draw_circle(hc + Vector2(6, 0) * s, 2.0 * s, LINE_COLOR)
			# Eyebrows: raised, enthusiastic
			draw_arc(hc + Vector2(-6, -5) * s, 4 * s, PI + 0.4, TAU - 0.4, 8, LINE_COLOR, 1.2, true)
			draw_arc(hc + Vector2(6, -5) * s, 4 * s, PI + 0.4, TAU - 0.4, 8, LINE_COLOR, 1.2, true)
			# Open smile
			draw_arc(hc + Vector2(0, 7) * s, 5 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.3, true)

		Emotion.HAPPY:
			# Huge grin, squinting eyes
			_draw_line_seg(hc + Vector2(-7, 0) * s, hc + Vector2(-2, 1) * s, 1.8)
			_draw_line_seg(hc + Vector2(2, 1) * s, hc + Vector2(7, 0) * s, 1.8)
			# Eyebrows happy
			draw_arc(hc + Vector2(-6, -5) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.3, true)
			draw_arc(hc + Vector2(6, -5) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.3, true)
			# Big smile
			draw_arc(hc + Vector2(0, 6) * s, 6 * s, 0.1, PI - 0.1, 14, LINE_COLOR, 1.5, true)

		Emotion.ANGRY:
			# Confused hurt look — not angry, but confused and hurt
			draw_circle(hc + Vector2(-6, 0) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(6, 0) * s, 1.8 * s, LINE_COLOR)
			# Confused eyebrows (one raised, one down)
			draw_arc(hc + Vector2(-6, -5) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.2, true)
			_draw_line_seg(hc + Vector2(3, -6) * s, hc + Vector2(10, -5) * s, 1.8)
			# Confused mouth (slight frown)
			draw_arc(hc + Vector2(0, 8) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.0, true)

		Emotion.SCARED:
			# Lost, vulnerable eyes
			_draw_circle_outline(hc + Vector2(-6, 0) * s, 3.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(-6, 1) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(6, 0) * s, 3.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(6, 1) * s, 1.5 * s, LINE_COLOR)
			# Scared eyebrows (raised)
			draw_arc(hc + Vector2(-6, -5) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.0, true)
			draw_arc(hc + Vector2(6, -5) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.0, true)
			# Open mouth (shock)
			_draw_circle_outline(hc + Vector2(0, 9) * s, 3 * s, 1.2)

		Emotion.SPECIAL:
			# Glazed eyes — fully converted, eerie calm
			# Eyes become large, vacant circles with pinpoint pupils
			_draw_circle_outline(hc + Vector2(-6, 0) * s, 4.0 * s, 1.8)
			draw_circle(hc + Vector2(-6, 0) * s, 2.5 * s, Color(TEAL.r, TEAL.g, TEAL.b, 0.3))
			draw_circle(hc + Vector2(-6, 0) * s, 0.8 * s, LINE_COLOR)

			_draw_circle_outline(hc + Vector2(6, 0) * s, 4.0 * s, 1.8)
			draw_circle(hc + Vector2(6, 0) * s, 2.5 * s, Color(TEAL.r, TEAL.g, TEAL.b, 0.3))
			draw_circle(hc + Vector2(6, 0) * s, 0.8 * s, LINE_COLOR)

			# Eyebrows: smooth, serene (impossible to read)
			draw_arc(hc + Vector2(-6, -5) * s, 4 * s, PI + 0.2, TAU - 0.2, 8, LINE_COLOR, 1.0, true)
			draw_arc(hc + Vector2(6, -5) * s, 4 * s, PI + 0.2, TAU - 0.2, 8, LINE_COLOR, 1.0, true)

			# Eerie smile (serene, detached)
			draw_arc(hc + Vector2(0, 6) * s, 5 * s, 0.3, PI - 0.3, 10, LINE_COLOR, 1.2, true)

func _draw_arms_default(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Default: eager forward lean, hands at sides
	var elbow_l = sh_l + Vector2(-4, 22) * s
	var hand_l = elbow_l + Vector2(-2, 16) * s
	_draw_line_seg(sh_l, elbow_l, 2.6)
	_draw_line_seg(elbow_l, hand_l, 2.4)

	var elbow_r = sh_r + Vector2(4, 22) * s
	var hand_r = elbow_r + Vector2(2, 16) * s
	_draw_line_seg(sh_r, elbow_r, 2.6)
	_draw_line_seg(elbow_r, hand_r, 2.4)

func _draw_arms_confused(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Confused: one hand up (questioning), one down
	var elbow_l = sh_l + Vector2(-8, 12) * s
	var hand_l = elbow_l + Vector2(-4, -8) * s  # up
	_draw_line_seg(sh_l, elbow_l, 2.6)
	_draw_line_seg(elbow_l, hand_l, 2.4)

	var elbow_r = sh_r + Vector2(8, 24) * s
	var hand_r = elbow_r + Vector2(2, 16) * s  # down
	_draw_line_seg(sh_r, elbow_r, 2.6)
	_draw_line_seg(elbow_r, hand_r, 2.4)

func _draw_arms_lost(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Lost/scared: both arms down, helpless
	var elbow_l = sh_l + Vector2(-2, 24) * s
	var hand_l = elbow_l + Vector2(-2, 14) * s
	_draw_line_seg(sh_l, elbow_l, 2.4)
	_draw_line_seg(elbow_l, hand_l, 2.2)

	var elbow_r = sh_r + Vector2(2, 24) * s
	var hand_r = elbow_r + Vector2(2, 14) * s
	_draw_line_seg(sh_r, elbow_r, 2.4)
	_draw_line_seg(elbow_r, hand_r, 2.2)

func _draw_arms_converted(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Fully converted: arms in prayer/meditation pose at chest
	var hands_center = o + Vector2(0, -48) * s

	var elbow_l = sh_l + Vector2(-6, 16) * s
	_draw_line_seg(sh_l, elbow_l, 2.4)
	_draw_line_seg(elbow_l, hands_center + Vector2(-3, -4) * s, 2.2)

	var elbow_r = sh_r + Vector2(6, 16) * s
	_draw_line_seg(sh_r, elbow_r, 2.4)
	_draw_line_seg(elbow_r, hands_center + Vector2(3, -4) * s, 2.2)

	# Hands pressed together in prayer pose
	_draw_line_seg(hands_center + Vector2(-3, -8) * s, hands_center + Vector2(-3, 4) * s, 2.0)
	_draw_line_seg(hands_center + Vector2(3, -8) * s, hands_center + Vector2(3, 4) * s, 2.0)
