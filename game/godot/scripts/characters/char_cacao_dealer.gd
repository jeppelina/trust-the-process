extends StickCharacter
class_name CharCacaoDealer
## Cacao Dealer. Hunched, diagonal lines, trench coat. Always leaning in.
## Signature: beanie pulled low, hidden eyes, trench coat full of beans.

func _ready() -> void:
	accent_color = Color(0.54, 0.83, 0.42)  # lime green (beanie)
	character_id = "cacao_dealer"
	display_name = "Cacao Dealer"
	# Idle: slight lean-and-return
	_lean_amplitude = 1.5
	_lean_speed = 1.2
	_sway_amplitude = 0.6
	_sway_speed = 1.8
	_bob_amplitude = 0.4
	_bob_speed = 2.0
	super._ready()

const GREEN := Color(0.54, 0.83, 0.42)
const GOLD := Color(0.83, 0.64, 0.29)
const BEAN_BROWN := Color(0.42, 0.23, 0.12)
const COAT_COLOR := Color(0.53, 0.47, 0.33, 0.7)

func _draw_character(origin: Vector2, sc: float, _breath: float, lean: float) -> void:
	var o = origin
	var s = sc
	var ln = lean  # lean offset

	# ── Boots ──
	_draw_line_seg(o + Vector2(-12, 0) * s, o + Vector2(-18, -2) * s, 2.5)
	_draw_line_seg(o + Vector2(12, 0) * s, o + Vector2(18, -2) * s, 2.5)
	# Boot tops
	_draw_line_seg(o + Vector2(-14, -2) * s, o + Vector2(-14, -10) * s, 2.0)
	_draw_line_seg(o + Vector2(14, -2) * s, o + Vector2(14, -10) * s, 2.0)

	# ── Legs (under coat, barely visible) ──
	_draw_line_seg(o + Vector2(-14, -10) * s, o + Vector2(-8, -42) * s, 2.0)
	_draw_line_seg(o + Vector2(14, -10) * s, o + Vector2(8, -42) * s, 2.0)

	# ── TRENCH COAT ──
	var coat_top_l = o + Vector2(-18 + ln, -82) * s
	var coat_top_r = o + Vector2(16 + ln, -82) * s
	var coat_bot_l = o + Vector2(-24, -6) * s
	var coat_bot_r = o + Vector2(24, -6) * s

	# Coat outline
	draw_polyline(PackedVector2Array([
		coat_top_l, coat_bot_l, coat_bot_r, coat_top_r
	]), COAT_COLOR, 2.0, true)

	# Coat lapels
	draw_polyline(PackedVector2Array([
		coat_top_l + Vector2(6, 2) * s,
		o + Vector2(-6 + ln, -62) * s,
		o + Vector2(-1 + ln, -80) * s,
	]), COAT_COLOR, 1.8, true)
	draw_polyline(PackedVector2Array([
		coat_top_r + Vector2(-6, 2) * s,
		o + Vector2(6 + ln, -62) * s,
		o + Vector2(1 + ln, -80) * s,
	]), COAT_COLOR, 1.8, true)

	# Coat opening with dark interior
	var inner_pts = PackedVector2Array([
		o + Vector2(-6 + ln, -62) * s,
		o + Vector2(-5, -10) * s,
		o + Vector2(5, -10) * s,
		o + Vector2(6 + ln, -62) * s,
	])
	draw_colored_polygon(inner_pts, Color(0.08, 0.07, 0.05))

	# ── Cacao beans inside coat ──
	for i in 4:
		var bx = o.x + (-3 + (i % 2) * 6 + ln * 0.5) * s
		var by = o.y + (-55 + i * 12) * s
		var rot = (-0.3 + i * 0.2)
		var alpha = 0.9 - i * 0.15
		_draw_bean(Vector2(bx, by), s, rot, alpha)

	# ── Shoulders: uneven, hunched ──
	var shoulder = o + Vector2(ln, -82) * s
	draw_polyline(PackedVector2Array([
		coat_top_l,
		shoulder + Vector2(-4, -3) * s,
		shoulder + Vector2(4, -5) * s,
		coat_top_r,
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms ──
	match expression:
		Emotion.HAPPY, Emotion.SPECIAL:
			_draw_arms_rubbing(o, s, coat_top_l, coat_top_r, ln)
		_:
			_draw_arms_offering(o, s, coat_top_l, coat_top_r, ln)

	# ── Neck: thin, angled forward ──
	var neck_base = shoulder + Vector2(0, -3) * s
	var neck_top = neck_base + Vector2(ln * 0.5, -8) * s
	_draw_line_seg(neck_base, neck_top, 2.0)

	# ── Head: thin, angular ──
	var hc = neck_top + Vector2(ln * 0.3, -14) * s
	var head_pts := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		head_pts.append(hc + Vector2(cos(angle) * 12, sin(angle) * 14) * s)
	draw_polyline(head_pts, LINE_COLOR, LINE_WIDTH, true)

	# ── Beanie: pulled LOW ──
	var beanie_bottom = hc + Vector2(0, -4) * s
	draw_arc(beanie_bottom, 14 * s, PI + 0.1, TAU - 0.1, 16, GREEN, 2.5, true)
	# Beanie dome
	draw_polyline(PackedVector2Array([
		beanie_bottom + Vector2(-14, 0) * s,
		hc + Vector2(-13, -10) * s,
		hc + Vector2(0, -18) * s,
		hc + Vector2(13, -10) * s,
		beanie_bottom + Vector2(14, 0) * s,
	]), GREEN, 2.5, true)
	# Shadow under brim
	_draw_line_seg(hc + Vector2(-13, -3) * s, hc + Vector2(13, -3) * s, 3.0, Color(0.05, 0.05, 0.03, 0.5))

	# ── Face ──
	_draw_face(hc, s)

	# ── Whisper text ──
	if expression == Emotion.NEUTRAL:
		var whisper_alpha = 0.4 + sin(_idle_time * 1.5) * 0.2
		# Draw "psst" as small dots (can't draw text in _draw, so we use dots)
		for i in 3:
			draw_circle(
				hc + Vector2(20 + i * 4, 2 + sin(_idle_time * 2 + i) * 2) * s,
				1.0 * s,
				Color(DIM_COLOR, whisper_alpha)
			)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Eyes: barely visible slits under hat
			_draw_line_seg(hc + Vector2(-7, 1) * s, hc + Vector2(-3, 1) * s, 2.0)
			_draw_line_seg(hc + Vector2(3, 1) * s, hc + Vector2(7, 1) * s, 2.0)
			# Smirk: one-sided
			draw_polyline(PackedVector2Array([
				hc + Vector2(-2, 8) * s,
				hc + Vector2(4, 9) * s,
				hc + Vector2(8, 7) * s,
			]), LINE_COLOR, THIN_LINE, true)
			# Stubble dots
			for i in 4:
				draw_circle(hc + Vector2(-3 + i * 3, 11 + (i % 2)) * s, 0.6 * s, DIM_COLOR)

		Emotion.HAPPY:
			# Satisfied squinty eyes
			draw_arc(hc + Vector2(-5, 1) * s, 3 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, THIN_LINE, true)
			draw_arc(hc + Vector2(5, 1) * s, 3 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, THIN_LINE, true)
			# Wide grin with teeth
			draw_arc(hc + Vector2(1, 6) * s, 7 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.5, true)
			for i in 3:
				var tx = hc.x + (-3 + i * 3) * s
				_draw_line_seg(Vector2(tx, hc.y + 7 * s), Vector2(tx, hc.y + 9 * s), 0.8)
			# Stubble
			for i in 4:
				draw_circle(hc + Vector2(-3 + i * 3, 12 + (i % 2)) * s, 0.6 * s, DIM_COLOR)

		Emotion.ANGRY:
			# Eyes visible and glaring
			draw_circle(hc + Vector2(-5, 1) * s, 2 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, 1) * s, 2 * s, LINE_COLOR)
			# Angry brows through hat shadow
			_draw_line_seg(hc + Vector2(-9, -2) * s, hc + Vector2(-2, -4) * s, 2.0)
			_draw_line_seg(hc + Vector2(2, -4) * s, hc + Vector2(9, -2) * s, 2.0)
			# Snarl
			draw_polyline(PackedVector2Array([
				hc + Vector2(-4, 8) * s, hc + Vector2(0, 10) * s, hc + Vector2(4, 7) * s
			]), LINE_COLOR, 1.5, true)

		Emotion.SCARED:
			# Hat lifts slightly (brows push it up)
			_draw_circle_outline(hc + Vector2(-5, 1) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(-5, 2) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(5, 1) * s, 3 * s, THIN_LINE)
			draw_circle(hc + Vector2(5, 2) * s, 1.5 * s, LINE_COLOR)
			# Grimace
			_draw_line_seg(hc + Vector2(-4, 8) * s, hc + Vector2(4, 8) * s, 1.3)

		Emotion.SPECIAL:
			# Money eyes
			_draw_line_seg(hc + Vector2(-7, -1) * s, hc + Vector2(-3, 3) * s, 1.5, GOLD)
			_draw_line_seg(hc + Vector2(-3, -1) * s, hc + Vector2(-7, 3) * s, 1.5, GOLD)
			_draw_line_seg(hc + Vector2(3, -1) * s, hc + Vector2(7, 3) * s, 1.5, GOLD)
			_draw_line_seg(hc + Vector2(7, -1) * s, hc + Vector2(3, 3) * s, 1.5, GOLD)
			# Big grin
			draw_arc(hc + Vector2(1, 6) * s, 7 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.5, true)

func _draw_arms_offering(o: Vector2, s: float, ct_l: Vector2, ct_r: Vector2, ln: float) -> void:
	# Left arm: holding coat open
	var elbow_l = ct_l + Vector2(-6, 18) * s
	var hand_l = elbow_l + Vector2(2, 14) * s
	_draw_line_seg(ct_l, elbow_l)
	_draw_line_seg(elbow_l, hand_l)

	# Right arm: beckoning
	var elbow_r = ct_r + Vector2(8, 12) * s
	var hand_r = elbow_r + Vector2(4, 6) * s
	_draw_line_seg(ct_r, elbow_r)
	_draw_line_seg(elbow_r, hand_r)
	# Beckoning fingers
	_draw_line_seg(hand_r, hand_r + Vector2(4, -3) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(5, 0) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(3, 3) * s, HAIR_LINE)

func _draw_arms_rubbing(o: Vector2, s: float, ct_l: Vector2, ct_r: Vector2, ln: float) -> void:
	# Both arms brought together, rubbing hands
	var mid = o + Vector2(ln * 0.5, -62) * s
	_draw_line_seg(ct_l, ct_l + Vector2(4, 10) * s)
	_draw_line_seg(ct_l + Vector2(4, 10) * s, mid + Vector2(-6, 0) * s)
	_draw_line_seg(ct_r, ct_r + Vector2(-4, 10) * s)
	_draw_line_seg(ct_r + Vector2(-4, 10) * s, mid + Vector2(6, 0) * s)
	# Hands blob
	_draw_circle_outline(mid, 6 * s, 2.0)

func _draw_bean(pos: Vector2, s: float, rot: float, alpha: float) -> void:
	# A cacao bean shape
	var color = Color(GOLD, alpha)
	var fill = Color(BEAN_BROWN, alpha)
	# Oval
	var pts := PackedVector2Array()
	for i in 17:
		var angle = float(i) / 16.0 * TAU
		var rx = 5.0 * s
		var ry = 3.5 * s
		var p = Vector2(cos(angle) * rx, sin(angle) * ry)
		# Rotate
		var c = cos(rot)
		var sn = sin(rot)
		pts.append(pos + Vector2(p.x * c - p.y * sn, p.x * sn + p.y * c))
	draw_colored_polygon(pts, fill)
	draw_polyline(pts, color, 1.0, true)
	# Center line
	var c = cos(rot)
	var sn = sin(rot)
	var line_start = pos + Vector2(-3 * s * c, -3 * s * sn)
	var line_end = pos + Vector2(3 * s * c, 3 * s * sn)
	_draw_line_seg(line_start, line_end, 0.8, color)
