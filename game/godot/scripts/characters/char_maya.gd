extends StickCharacter
class_name CharMaya
## Maya the Skeptical Barista. Hunched, guarded, tired but restless energy.
## Signature: messy bun, stained apron, rolled-up sleeves, bags under eyes, arms-crossed default.
## She's seen the whole spiritual bypass pipeline firsthand and is NOT impressed.

func _ready() -> void:
	accent_color = Color(0.72, 0.42, 0.30)  # warm terracotta
	character_id = "maya"
	display_name = "Maya"
	# Idle: slight sway, tired but restless energy
	_sway_amplitude = 1.2
	_sway_speed = 2.0
	_bob_amplitude = 0.6
	_bob_speed = 1.8
	custom_minimum_size = Vector2(130, 150)
	super._ready()

const TERRACOTTA := Color(0.72, 0.42, 0.30)
const APRON_COLOR := Color(0.85, 0.80, 0.72)

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Slip-on shoes (minimal) ──
	_draw_line_seg(o + Vector2(-14, 0) * s, o + Vector2(-10, -2) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(14, 0) * s, o + Vector2(10, -2) * s, THIN_LINE)

	# ── Legs (visible, tired stance) ──
	var hip = o + Vector2(0, -48) * s
	_draw_line_seg(o + Vector2(-14, 0) * s, hip + Vector2(-7, 0) * s, 2.2)
	_draw_line_seg(o + Vector2(14, 0) * s, hip + Vector2(7, 0) * s, 2.2)

	# ── Apron (stained, worn) ──
	_draw_apron(o, hip, s)

	# ── Torso ──
	var shoulder = o + Vector2(0, -88) * s
	_draw_line_seg(hip, shoulder, 2.8)

	# ── Rolled-up sleeves visual indicator ──
	var sleeve_l = shoulder + Vector2(-22, 2) * s
	var sleeve_r = shoulder + Vector2(22, 2) * s
	_draw_line_seg(sleeve_l + Vector2(2, -4) * s, sleeve_l + Vector2(2, 4) * s, 2.2, TERRACOTTA)
	_draw_line_seg(sleeve_r + Vector2(-2, -4) * s, sleeve_r + Vector2(-2, 4) * s, 2.2, TERRACOTTA)

	# ── Shoulders ──
	draw_polyline(PackedVector2Array([
		shoulder + Vector2(-22, 0) * s,
		shoulder + Vector2(-8, -2) * s,
		shoulder + Vector2(8, -2) * s,
		shoulder + Vector2(22, 0) * s
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms: default crossed, or expression-dependent ──
	match expression:
		Emotion.HAPPY:
			_draw_arms_uncrossed(o, s, shoulder)
		Emotion.SCARED:
			_draw_arms_hugged(o, s, shoulder)
		_:
			_draw_arms_crossed(o, s, shoulder)

	# ── Neck ──
	var neck_base = shoulder + Vector2(0, -2) * s
	var neck_top = shoulder + Vector2(0, -10) * s
	_draw_line_seg(neck_base, neck_top, 2.0)

	# ── Head ──
	var head_center = neck_top + Vector2(0, -18) * s
	var head_rx = 14.0 * s
	var head_ry = 16.0 * s
	_draw_head_oval(head_center, head_rx, head_ry)

	# ── Messy bun (slightly askew) ──
	var bun_top = head_center + Vector2(2, -18) * s
	_draw_line_seg(head_center + Vector2(-6, -12) * s, bun_top + Vector2(-2, 0) * s, 1.8)
	_draw_line_seg(head_center + Vector2(6, -12) * s, bun_top + Vector2(2, 0) * s, 1.8)
	_draw_circle_outline(bun_top, 4.5 * s, THIN_LINE)
	# Hair tie (loose)
	draw_arc(bun_top + Vector2(0, 5) * s, 3.5 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, HAIR_LINE, true)

	# ── Face ──
	_draw_face(head_center, s)

func _draw_apron(o: Vector2, hip: Vector2, s: float) -> void:
	# Apron outline (trapezoid hanging from shoulder area)
	var apron_top = hip + Vector2(0, -2) * s
	var apron_bottom = o + Vector2(0, 0) * s
	var apron_pts = PackedVector2Array([
		apron_top + Vector2(-14, 0) * s,
		apron_bottom + Vector2(-20, 0) * s,
		apron_bottom + Vector2(20, 0) * s,
		apron_top + Vector2(14, 0) * s,
	])
	draw_polyline(apron_pts, APRON_COLOR, 2.0, true)

	# Apron stains (random worn spots)
	var stains = [
		hip + Vector2(-8, 8) * s,
		hip + Vector2(6, 12) * s,
		hip + Vector2(-4, 18) * s,
		hip + Vector2(12, 14) * s,
	]
	for stain_pos in stains:
		draw_circle(stain_pos, 2.5 * s, Color(0.65, 0.55, 0.45, 0.5))

func _draw_head_oval(center: Vector2, rx: float, ry: float) -> void:
	var points := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		points.append(center + Vector2(cos(angle) * rx, sin(angle) * ry))
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Skeptical narrowed eyes, slight frown
			_draw_line_seg(hc + Vector2(-7, -1) * s, hc + Vector2(-2, 0) * s, 2.0)
			_draw_line_seg(hc + Vector2(2, 0) * s, hc + Vector2(7, -1) * s, 2.0)
			# Small pupils looking to the side (judging)
			draw_circle(hc + Vector2(-5, 0) * s, 1.5 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, 0) * s, 1.5 * s, LINE_COLOR)
			# Eyebrows: skeptical arch
			_draw_line_seg(hc + Vector2(-9, -5) * s, hc + Vector2(-2, -4) * s, 1.8)
			_draw_line_seg(hc + Vector2(2, -4) * s, hc + Vector2(9, -5) * s, 1.8)
			# Bags under eyes (tired)
			draw_polyline(PackedVector2Array([
				hc + Vector2(-6, 3) * s, hc + Vector2(-6, 5) * s
			]), DIM_COLOR, 1.2, true)
			draw_polyline(PackedVector2Array([
				hc + Vector2(6, 3) * s, hc + Vector2(6, 5) * s
			]), DIM_COLOR, 1.2, true)
			# Mouth: slight frown
			draw_arc(hc + Vector2(0, 8) * s, 4 * s, PI + 0.2, TAU - 0.2, 8, LINE_COLOR, 1.2, true)

		Emotion.HAPPY:
			# Surprised warm smile — rare, genuine moment
			draw_circle(hc + Vector2(-5, 0) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, 0) * s, 1.8 * s, LINE_COLOR)
			# Eyebrows lifted (surprised)
			draw_arc(hc + Vector2(-5, -5) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.2, true)
			draw_arc(hc + Vector2(5, -5) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.2, true)
			# Genuine smile
			draw_arc(hc + Vector2(0, 7) * s, 5 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.3, true)

		Emotion.ANGRY:
			# Jaw clenched, eyes blazing
			draw_circle(hc + Vector2(-5, -1) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, -1) * s, 1.8 * s, LINE_COLOR)
			# Angry angled brows
			_draw_line_seg(hc + Vector2(-10, -3) * s, hc + Vector2(-2, -6) * s, 2.2)
			_draw_line_seg(hc + Vector2(2, -6) * s, hc + Vector2(10, -3) * s, 2.2)
			# Mouth: tight line (jaw clenched)
			_draw_line_seg(hc + Vector2(-5, 9) * s, hc + Vector2(5, 9) * s, 2.0)
			# Tension marks
			_draw_line_seg(hc + Vector2(-8, 10) * s, hc + Vector2(-6, 12) * s, HAIR_LINE)
			_draw_line_seg(hc + Vector2(8, 10) * s, hc + Vector2(6, 12) * s, HAIR_LINE)

		Emotion.SCARED:
			# Arms tighter, wide eyes, vulnerable
			draw_circle(hc + Vector2(-5, 0) * s, 2.0 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, 0) * s, 2.0 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(-5, 0) * s, 3.0 * s, 1.0)
			_draw_circle_outline(hc + Vector2(5, 0) * s, 3.0 * s, 1.0)
			# Raised worried brows
			draw_arc(hc + Vector2(-5, -5) * s, 4 * s, PI + 0.4, TAU - 0.4, 8, LINE_COLOR, 1.2, true)
			draw_arc(hc + Vector2(5, -5) * s, 4 * s, PI + 0.4, TAU - 0.4, 8, LINE_COLOR, 1.2, true)
			# Open mouth (shock)
			_draw_circle_outline(hc + Vector2(0, 9) * s, 3 * s, 1.2)

		Emotion.SPECIAL:
			# Arms uncross — moment of trust/vulnerability
			draw_circle(hc + Vector2(-5, 0) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, 0) * s, 1.8 * s, LINE_COLOR)
			# Eyebrows slightly raised (opening up)
			draw_arc(hc + Vector2(-5, -5) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.3, true)
			draw_arc(hc + Vector2(5, -5) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.3, true)
			# Soft smile (rare)
			draw_arc(hc + Vector2(0, 7) * s, 4 * s, 0.3, PI - 0.3, 10, LINE_COLOR, 1.0, true)

