extends StickCharacter
class_name CharSteve
## Steve the Accountant. Rigid vertical lines, right angles, nervous energy.
## Signature props: glasses, tie, briefcase.

func _ready() -> void:
	accent_color = Color(0.42, 0.54, 0.42)  # sage green (tie)
	character_id = "steve"
	display_name = "Steve"
	# Idle: nervous lateral sway
	_sway_amplitude = 1.2
	_sway_speed = 2.5
	_bob_amplitude = 0.5
	_bob_speed = 3.0
	super._ready()

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	# origin = bottom center of character
	var o = origin
	# Scale factor for appear animation
	var s = sc

	# ── Feet ──
	var foot_l = o + Vector2(-10, 0) * s
	var foot_r = o + Vector2(10, 0) * s
	_draw_line_seg(foot_l + Vector2(-5, 0) * s, foot_l + Vector2(3, -3) * s)
	_draw_line_seg(foot_r + Vector2(-3, -3) * s, foot_r + Vector2(5, 0) * s)

	# ── Legs ──
	var hip = o + Vector2(0, -50) * s
	var knee_l = o + Vector2(-7, -25) * s
	var knee_r = o + Vector2(7, -25) * s
	_draw_line_seg(foot_l, knee_l, 2.8)
	_draw_line_seg(knee_l, hip + Vector2(-5, 0) * s, 2.8)
	_draw_line_seg(foot_r, knee_r, 2.8)
	_draw_line_seg(knee_r, hip + Vector2(5, 0) * s, 2.8)

	# ── Belt ──
	_draw_line_seg(hip + Vector2(-8, 0) * s, hip + Vector2(8, 0) * s, 2.0, DIM_COLOR)
	# Belt buckle
	draw_rect(Rect2(hip + Vector2(-2, -2.5) * s, Vector2(4, 5) * s), DIM_COLOR, false, 1.0)

	# ── Torso ──
	var shoulder = o + Vector2(0, -82) * s
	_draw_line_seg(hip, shoulder, 2.5)

	# ── Shirt buttons ──
	for i in 3:
		var by = hip.y + (shoulder.y - hip.y) * (0.25 + i * 0.25)
		draw_circle(Vector2(o.x, by), 1.0 * s, DIM_COLOR)

	# ── Tie ──
	var tie_top = shoulder + Vector2(0, 3) * s
	var tie_knot = tie_top + Vector2(0, 5) * s
	var tie_mid = tie_knot + Vector2(0, 22) * s
	var tie_end = tie_mid + Vector2(0, 8) * s
	var tie_color = accent_color
	_draw_line_seg(tie_top, tie_knot, 2.0, tie_color)
	_draw_line_seg(tie_knot, tie_mid, 2.8, tie_color)
	# Tie point
	var pts = PackedVector2Array([
		tie_mid + Vector2(-3, 0) * s,
		tie_mid + Vector2(3, 0) * s,
		tie_end
	])
	draw_colored_polygon(pts, tie_color)

	# ── Shoulders ──
	var sh_l = shoulder + Vector2(-20, 5) * s
	var sh_r = shoulder + Vector2(20, 5) * s
	draw_polyline(PackedVector2Array([sh_l, shoulder + Vector2(-5, -2) * s, shoulder + Vector2(5, -2) * s, sh_r]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms ──
	match expression:
		Emotion.SCARED:
			_draw_arms_shield(o, s, sh_l, sh_r)
		Emotion.ANGRY:
			_draw_arms_fists(o, s, sh_l, sh_r)
		_:
			_draw_arms_default(o, s, sh_l, sh_r)

	# ── Neck ──
	var neck_base = shoulder + Vector2(0, -2) * s
	var neck_top = shoulder + Vector2(0, -10) * s
	_draw_line_seg(neck_base, neck_top, 2.0)

	# ── Head ──
	var head_center = neck_top + Vector2(0, -16) * s
	var head_rx = 14.0 * s
	var head_ry = 16.0 * s
	# Oval head
	_draw_head_oval(head_center, head_rx, head_ry)

	# ── Hair ──
	var hair_pts = PackedVector2Array([
		head_center + Vector2(-14, -8) * s,
		head_center + Vector2(-8, -18) * s,
		head_center + Vector2(-2, -16) * s,
		head_center + Vector2(2, -18) * s,
		head_center + Vector2(10, -16) * s,
		head_center + Vector2(14, -10) * s,
	])
	draw_polyline(hair_pts, LINE_COLOR, 2.0, true)

	# ── Face ──
	_draw_face(head_center, s)

func _draw_face(hc: Vector2, s: float) -> void:
	# ── Glasses (always present) ──
	var gl = hc + Vector2(-9, -2) * s
	var gr = hc + Vector2(2, -2) * s
	draw_rect(Rect2(gl, Vector2(10, 8) * s), LINE_COLOR, false, THIN_LINE)
	draw_rect(Rect2(gr, Vector2(10, 8) * s), LINE_COLOR, false, THIN_LINE)
	_draw_line_seg(gl + Vector2(10, 4) * s, gr + Vector2(0, 4) * s, HAIR_LINE)  # bridge
	_draw_line_seg(gr + Vector2(10, 2) * s, gr + Vector2(14, 0) * s, HAIR_LINE)  # arm

	match expression:
		Emotion.NEUTRAL:
			# Worried dot eyes looking sideways
			draw_circle(hc + Vector2(-5, 1) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(8, 1) * s, 1.8 * s, LINE_COLOR)
			# Eyebrows: slightly raised
			_draw_line_seg(hc + Vector2(-10, -7) * s, hc + Vector2(-2, -6) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(3, -6) * s, hc + Vector2(11, -7) * s, THIN_LINE)
			# Mouth: tight uncomfortable line
			draw_polyline(PackedVector2Array([
				hc + Vector2(-4, 9) * s, hc + Vector2(0, 8) * s, hc + Vector2(4, 9) * s
			]), LINE_COLOR, 1.3, true)

		Emotion.HAPPY:
			# Squinting behind glasses
			_draw_line_seg(hc + Vector2(-7, 1) * s, hc + Vector2(-2, 1) * s, 1.8)
			_draw_line_seg(hc + Vector2(3, 1) * s, hc + Vector2(8, 1) * s, 1.8)
			# Mild smile (rare for Steve)
			draw_arc(hc + Vector2(0, 7) * s, 5 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.3, true)

		Emotion.ANGRY:
			# Small angry eyes
			draw_circle(hc + Vector2(-5, 1) * s, 1.5 * s, LINE_COLOR)
			draw_circle(hc + Vector2(8, 1) * s, 1.5 * s, LINE_COLOR)
			# V-shaped angry brows
			_draw_line_seg(hc + Vector2(-11, -4) * s, hc + Vector2(-2, -7) * s, 2.2)
			_draw_line_seg(hc + Vector2(3, -7) * s, hc + Vector2(12, -4) * s, 2.2)
			# Gritted teeth
			_draw_line_seg(hc + Vector2(-5, 9) * s, hc + Vector2(6, 9) * s, THIN_LINE)
			for i in 3:
				var tx = hc.x + (-3 + i * 3) * s
				_draw_line_seg(Vector2(tx, hc.y + 7.5 * s), Vector2(tx, hc.y + 10.5 * s), 0.8)
			# Anger vein
			draw_polyline(PackedVector2Array([
				hc + Vector2(16, -14) * s, hc + Vector2(19, -18) * s,
				hc + Vector2(17, -12) * s, hc + Vector2(21, -16) * s
			]), LINE_COLOR, THIN_LINE, true)

		Emotion.SCARED:
			# Wide eyes with whites
			_draw_circle_outline(hc + Vector2(-5, 1) * s, 3.0 * s, 1.2)
			draw_circle(hc + Vector2(-5, 2) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(8, 1) * s, 3.0 * s, 1.2)
			draw_circle(hc + Vector2(8, 2) * s, 1.5 * s, LINE_COLOR)
			# Raised arched brows
			draw_arc(hc + Vector2(-5, -5) * s, 6 * s, PI + 0.5, TAU - 0.5, 12, LINE_COLOR, THIN_LINE, true)
			draw_arc(hc + Vector2(8, -5) * s, 6 * s, PI + 0.5, TAU - 0.5, 12, LINE_COLOR, THIN_LINE, true)
			# Grimace
			draw_polyline(PackedVector2Array([
				hc + Vector2(-5, 9) * s, hc + Vector2(0, 11) * s, hc + Vector2(5, 9) * s
			]), LINE_COLOR, 1.3, true)
			_draw_line_seg(hc + Vector2(-5, 9) * s, hc + Vector2(5, 9) * s, 0.8)
			# Sweat drops
			draw_circle(hc + Vector2(-16, 0) * s, 2.0 * s, Color(0.42, 0.60, 0.83, 0.4))

		Emotion.SPECIAL:
			# "Tax season" eyes — spinning spirals implied by circles
			_draw_circle_outline(hc + Vector2(-5, 1) * s, 3.0 * s, 1.5)
			_draw_circle_outline(hc + Vector2(-5, 1) * s, 1.5 * s, 1.0)
			_draw_circle_outline(hc + Vector2(8, 1) * s, 3.0 * s, 1.5)
			_draw_circle_outline(hc + Vector2(8, 1) * s, 1.5 * s, 1.0)
			# Flat mouth
			_draw_line_seg(hc + Vector2(-4, 9) * s, hc + Vector2(5, 9) * s, 1.5)

func _draw_head_oval(center: Vector2, rx: float, ry: float) -> void:
	var points := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		points.append(center + Vector2(cos(angle) * rx, sin(angle) * ry))
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_arms_default(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Left arm hanging
	var elbow_l = sh_l + Vector2(-4, 22) * s
	var hand_l = elbow_l + Vector2(2, 16) * s
	_draw_line_seg(sh_l, elbow_l)
	_draw_line_seg(elbow_l, hand_l)

	# Right arm holding briefcase
	var elbow_r = sh_r + Vector2(4, 20) * s
	var hand_r = elbow_r + Vector2(-2, 18) * s
	_draw_line_seg(sh_r, elbow_r)
	_draw_line_seg(elbow_r, hand_r)

	# Briefcase
	var bc = hand_r + Vector2(-2, 2) * s
	var bc_color = Color(0.83, 0.64, 0.29)
	draw_rect(Rect2(bc, Vector2(20, 13) * s), bc_color, false, 2.0)
	# Handle
	_draw_line_seg(bc + Vector2(6, 0) * s, bc + Vector2(6, -4) * s, THIN_LINE, bc_color)
	_draw_line_seg(bc + Vector2(14, 0) * s, bc + Vector2(14, -4) * s, THIN_LINE, bc_color)
	_draw_line_seg(bc + Vector2(6, -4) * s, bc + Vector2(14, -4) * s, THIN_LINE, bc_color)
	# Clasp
	draw_circle(bc + Vector2(10, 6.5) * s, 1.5 * s, bc_color)

func _draw_arms_shield(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Both arms holding briefcase in front as shield
	var shield_center = o + Vector2(0, -60) * s
	_draw_line_seg(sh_l, shield_center + Vector2(-14, -4) * s)
	_draw_line_seg(sh_r, shield_center + Vector2(14, -4) * s)
	# Big briefcase in front
	var bc = shield_center + Vector2(-16, -2) * s
	var bc_color = Color(0.83, 0.64, 0.29)
	draw_rect(Rect2(bc, Vector2(32, 20) * s), bc_color, false, 2.5)
	_draw_line_seg(bc + Vector2(12, 0) * s, bc + Vector2(12, -4) * s, THIN_LINE, bc_color)
	_draw_line_seg(bc + Vector2(20, 0) * s, bc + Vector2(20, -4) * s, THIN_LINE, bc_color)
	_draw_line_seg(bc + Vector2(12, -4) * s, bc + Vector2(20, -4) * s, THIN_LINE, bc_color)

func _draw_arms_fists(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Both arms at sides, fists clenched
	var fist_l = sh_l + Vector2(-6, 35) * s
	_draw_line_seg(sh_l, sh_l + Vector2(-4, 20) * s)
	_draw_line_seg(sh_l + Vector2(-4, 20) * s, fist_l)
	_draw_circle_outline(fist_l, 4.0 * s, 2.0)

	var fist_r = sh_r + Vector2(6, 35) * s
	_draw_line_seg(sh_r, sh_r + Vector2(4, 20) * s)
	_draw_line_seg(sh_r + Vector2(4, 20) * s, fist_r)
	_draw_circle_outline(fist_r, 4.0 * s, 2.0)

	# Briefcase dropped on the ground, tilted
	# Use draw_polyline to draw a rotated rectangle without draw_set_transform
	# (draw_set_transform would overwrite the parent DRAW_SCALE transform)
	var bc = o + Vector2(18, -14) * s
	var bc_color = Color(0.83, 0.64, 0.29, 0.7)
	var bw = 20.0 * s
	var bh = 13.0 * s
	var rot = 0.2
	var cr = cos(rot)
	var sr = sin(rot)
	var corners = PackedVector2Array([
		bc,
		bc + Vector2(bw * cr, bw * sr),
		bc + Vector2(bw * cr - bh * sr, bw * sr + bh * cr),
		bc + Vector2(-bh * sr, bh * cr),
		bc,
	])
	draw_polyline(corners, bc_color, 1.8, true)
