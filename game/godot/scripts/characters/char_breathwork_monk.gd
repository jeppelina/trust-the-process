extends StickCharacter
class_name CharBreathworkMonk
## Breathwork Monk. Wide triangle base, immovable mountain. No mouth.
## Signature: huge staring eyes, topknot, visible breath wisps, voluminous robes.

func _ready() -> void:
	accent_color = Color(0.42, 0.60, 0.83)  # calm blue
	character_id = "breathwork_monk"
	display_name = "Breathwork Monk"
	# Idle: slow breathing expansion
	_breath_scale = 1.5
	_breath_speed = 0.8
	_bob_amplitude = 0.3
	_bob_speed = 0.8
	super._ready()

const BLUE := Color(0.42, 0.60, 0.83)
const BLUE_DIM := Color(0.42, 0.60, 0.83, 0.4)

func _draw_character(origin: Vector2, sc: float, breath: float, _lean: float) -> void:
	var o = origin
	var s = sc
	var br = breath  # breathing offset

	# ── Sandals (just visible under robes) ──
	_draw_line_seg(o + Vector2(-18, 0) * s, o + Vector2(-12, -4) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(-15, 0) * s, o + Vector2(-15, -5) * s, HAIR_LINE)
	_draw_line_seg(o + Vector2(18, 0) * s, o + Vector2(12, -4) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(15, 0) * s, o + Vector2(15, -5) * s, HAIR_LINE)

	# ── Robe: wide triangular shape (breathes) ──
	var robe_top = o + Vector2(0, -80) * s
	var robe_bl = o + Vector2(-32 - br, -2) * s
	var robe_br = o + Vector2(32 + br, -2) * s
	var robe_pts = PackedVector2Array([
		robe_top + Vector2(-16, 4) * s,
		robe_bl,
		robe_bl + Vector2(12, 0) * s,
		o + Vector2(0, -6) * s,
		robe_br + Vector2(-12, 0) * s,
		robe_br,
		robe_top + Vector2(16, 4) * s,
	])
	draw_polyline(robe_pts, LINE_COLOR, LINE_WIDTH, true)

	# Robe center line
	_draw_line_seg(robe_top, o + Vector2(0, -6) * s, THIN_LINE, BLUE_DIM)

	# Robe side detail lines
	draw_polyline(PackedVector2Array([
		robe_top + Vector2(-10, 6) * s,
		o + Vector2(-20 - br * 0.5, -4) * s,
	]), BLUE_DIM, HAIR_LINE, true)
	draw_polyline(PackedVector2Array([
		robe_top + Vector2(10, 6) * s,
		o + Vector2(20 + br * 0.5, -4) * s,
	]), BLUE_DIM, HAIR_LINE, true)

	# Collar wrap
	draw_arc(robe_top + Vector2(0, 6) * s, 14 * s, 0.2, PI - 0.2, 16, Color(BLUE, 0.6), 2.0, true)

	# ── Hands: fingertips emerging from robe ──
	var hand_l = o + Vector2(-30 - br, -34) * s
	draw_polyline(PackedVector2Array([
		hand_l + Vector2(6, 2) * s, hand_l, hand_l + Vector2(-2, -2) * s,
		hand_l + Vector2(0, 2) * s, hand_l + Vector2(6, 2) * s,
	]), LINE_COLOR, THIN_LINE, true)
	var hand_r = o + Vector2(30 + br, -34) * s
	draw_polyline(PackedVector2Array([
		hand_r + Vector2(-6, 2) * s, hand_r, hand_r + Vector2(2, -2) * s,
		hand_r + Vector2(0, 2) * s, hand_r + Vector2(-6, 2) * s,
	]), LINE_COLOR, THIN_LINE, true)

	# ── Neck: thick, short ──
	var neck_top = robe_top + Vector2(0, -8) * s
	_draw_line_seg(robe_top, neck_top, 3.0)

	# ── Head: big, round, bald ──
	var hc = neck_top + Vector2(0, -18) * s
	_draw_circle_outline(hc, 18 * s)

	# ── Topknot ──
	draw_polyline(PackedVector2Array([
		hc + Vector2(-5, -17) * s,
		hc + Vector2(-3, -26) * s,
		hc + Vector2(3, -26) * s,
		hc + Vector2(5, -17) * s,
	]), LINE_COLOR, 2.5, true)
	_draw_circle_outline(hc + Vector2(0, -29) * s, 3 * s, THIN_LINE)

	# ── Face ──
	_draw_face(hc, s)

	# ── Breath wisps ──
	_draw_breath(hc, s)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Large unblinking staring eyes
			_draw_circle_outline(hc + Vector2(-7, -1) * s, 5 * s, 1.8)
			draw_circle(hc + Vector2(-7, -1) * s, 2.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(7, -1) * s, 5 * s, 1.8)
			draw_circle(hc + Vector2(7, -1) * s, 2.5 * s, LINE_COLOR)
			# No mouth — just the ghost of a line
			_draw_line_seg(hc + Vector2(-4, 8) * s, hc + Vector2(4, 8) * s, 0.5, BG_DIM)

		Emotion.HAPPY:
			# Eyes soften slightly
			draw_arc(hc + Vector2(-7, 0) * s, 4 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, 1.8, true)
			draw_arc(hc + Vector2(7, 0) * s, 4 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, 1.8, true)
			# Still no mouth, but a slightly visible curve
			draw_arc(hc + Vector2(0, 6) * s, 4 * s, 0.3, PI - 0.3, 8, BG_DIM, 0.8, true)

		Emotion.ANGRY:
			# Eyes EVEN BIGGER, furious
			_draw_circle_outline(hc + Vector2(-7, -1) * s, 6 * s, 2.0)
			draw_circle(hc + Vector2(-7, -1) * s, 3 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(7, -1) * s, 6 * s, 2.0)
			draw_circle(hc + Vector2(7, -1) * s, 3 * s, LINE_COLOR)
			# Angry brows
			_draw_line_seg(hc + Vector2(-13, -6) * s, hc + Vector2(-3, -8) * s, 2.0)
			_draw_line_seg(hc + Vector2(3, -8) * s, hc + Vector2(13, -6) * s, 2.0)
			# Mouth appears: force exhale
			_draw_circle_outline(hc + Vector2(0, 9) * s, 4 * s, 2.0)

		Emotion.SCARED:
			# Eyes wobble (pupils off-center)
			_draw_circle_outline(hc + Vector2(-7, -1) * s, 5 * s, 1.5)
			draw_circle(hc + Vector2(-8, 0) * s, 2 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(7, -1) * s, 5 * s, 1.5)
			draw_circle(hc + Vector2(6, 0) * s, 2 * s, LINE_COLOR)
			# Ghost mouth appears
			_draw_line_seg(hc + Vector2(-3, 9) * s, hc + Vector2(3, 9) * s, 1.0, DIM_COLOR)

		Emotion.SPECIAL:
			# Meditative — eyes become concentric circles
			for i in 3:
				var r = (2.0 + i * 2.5) * s
				var alpha = 1.0 - i * 0.3
				_draw_circle_outline(hc + Vector2(-7, -1) * s, r, 1.2, Color(BLUE.r, BLUE.g, BLUE.b, alpha))
				_draw_circle_outline(hc + Vector2(7, -1) * s, r, 1.2, Color(BLUE.r, BLUE.g, BLUE.b, alpha))

func _draw_breath(hc: Vector2, s: float) -> void:
	# Breath wisps flow left from face area
	var mouth = hc + Vector2(-4, 9) * s
	var breath_alpha_base = 0.5
	var num_wisps = 3
	if expression == Emotion.ANGRY:
		num_wisps = 5
		breath_alpha_base = 0.7

	for i in num_wisps:
		var t = _idle_time * 0.6 + i * 0.8
		var wave_x = -10.0 - i * 12.0
		var wave_y = sin(t) * 4.0
		var alpha = breath_alpha_base - i * 0.12
		var width = (2.5 - i * 0.4) if expression == Emotion.ANGRY else (1.5 - i * 0.3)
		width = maxf(width, 0.5)
		alpha = maxf(alpha, 0.1)
		var color = Color(BLUE.r, BLUE.g, BLUE.b, alpha)
		draw_arc(
			mouth + Vector2(wave_x, wave_y) * s,
			(6 + i * 3) * s,
			-0.6, 0.6, 8, color, width * s / s, true
		)