func _draw_arms_crossed(o: Vector2, s: float, shoulder: Vector2) -> void:
	# Default: arms crossed defensively
	var elbow_l = shoulder + Vector2(-18, 18) * s
	var hand_l = elbow_l + Vector2(6, 6) * s
	_draw_line_seg(shoulder + Vector2(-22, 0) * s, elbow_l, 2.6)
	_draw_line_seg(elbow_l, hand_l, 2.4)

	var elbow_r = shoulder + Vector2(18, 16) * s
	var hand_r = elbow_r + Vector2(-6, 8) * s
	_draw_line_seg(shoulder + Vector2(22, 0) * s, elbow_r, 2.6)
	_draw_line_seg(elbow_r, hand_r, 2.4)

func _draw_arms_uncrossed(o: Vector2, s: float, shoulder: Vector2) -> void:
	# Happy/trusting: arms down, more open posture
	var elbow_l = shoulder + Vector2(-12, 22) * s
	var hand_l = elbow_l + Vector2(-2, 16) * s
	_draw_line_seg(shoulder + Vector2(-22, 0) * s, elbow_l, 2.4)
	_draw_line_seg(elbow_l, hand_l, 2.2)

	var elbow_r = shoulder + Vector2(12, 22) * s
	var hand_r = elbow_r + Vector2(2, 16) * s
	_draw_line_seg(shoulder + Vector2(22, 0) * s, elbow_r, 2.4)
	_draw_line_seg(elbow_r, hand_r, 2.2)

func _draw_arms_hugged(o: Vector2, s: float, shoulder: Vector2) -> void:
	# Scared: arms hugging self
	var hug_center = o + Vector2(0, -50) * s

	var elbow_l = shoulder + Vector2(-14, 14) * s
	var hand_l = hug_center + Vector2(-10, 0) * s
	_draw_line_seg(shoulder + Vector2(-22, 0) * s, elbow_l, 2.4)
	_draw_line_seg(elbow_l, hand_l, 2.2)

	var elbow_r = shoulder + Vector2(14, 12) * s
	var hand_r = hug_center + Vector2(10, 0) * s
	_draw_line_seg(shoulder + Vector2(22, 0) * s, elbow_r, 2.4)
	_draw_line_seg(elbow_r, hand_r, 2.2)
