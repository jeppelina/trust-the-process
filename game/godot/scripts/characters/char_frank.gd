extends StickCharacter
class_name CharFrank
## Groundskeeper Frank. The only normal person. All rectangles, no nonsense.
## Signature props: wrench, coffee mug, name tag, work boots, key ring.

func _ready() -> void:
	accent_color = Color(0.60, 0.60, 0.54)  # tool gray
	character_id = "frank"
	display_name = "Frank"
	# Idle: barely moves. Frank is stable, grounded.
	_bob_amplitude = 0.3
	_bob_speed = 0.8
	_sway_amplitude = 0.0
	_sway_speed = 0.0
	custom_minimum_size = Vector2(130, 150)
	super._ready()

const TOOL_GRAY := Color(0.60, 0.60, 0.54)
const WORK_SHIRT := Color(0.75, 0.68, 0.58)

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Work Boots ──
	var boot_l = o + Vector2(-12, 0) * s
	var boot_r = o + Vector2(12, 0) * s
	# Left boot (closed polygon)
	var boot_l_pts = PackedVector2Array([
		boot_l + Vector2(-4, 0) * s,
		boot_l + Vector2(4, 0) * s,
		boot_l + Vector2(4, -12) * s,
		boot_l + Vector2(-4, -12) * s,
	])
	draw_colored_polygon(boot_l_pts, TOOL_GRAY)
	# Right boot
	var boot_r_pts = PackedVector2Array([
		boot_r + Vector2(-4, 0) * s,
		boot_r + Vector2(4, 0) * s,
		boot_r + Vector2(4, -12) * s,
		boot_r + Vector2(-4, -12) * s,
	])
	draw_colored_polygon(boot_r_pts, TOOL_GRAY)
	# Boot laces (small horizontal lines)
	for i in 2:
		var y = boot_l.y + (-3 - i * 4) * s
		_draw_line_seg(boot_l + Vector2(-3, y - boot_l.y) * s, boot_l + Vector2(3, y - boot_l.y) * s, HAIR_LINE)
		_draw_line_seg(boot_r + Vector2(-3, y - boot_r.y) * s, boot_r + Vector2(3, y - boot_r.y) * s, HAIR_LINE)

	# ── Legs (sturdy, thick) ──
	var hip = o + Vector2(0, -52) * s
	_draw_line_seg(boot_l + Vector2(0, -12) * s, hip + Vector2(-6, 0) * s, 3.2)
	_draw_line_seg(boot_r + Vector2(0, -12) * s, hip + Vector2(6, 0) * s, 3.2)

	# ── Belt ──
	_draw_line_seg(hip + Vector2(-10, 0) * s, hip + Vector2(10, 0) * s, 2.2, TOOL_GRAY)
	# Belt buckle (rectangle)
	draw_rect(Rect2(hip + Vector2(-2.5, -2) * s, Vector2(5, 4) * s), TOOL_GRAY, false, 1.0)
	# Key ring (circle + small lines for keys)
	var key_ring = hip + Vector2(12, 0) * s
	_draw_circle_outline(key_ring, 3 * s, HAIR_LINE, TOOL_GRAY)
	_draw_line_seg(key_ring + Vector2(1, -2) * s, key_ring + Vector2(3, -3) * s, HAIR_LINE, TOOL_GRAY)
	_draw_line_seg(key_ring + Vector2(-1, 2) * s, key_ring + Vector2(-3, 4) * s, HAIR_LINE, TOOL_GRAY)

	# ── Torso (work shirt, rectangular) ──
	var shoulder = o + Vector2(0, -88) * s
	_draw_line_seg(hip, shoulder, 2.8)

	# Shirt buttons (functional)
	for i in 2:
		var by = hip.y + (shoulder.y - hip.y) * (0.35 + i * 0.3)
		draw_circle(Vector2(o.x, by), 1.0 * s, DIM_COLOR)

	# Chest pocket with pen
	var pocket = shoulder + Vector2(-6, 12) * s
	draw_rect(Rect2(pocket, Vector2(6, 8) * s), LINE_COLOR, false, THIN_LINE)
	_draw_line_seg(pocket + Vector2(1, 0) * s, pocket + Vector2(3, -2) * s, HAIR_LINE)  # pen

	# Name tag "FRANK" (accent color rectangle with text indicator)
	var nametag = shoulder + Vector2(0, 16) * s
	draw_rect(Rect2(nametag + Vector2(-8, -3) * s, Vector2(16, 6) * s), TOOL_GRAY, false, 1.2)
	# Simple indicator lines for text
	_draw_line_seg(nametag + Vector2(-6, -2) * s, nametag + Vector2(6, -2) * s, HAIR_LINE, LINE_COLOR)
	_draw_line_seg(nametag + Vector2(-6, 1) * s, nametag + Vector2(6, 1) * s, HAIR_LINE, LINE_COLOR)

	# ── Shoulders (square, straight) ──
	var sh_l = shoulder + Vector2(-22, 0) * s
	var sh_r = shoulder + Vector2(22, 0) * s
	# Right-angle drops
	draw_polyline(PackedVector2Array([
		sh_l, shoulder + Vector2(-8, 0) * s,
		shoulder + Vector2(8, 0) * s, sh_r
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms ──
	match expression:
		Emotion.ANGRY:
			_draw_arms_angry(o, s, sh_l, sh_r)
		_:
			_draw_arms_default(o, s, sh_l, sh_r)

	# ── Neck ──
	var neck_base = shoulder + Vector2(0, -2) * s
	var neck_top = shoulder + Vector2(0, -10) * s
	_draw_line_seg(neck_base, neck_top, 2.2)

	# ── Head (SQUARE with rounded corners) ──
	var head_center = neck_top + Vector2(0, -18) * s
	var head_w = 16.0 * s
	var head_h = 20.0 * s
	# Draw rounded rectangle for head
	_draw_rounded_rect(head_center + Vector2(-head_w / 2, -head_h / 2), head_w, head_h, 3.0 * s)

	# ── Baseball cap (forward-facing brim, practical) ──
	var cap_top = head_center + Vector2(0, -head_h / 2 - 2) * s
	var cap_brim = head_center + Vector2(0, -head_h / 2 + 3) * s
	# Cap crown (rounded top)
	draw_arc(cap_top, 7 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, LINE_WIDTH, true)
	# Cap brim (straight, forward-facing)
	_draw_line_seg(cap_brim + Vector2(-10, 0) * s, cap_brim + Vector2(10, 0) * s, 2.0)
	_draw_line_seg(cap_brim + Vector2(-10, 0) * s, cap_brim + Vector2(-8, 3) * s, THIN_LINE)
	_draw_line_seg(cap_brim + Vector2(10, 0) * s, cap_brim + Vector2(8, 3) * s, THIN_LINE)

	# ── 5 o'clock shadow (faint dashed line) ──
	var shadow_y = head_center.y + 8 * s
	for i in 3:
		var sx = head_center.x - 6 + i * 6
		_draw_line_seg(Vector2(sx, shadow_y), Vector2(sx + 2, shadow_y), HAIR_LINE, Color(DIM_COLOR, 0.5))

	# ── Face ──
	_draw_face(head_center, s)

func _draw_rounded_rect(top_left: Vector2, w: float, h: float, radius: float) -> void:
	# Simple rounded rectangle using polyline with corner arcs
	var points = PackedVector2Array()

	# Top-left corner
	for i in 3:
		var angle = PI + PI / 2.0 + (i / 2.0) * (PI / 2.0)
		points.append(top_left + Vector2(radius, radius) + Vector2(cos(angle) * radius, sin(angle) * radius))

	# Top edge
	points.append(top_left + Vector2(w - radius, 0))

	# Top-right corner
	for i in 3:
		var angle = (i / 2.0) * (PI / 2.0)
		points.append(top_left + Vector2(w - radius, radius) + Vector2(cos(angle) * radius, sin(angle) * radius))

	# Right edge
	points.append(top_left + Vector2(w, h - radius))

	# Bottom-right corner
	for i in 3:
		var angle = -PI / 2.0 + (i / 2.0) * (PI / 2.0)
		points.append(top_left + Vector2(w - radius, h - radius) + Vector2(cos(angle) * radius, sin(angle) * radius))

	# Bottom edge
	points.append(top_left + Vector2(radius, h))

	# Bottom-left corner
	for i in 3:
		var angle = PI + (i / 2.0) * (PI / 2.0)
		points.append(top_left + Vector2(radius, h - radius) + Vector2(cos(angle) * radius, sin(angle) * radius))

	# Left edge back to start
	points.append(top_left + Vector2(0, radius))

	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Flat unimpressed default
			_draw_line_seg(hc + Vector2(-6, -1) * s, hc + Vector2(-2, -1) * s, THIN_LINE)  # left eye
			_draw_line_seg(hc + Vector2(2, -1) * s, hc + Vector2(6, -1) * s, THIN_LINE)   # right eye
			# Flat eyebrows
			_draw_line_seg(hc + Vector2(-7, -6) * s, hc + Vector2(-1, -6) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(1, -6) * s, hc + Vector2(7, -6) * s, THIN_LINE)
			# Nose (vertical line)
			_draw_line_seg(hc + Vector2(0, -2) * s, hc + Vector2(0, 2) * s, HAIR_LINE)
			# Flat mouth line
			_draw_line_seg(hc + Vector2(-4, 8) * s, hc + Vector2(4, 8) * s, THIN_LINE)

		Emotion.HAPPY:
			# Slight side-eye (dot pupils looking sideways)
			draw_circle(hc + Vector2(-5, -1) * s, 1.2 * s, LINE_COLOR)
			draw_circle(hc + Vector2(5, -1) * s, 1.2 * s, LINE_COLOR)
			# Conspiratorial eyebrow tilt
			_draw_line_seg(hc + Vector2(-7, -7) * s, hc + Vector2(-1, -5) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(1, -5) * s, hc + Vector2(7, -7) * s, THIN_LINE)
			# One corner of mouth slightly up (smirk)
			draw_polyline(PackedVector2Array([
				hc + Vector2(-4, 8) * s,
				hc + Vector2(0, 7) * s,
				hc + Vector2(4, 7.5) * s
			]), LINE_COLOR, 1.2, true)

		Emotion.ANGRY:
			# Deeper flat lines, jaw set
			_draw_line_seg(hc + Vector2(-6, -2) * s, hc + Vector2(-2, -2) * s, 2.0)  # left eye
			_draw_line_seg(hc + Vector2(2, -2) * s, hc + Vector2(6, -2) * s, 2.0)   # right eye
			# Angry slanted eyebrows
			_draw_line_seg(hc + Vector2(-8, -5) * s, hc + Vector2(-1, -8) * s, 1.8)
			_draw_line_seg(hc + Vector2(1, -8) * s, hc + Vector2(8, -5) * s, 1.8)
			# Nose (stronger)
			_draw_line_seg(hc + Vector2(0, -2) * s, hc + Vector2(0, 3) * s, THIN_LINE)
			# Mouth pressed thin
			_draw_line_seg(hc + Vector2(-5, 8) * s, hc + Vector2(5, 8) * s, 2.0)

		Emotion.SCARED:
			# Round dot eyes (rare — Frank doesn't scare easy)
			_draw_circle_outline(hc + Vector2(-5, -1) * s, 3.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(-5, -1) * s, 1.8 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(5, -1) * s, 3.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(5, -1) * s, 1.8 * s, LINE_COLOR)
			# Normal eyebrows
			_draw_line_seg(hc + Vector2(-7, -6) * s, hc + Vector2(-1, -6) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(1, -6) * s, hc + Vector2(7, -6) * s, THIN_LINE)
			# Mouth slightly open
			_draw_line_seg(hc + Vector2(-4, 8) * s, hc + Vector2(4, 8) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(-3, 8) * s, hc + Vector2(-3, 10) * s, HAIR_LINE)
			_draw_line_seg(hc + Vector2(3, 8) * s, hc + Vector2(3, 10) * s, HAIR_LINE)

		Emotion.SPECIAL:
			# Knowing nod — eyes slightly closed, faint smirk
			draw_arc(hc + Vector2(-5, -1) * s, 3 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, THIN_LINE, true)
			draw_circle(hc + Vector2(-5, 0) * s, 0.8 * s, LINE_COLOR)
			draw_arc(hc + Vector2(5, -1) * s, 3 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, THIN_LINE, true)
			draw_circle(hc + Vector2(5, 0) * s, 0.8 * s, LINE_COLOR)
			# Knowing eyebrows
			_draw_line_seg(hc + Vector2(-7, -7) * s, hc + Vector2(-1, -5) * s, THIN_LINE)
			_draw_line_seg(hc + Vector2(1, -5) * s, hc + Vector2(7, -7) * s, THIN_LINE)
			# Faint smirk
			draw_polyline(PackedVector2Array([
				hc + Vector2(-3, 8) * s,
				hc + Vector2(0, 7) * s,
				hc + Vector2(3, 7.5) * s
			]), LINE_COLOR, 1.0, true)

func _draw_arms_default(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Left arm holding WRENCH
	var elbow_l = sh_l + Vector2(-6, 20) * s
	var hand_l = elbow_l + Vector2(-4, 16) * s
	_draw_line_seg(sh_l, elbow_l, 2.8)
	_draw_line_seg(elbow_l, hand_l, 2.8)

	# Wrench (vertical line + open-jaw rectangle at bottom)
	var wrench_base = hand_l + Vector2(-2, 8) * s
	_draw_line_seg(hand_l, wrench_base, 2.0, TOOL_GRAY)
	# Wrench jaw (open rectangle)
	var jaw_pts = PackedVector2Array([
		wrench_base + Vector2(-3, 0) * s,
		wrench_base + Vector2(3, 0) * s,
		wrench_base + Vector2(3, -6) * s,
		wrench_base + Vector2(-3, -6) * s,
	])
	draw_colored_polygon(jaw_pts, Color(TOOL_GRAY, 0.6))
	draw_polyline(jaw_pts, TOOL_GRAY, 1.5, true)

	# Right arm holding COFFEE MUG
	var elbow_r = sh_r + Vector2(6, 18) * s
	var hand_r = elbow_r + Vector2(4, 18) * s
	_draw_line_seg(sh_r, elbow_r, 2.8)
	_draw_line_seg(elbow_r, hand_r, 2.8)

	# Coffee mug (rectangle with D-shaped handle)
	var mug = hand_r + Vector2(-8, 2) * s
	draw_rect(Rect2(mug, Vector2(14, 10) * s), WORK_SHIRT, false, 2.0)
	# D-shaped handle
	var handle_center = mug + Vector2(14, 5) * s
	draw_arc(handle_center, 4 * s, -PI / 2.0, PI / 2.0, 8, LINE_COLOR, 1.8, true)
	# Steam wisps above
	for i in 2:
		var sx = mug.x + 4 + i * 6
		draw_arc(Vector2(sx, mug.y - 4) * s, 2 * s, PI, TAU, 6, Color(LINE_COLOR, 0.4), HAIR_LINE, true)

func _draw_arms_angry(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Same as default but arms more rigid/tense
	var elbow_l = sh_l + Vector2(-8, 18) * s
	var hand_l = elbow_l + Vector2(-6, 18) * s
	_draw_line_seg(sh_l, elbow_l, 3.0)
	_draw_line_seg(elbow_l, hand_l, 3.0)

	# Wrench gripped tight
	var wrench_base = hand_l + Vector2(-2, 8) * s
	_draw_line_seg(hand_l, wrench_base, 2.5, TOOL_GRAY)
	var jaw_pts = PackedVector2Array([
		wrench_base + Vector2(-3, 0) * s,
		wrench_base + Vector2(3, 0) * s,
		wrench_base + Vector2(3, -6) * s,
		wrench_base + Vector2(-3, -6) * s,
	])
	draw_colored_polygon(jaw_pts, Color(TOOL_GRAY, 0.7))
	draw_polyline(jaw_pts, TOOL_GRAY, 2.0, true)

	# Right arm rigid, coffee mug
	var elbow_r = sh_r + Vector2(8, 16) * s
	var hand_r = elbow_r + Vector2(6, 20) * s
	_draw_line_seg(sh_r, elbow_r, 3.0)
	_draw_line_seg(elbow_r, hand_r, 3.0)

	var mug = hand_r + Vector2(-8, 2) * s
	draw_rect(Rect2(mug, Vector2(14, 10) * s), WORK_SHIRT, false, 2.5)
	var handle_center = mug + Vector2(14, 5) * s
	draw_arc(handle_center, 4 * s, -PI / 2.0, PI / 2.0, 8, LINE_COLOR, 2.0, true)
