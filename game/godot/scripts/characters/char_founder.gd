extends StickCharacter
class_name CharFounder
## The Founder (Paul) — Zone 1 boss.
## Triangle-shaped authority figure: linen tunic, man-bun, groomed beard, mala beads.
## Three expressions map to boss phases:
## - NEUTRAL = Phase 1 (welcoming): warm eyes, practiced smile, wide open arms, intact mala
## - ANGRY = Phase 2 (mask slipping): intense eyes, vein, broken mala, accusing arm
## - SCARED = Phase 3 (broken/just Paul): collapsed posture, vulnerable eyes, scattered beads, hair falling
## Accent color: deep warm amber #d4a34a

const MALA_COLOR := Color(0.83, 0.64, 0.29)  # warm amber for mala beads and pendant
const TUNIC_COLOR := Color(0.80, 0.75, 0.65)  # warm linen tone
const SKIN_TONE := Color(0.85, 0.75, 0.65)   # warm tan

func _ready() -> void:
	accent_color = Color(0.83, 0.64, 0.29)  # deep warm amber
	character_id = "founder"
	display_name = "The Founder"
	# Slow authoritative sway, gentle floating bob
	_bob_amplitude = 2.0
	_bob_speed = 1.2
	_sway_amplitude = 1.5
	_sway_speed = 0.8
	custom_minimum_size = Vector2(160, 160)
	super._ready()

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	# ── Bare feet with toe lines ──
	_draw_feet(o, s)

	# ── Legs: strong, grounded ──
	_draw_legs(o, s)

	# ── Tunic with fold lines ──
	_draw_tunic(o, s)

	# ── Mala beads around neck/chest ──
	_draw_mala(o, s)

	# ── Shoulders and neck ──
	var shoulder = o + Vector2(0, -82) * s
	var neck_top = shoulder + Vector2(0, -8) * s
	_draw_line_seg(shoulder + Vector2(0, -3) * s, neck_top, 2.2)

	# ── Shoulders: broad, welcoming ──
	var sh_l = shoulder + Vector2(-28, 3) * s
	var sh_r = shoulder + Vector2(28, 3) * s
	draw_polyline(PackedVector2Array([
		sh_l,
		shoulder + Vector2(-6, -3) * s,
		shoulder + Vector2(6, -3) * s,
		sh_r
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms: key to expression ──
	match expression:
		Emotion.ANGRY, Emotion.SPECIAL:
			_draw_arms_accusatory(o, s, sh_l, sh_r)
		Emotion.SCARED:
			_draw_arms_shielding(o, s, sh_l, sh_r)
		_:
			_draw_arms_welcoming(o, s, sh_l, sh_r)

	# ── Head ──
	var head_center = neck_top + Vector2(0, -18) * s
	_draw_head(head_center, s)

	# ── Face (expression-dependent) ──
	_draw_face(head_center, s)

func _draw_feet(o: Vector2, s: float) -> void:
	# Left foot
	var foot_l = o + Vector2(-12, 0) * s
	_draw_line_seg(foot_l + Vector2(-6, 0) * s, foot_l + Vector2(3, -2) * s)
	# Toe lines
	for i in 4:
		var tx = foot_l.x + (-4 + i * 2.5) * s
		_draw_line_seg(Vector2(tx, foot_l.y), Vector2(tx, foot_l.y - 2 * s), HAIR_LINE)

	# Right foot
	var foot_r = o + Vector2(12, 0) * s
	_draw_line_seg(foot_r + Vector2(-3, -2) * s, foot_r + Vector2(6, 0) * s)
	# Toe lines
	for i in 4:
		var tx = foot_r.x + (-2.5 + i * 2.5) * s
		_draw_line_seg(Vector2(tx, foot_r.y), Vector2(tx, foot_r.y - 2 * s), HAIR_LINE)

func _draw_legs(o: Vector2, s: float) -> void:
	var foot_l = o + Vector2(-12, 0) * s
	var foot_r = o + Vector2(12, 0) * s
	var knee_l = o + Vector2(-10, -30) * s
	var knee_r = o + Vector2(10, -30) * s
	var hip = o + Vector2(0, -58) * s

	# Left leg
	_draw_line_seg(foot_l, knee_l, 3.2)
	_draw_line_seg(knee_l, hip + Vector2(-6, 0) * s, 3.2)

	# Right leg
	_draw_line_seg(foot_r, knee_r, 3.2)
	_draw_line_seg(knee_r, hip + Vector2(6, 0) * s, 3.2)

func _draw_tunic(o: Vector2, s: float) -> void:
	var hip = o + Vector2(0, -58) * s
	var shoulder = o + Vector2(0, -82) * s

	# Main tunic outline (triangle widening from hip to shoulders)
	var tunic_pts = PackedVector2Array([
		hip + Vector2(-10, 0) * s,
		hip + Vector2(-22, 8) * s,
		shoulder + Vector2(-28, 8) * s,
		shoulder + Vector2(28, 8) * s,
		hip + Vector2(22, 8) * s,
		hip + Vector2(10, 0) * s,
	])
	draw_polyline(tunic_pts, LINE_COLOR, LINE_WIDTH, true)

	# Center fold line (tunic drapes down middle)
	_draw_line_seg(hip + Vector2(0, 0) * s, hip + Vector2(0, 10) * s, THIN_LINE, DIM_COLOR)

	# Side fold lines (shoulders to hip, subtle flow)
	_draw_line_seg(shoulder + Vector2(-20, 8) * s, hip + Vector2(-14, 6) * s, THIN_LINE, DIM_COLOR)
	_draw_line_seg(shoulder + Vector2(20, 8) * s, hip + Vector2(14, 6) * s, THIN_LINE, DIM_COLOR)

func _draw_mala(o: Vector2, s: float) -> void:
	# Mala beads draped around neck and down chest
	var neck_start = o + Vector2(0, -90) * s
	var chest_end = o + Vector2(0, -55) * s

	# Main string curve
	var mala_path = PackedVector2Array([
		neck_start + Vector2(-18, -4) * s,
		neck_start + Vector2(-14, 2) * s,
		neck_start + Vector2(0, 6) * s,
		chest_end + Vector2(0, 0) * s,
		neck_start + Vector2(0, 6) * s,
		neck_start + Vector2(14, 2) * s,
		neck_start + Vector2(18, -4) * s,
	])
	draw_polyline(mala_path, MALA_COLOR, 1.5, true)

	# Beads along the string (phase-dependent appearance)
	match expression:
		Emotion.NEUTRAL, Emotion.HAPPY:
			_draw_mala_intact(neck_start, chest_end, s)
		Emotion.ANGRY, Emotion.SPECIAL:
			_draw_mala_breaking(neck_start, chest_end, s)
		Emotion.SCARED:
			_draw_mala_scattered(chest_end, s)

	# Pendant at chest
	var pendant_top = chest_end + Vector2(0, 0) * s
	var pendant_bottom = chest_end + Vector2(0, 16) * s
	_draw_line_seg(pendant_top, pendant_bottom, THIN_LINE, MALA_COLOR)
	# Pendant shape (teardrop)
	draw_circle(pendant_bottom, 3.5 * s, MALA_COLOR)

func _draw_mala_intact(start: Vector2, end: Vector2, s: float) -> void:
	# Regular beads around mala in Phase 1
	for i in 11:
		var t = float(i) / 10.0
		var pos = start.lerp(end, t * 0.5)  # Left side
		draw_circle(pos, 2.0 * s, MALA_COLOR)

		pos = start.lerp(end, 1.0 - t * 0.5)  # Right side
		draw_circle(pos, 2.0 * s, MALA_COLOR)

func _draw_mala_breaking(start: Vector2, end: Vector2, s: float) -> void:
	# Some beads on string, some scattered (Phase 2)
	var intact_beads = 6
	for i in intact_beads:
		var t = float(i) / float(intact_beads)
		var pos = start.lerp(end, t * 0.4)
		draw_circle(pos, 2.0 * s, MALA_COLOR)

	# Scattered beads falling
	draw_circle(end + Vector2(8, 2) * s, 1.8 * s, MALA_COLOR)
	draw_circle(end + Vector2(-10, 4) * s, 1.5 * s, MALA_COLOR)
	draw_circle(end + Vector2(3, -2) * s, 1.8 * s, MALA_COLOR)

func _draw_mala_scattered(end: Vector2, s: float) -> void:
	# Most beads scattered on ground (Phase 3)
	var scattered_positions = [
		end + Vector2(-12, 8) * s,
		end + Vector2(6, 10) * s,
		end + Vector2(-8, 12) * s,
		end + Vector2(14, 6) * s,
		end + Vector2(2, 14) * s,
		end + Vector2(-15, 4) * s,
	]
	for pos in scattered_positions:
		draw_circle(pos, 1.8 * s, MALA_COLOR)

func _draw_head(center: Vector2, s: float) -> void:
	# Larger head than typical NPCs (authority)
	var head_rx = 16.0 * s
	var head_ry = 18.0 * s
	_draw_circle_outline(center, head_rx, LINE_WIDTH, LINE_COLOR)

	# Man-bun on top
	_draw_man_bun(center, s)

	# Beard (fuller, groomed)
	_draw_beard(center, s)

	# Crow's feet wrinkles (always present, part of his charm)
	_draw_crow_feet(center, s)

func _draw_man_bun(center: Vector2, s: float) -> void:
	# Hair going up and back
	var bun_top = center + Vector2(0, -20) * s
	var hair_lines = PackedVector2Array([
		center + Vector2(-8, -15) * s,
		center + Vector2(-4, -22) * s,
		bun_top,
		center + Vector2(4, -22) * s,
		center + Vector2(8, -15) * s,
	])
	draw_polyline(hair_lines, LINE_COLOR, 2.0, true)

	# Bun shape (circle with tie)
	_draw_circle_outline(bun_top, 5.5 * s, 2.0, LINE_COLOR)
	# Hair tie (simple line)
	draw_arc(bun_top + Vector2(0, 6) * s, 4.5 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, THIN_LINE, true)

	# SCARED: bun falling apart (draw less)
	if expression == Emotion.SCARED:
		# Hair falling loose on sides
		draw_polyline(PackedVector2Array([
			center + Vector2(-12, -8) * s,
			center + Vector2(-14, 4) * s,
		]), LINE_COLOR, 1.8, true)
		draw_polyline(PackedVector2Array([
			center + Vector2(12, -8) * s,
			center + Vector2(14, 4) * s,
		]), LINE_COLOR, 1.8, true)

func _draw_beard(center: Vector2, s: float) -> void:
	# Neat groomed beard in NEUTRAL/HAPPY
	if expression == Emotion.NEUTRAL or expression == Emotion.HAPPY:
		var beard_pts = PackedVector2Array([
			center + Vector2(-8, 8) * s,
			center + Vector2(-6, 14) * s,
			center + Vector2(0, 15) * s,
			center + Vector2(6, 14) * s,
			center + Vector2(8, 8) * s,
		])
		draw_polyline(beard_pts, LINE_COLOR, 2.2, true)
		# Beard lines for texture
		_draw_line_seg(center + Vector2(-4, 9) * s, center + Vector2(-3, 13) * s, HAIR_LINE)
		_draw_line_seg(center + Vector2(0, 10) * s, center + Vector2(0, 15) * s, HAIR_LINE)
		_draw_line_seg(center + Vector2(4, 9) * s, center + Vector2(3, 13) * s, HAIR_LINE)

	# Tight/clenched beard in ANGRY
	elif expression == Emotion.ANGRY or expression == Emotion.SPECIAL:
		_draw_line_seg(center + Vector2(-8, 8) * s, center + Vector2(8, 8) * s, 2.5)
		# Tension lines
		_draw_line_seg(center + Vector2(-6, 9) * s, center + Vector2(-5, 12) * s, THIN_LINE)
		_draw_line_seg(center + Vector2(0, 9) * s, center + Vector2(0, 12) * s, THIN_LINE)
		_draw_line_seg(center + Vector2(6, 9) * s, center + Vector2(5, 12) * s, THIN_LINE)

	# Quivering/open mouth in SCARED
	elif expression == Emotion.SCARED:
		# Mouth opening (vulnerable)
		draw_arc(center + Vector2(0, 10) * s, 4 * s, 0.1, PI - 0.1, 12, LINE_COLOR, 1.5, true)
		# No beard, just vulnerable chin

func _draw_crow_feet(center: Vector2, s: float) -> void:
	# Crinkle lines at eye corners (always present)
	var eye_l = center + Vector2(-7, 0) * s
	var eye_r = center + Vector2(7, 0) * s

	# Left eye crow's feet
	_draw_line_seg(eye_l + Vector2(6, -3) * s, eye_l + Vector2(9, -5) * s, HAIR_LINE)
	_draw_line_seg(eye_l + Vector2(6, 0) * s, eye_l + Vector2(9, 0) * s, HAIR_LINE)
	_draw_line_seg(eye_l + Vector2(6, 3) * s, eye_l + Vector2(9, 5) * s, HAIR_LINE)

	# Right eye crow's feet
	_draw_line_seg(eye_r + Vector2(-6, -3) * s, eye_r + Vector2(-9, -5) * s, HAIR_LINE)
	_draw_line_seg(eye_r + Vector2(-6, 0) * s, eye_r + Vector2(-9, 0) * s, HAIR_LINE)
	_draw_line_seg(eye_r + Vector2(-6, 3) * s, eye_r + Vector2(-9, 5) * s, HAIR_LINE)

func _draw_face(center: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			_draw_face_welcoming(center, s)

		Emotion.HAPPY:
			_draw_face_welcoming_bright(center, s)

		Emotion.ANGRY, Emotion.SPECIAL:
			_draw_face_angry(center, s)

		Emotion.SCARED:
			_draw_face_scared(center, s)

func _draw_face_welcoming(center: Vector2, s: float) -> void:
	# Phase 1: warm, practiced smile, crinkled eyes of genuine wisdom (or manipulation)
	var eye_l = center + Vector2(-7, 0) * s
	var eye_r = center + Vector2(7, 0) * s

	# Eyes: half-closed, warm
	draw_arc(eye_l + Vector2(0, 0) * s, 3 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.8, true)
	draw_circle(eye_l + Vector2(0, 1) * s, 1.2 * s, LINE_COLOR)

	draw_arc(eye_r + Vector2(0, 0) * s, 3 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.8, true)
	draw_circle(eye_r + Vector2(0, 1) * s, 1.2 * s, LINE_COLOR)

	# Arched brows (knowing, confident)
	draw_arc(eye_l + Vector2(0, -5) * s, 5 * s, PI + 0.7, TAU - 0.7, 8, LINE_COLOR, 1.2, true)
	draw_arc(eye_r + Vector2(0, -5) * s, 5 * s, PI + 0.7, TAU - 0.7, 8, LINE_COLOR, 1.2, true)

	# Warm smile (practiced but convincing)
	draw_arc(center + Vector2(0, 6) * s, 6 * s, 0.3, PI - 0.3, 12, LINE_COLOR, 1.3, true)

	# Aura glow around hands area (charisma visual)
	var hand_l = center + Vector2(-22, 12) * s
	var hand_r = center + Vector2(22, 12) * s
	draw_circle(hand_l, 12 * s, Color(accent_color.r, accent_color.g, accent_color.b, 0.05))
	draw_circle(hand_r, 12 * s, Color(accent_color.r, accent_color.g, accent_color.b, 0.05))

func _draw_face_welcoming_bright(center: Vector2, s: float) -> void:
	# HAPPY: bigger smile, slightly less cynical
	var eye_l = center + Vector2(-7, 0) * s
	var eye_r = center + Vector2(7, 0) * s

	# Eyes: squinting happily
	_draw_line_seg(eye_l + Vector2(-2, 1) * s, eye_l + Vector2(2, 1) * s, 1.8)
	_draw_line_seg(eye_r + Vector2(-2, 1) * s, eye_r + Vector2(2, 1) * s, 1.8)

	# Arched brows
	draw_arc(eye_l + Vector2(0, -5) * s, 5 * s, PI + 0.6, TAU - 0.6, 8, LINE_COLOR, 1.2, true)
	draw_arc(eye_r + Vector2(0, -5) * s, 5 * s, PI + 0.6, TAU - 0.6, 8, LINE_COLOR, 1.2, true)

	# Bigger, wider smile
	draw_arc(center + Vector2(0, 5) * s, 8 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.5, true)

func _draw_face_angry(center: Vector2, s: float) -> void:
	# Phase 2: mask slipping, intensity exposed
	var eye_l = center + Vector2(-7, 0) * s
	var eye_r = center + Vector2(7, 0) * s

	# Eyes: wide, intense
	_draw_circle_outline(eye_l, 3.5 * s, THIN_LINE)
	draw_circle(eye_l, 1.8 * s, LINE_COLOR)

	_draw_circle_outline(eye_r, 3.5 * s, THIN_LINE)
	draw_circle(eye_r, 1.8 * s, LINE_COLOR)

	# Angled brows pointing down (angry V)
	_draw_line_seg(center + Vector2(-11, -5) * s, center + Vector2(-4, -8) * s, 2.0)
	_draw_line_seg(center + Vector2(4, -8) * s, center + Vector2(11, -5) * s, 2.0)

	# Tight mouth (clenched)
	_draw_line_seg(center + Vector2(-5, 8) * s, center + Vector2(5, 8) * s, 2.0)

	# Anger vein on temple (right side)
	draw_polyline(PackedVector2Array([
		center + Vector2(18, -12) * s,
		center + Vector2(22, -16) * s,
		center + Vector2(20, -10) * s,
		center + Vector2(24, -14) * s,
	]), LINE_COLOR, THIN_LINE, true)

func _draw_face_scared(center: Vector2, s: float) -> void:
	# Phase 3: broken, vulnerable, just Paul
	var eye_l = center + Vector2(-7, -1) * s
	var eye_r = center + Vector2(7, -1) * s

	# Eyes: small, scared, vulnerable
	draw_circle(eye_l, 2.0 * s, LINE_COLOR)
	draw_circle(eye_r, 2.0 * s, LINE_COLOR)

	# Raised vulnerable brows (upturned)
	draw_arc(eye_l + Vector2(0, -4) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.0, true)
	draw_arc(eye_r + Vector2(0, -4) * s, 4 * s, PI + 0.5, TAU - 0.5, 8, LINE_COLOR, 1.0, true)

	# Tears (drops)
	draw_circle(eye_l + Vector2(0, 4) * s, 1.2 * s, Color(0.42, 0.60, 0.83, 0.5))
	draw_circle(eye_r + Vector2(0, 4) * s, 1.2 * s, Color(0.42, 0.60, 0.83, 0.5))

func _draw_arms_welcoming(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Phase 1: arms wide open, inviting, trusting
	# Left arm: extended outward and up
	var elbow_l = sh_l + Vector2(-18, -8) * s
	var hand_l = elbow_l + Vector2(-8, -6) * s
	_draw_line_seg(sh_l, elbow_l, 3.0)
	_draw_line_seg(elbow_l, hand_l, 2.8)

	# Fingers spread (gesture of giving)
	_draw_line_seg(hand_l, hand_l + Vector2(-5, -3) * s, HAIR_LINE)
	_draw_line_seg(hand_l, hand_l + Vector2(-3, -5) * s, HAIR_LINE)
	_draw_line_seg(hand_l, hand_l + Vector2(2, -4) * s, HAIR_LINE)

	# Right arm: extended outward and up (mirrored)
	var elbow_r = sh_r + Vector2(18, -8) * s
	var hand_r = elbow_r + Vector2(8, -6) * s
	_draw_line_seg(sh_r, elbow_r, 3.0)
	_draw_line_seg(elbow_r, hand_r, 2.8)

	# Fingers spread
	_draw_line_seg(hand_r, hand_r + Vector2(5, -3) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(3, -5) * s, HAIR_LINE)
	_draw_line_seg(hand_r, hand_r + Vector2(-2, -4) * s, HAIR_LINE)

func _draw_arms_accusatory(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Phase 2: mask slipping - one arm accusing, one defensive
	# Left arm: pointing accusingly downward
	var elbow_l = sh_l + Vector2(-12, 8) * s
	var hand_l = elbow_l + Vector2(-6, 18) * s
	_draw_line_seg(sh_l, elbow_l, 3.2)
	_draw_line_seg(elbow_l, hand_l, 3.0)

	# Pointing finger
	_draw_line_seg(hand_l, hand_l + Vector2(-3, 4) * s, HAIR_LINE)
	draw_circle(hand_l + Vector2(-3, 4) * s, 1.2 * s, LINE_COLOR)

	# Right arm: defensive, pulled back
	var elbow_r = sh_r + Vector2(8, 14) * s
	var hand_r = elbow_r + Vector2(2, 12) * s
	_draw_line_seg(sh_r, elbow_r, 3.2)
	_draw_line_seg(elbow_r, hand_r, 3.0)

	# Clenched fist
	_draw_circle_outline(hand_r, 4.5 * s, 2.0)

func _draw_arms_shielding(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Phase 3: broken, vulnerable - arms hugging self
	# Both arms wrapped around himself
	var hug_center = o + Vector2(0, -55) * s

	# Left arm
	var elbow_l = sh_l + Vector2(-8, 10) * s
	var hand_l = hug_center + Vector2(-8, 0) * s
	_draw_line_seg(sh_l, elbow_l, 2.8)
	_draw_line_seg(elbow_l, hand_l, 2.6)

	# Right arm
	var elbow_r = sh_r + Vector2(8, 10) * s
	var hand_r = hug_center + Vector2(8, 0) * s
	_draw_line_seg(sh_r, elbow_r, 2.8)
	_draw_line_seg(elbow_r, hand_r, 2.6)

	# Body collapsed inward slightly
	# (visual is mostly achieved by posture and head drop)
