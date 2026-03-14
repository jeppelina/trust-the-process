extends StickCharacter
class_name CharOversharer
## The Oversharer. Round, bursting with nervous energy. Crying, reaching, talking.
## Signature: huge watery eyes with tears, open mouth mid-sentence, grabby reaching arms,
## messy hair, loose wrap clothing, tear-stained journal clutched under arm.

func _ready() -> void:
	accent_color = Color(0.42, 0.60, 0.83)  # tear blue
	character_id = "oversharer"
	display_name = "The Oversharer"
	# Idle: nervous forward-leaning bob, quick jittery sway
	_sway_amplitude = 1.8
	_sway_speed = 3.2
	_bob_amplitude = 0.8
	_bob_speed = 2.2
	custom_minimum_size = Vector2(130, 140)
	super._ready()

const TEAR_BLUE := Color(0.42, 0.60, 0.83)
const TEAR_BLUE_SEMI := Color(0.42, 0.60, 0.83, 0.6)

func _draw_character(origin: Vector2, sc: float, _breath: float, lean: float) -> void:
	var o = origin
	var s = sc
	var leanoff = lean * 8.0  # Forward lean exaggerates with lean parameter

	# ── Sandals ──
	_draw_line_seg(o + Vector2(-14, 0) * s, o + Vector2(-10, -3) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(-12, 0) * s, o + Vector2(-12, -4) * s, HAIR_LINE)
	_draw_line_seg(o + Vector2(14, 0) * s, o + Vector2(10, -3) * s, THIN_LINE)
	_draw_line_seg(o + Vector2(12, 0) * s, o + Vector2(12, -4) * s, HAIR_LINE)

	# ── Legs (simple sticks) ──
	var hip = o + Vector2(0, -42) * s
	_draw_line_seg(o + Vector2(-12, 0) * s, hip + Vector2(-6, 0) * s, 2.0)
	_draw_line_seg(o + Vector2(12, 0) * s, hip + Vector2(6, 0) * s, 2.0)

	# ── Loose wrap/sweater (organic blob shape) ──
	var shoulder = hip + Vector2(0, -46) * s + Vector2(leanoff, -leanoff * 0.5)
	var wrap_left = hip + Vector2(-24, -8) * s + Vector2(leanoff * 0.5, 0)
	var wrap_right = hip + Vector2(24, -8) * s + Vector2(leanoff * 0.5, 0)
	var wrap_neck = shoulder + Vector2(0, -3) * s
	var wrap_pts = PackedVector2Array([
		wrap_left,
		hip + Vector2(-20, -2) * s + Vector2(leanoff * 0.5, 0),
		wrap_neck + Vector2(-18, 0) * s,
		wrap_neck + Vector2(-8, -6) * s,
		wrap_neck + Vector2(8, -6) * s,
		wrap_neck + Vector2(18, 0) * s,
		hip + Vector2(20, -2) * s + Vector2(leanoff * 0.5, 0),
		wrap_right,
		hip + Vector2(6, -2) * s + Vector2(leanoff * 0.5, 0),
		wrap_left + Vector2(6, 0) * s,
	])
	draw_polyline(wrap_pts, LINE_COLOR, LINE_WIDTH, true)

	# Wrap center detail (soft fold)
	_draw_line_seg(shoulder + Vector2(0, 0) * s, hip + Vector2(0, -4) * s, THIN_LINE, TEAR_BLUE)

	# ── Journal under arm (accent color) ──
	var journal_pos = hip + Vector2(22, -26) * s + Vector2(leanoff * 0.3, 0)
	draw_rect(Rect2(journal_pos, Vector2(16, 24) * s), TEAR_BLUE, false, 2.0)
	# Journal spiral binding detail
	for i in 3:
		draw_circle(journal_pos + Vector2(-2, 4 + i * 8) * s, 1.0 * s, TEAR_BLUE)
	# Crumpled pages (wavy line across)
	draw_polyline(PackedVector2Array([
		journal_pos + Vector2(2, 8) * s,
		journal_pos + Vector2(12, 10) * s,
		journal_pos + Vector2(14, 16) * s,
	]), DIM_COLOR, 0.8, true)

	# ── Shoulders ──
	var sh_l = shoulder + Vector2(-22, 4) * s + Vector2(leanoff * 0.4, 0)
	var sh_r = shoulder + Vector2(22, 4) * s + Vector2(leanoff * 0.4, 0)
	_draw_line_seg(sh_l, shoulder + Vector2(-6, -2) * s + Vector2(leanoff * 0.4, 0), 2.5)
	_draw_line_seg(sh_r, shoulder + Vector2(6, -2) * s + Vector2(leanoff * 0.4, 0), 2.5)

	# ── Arms: REACHING toward you with grabby hands ──
	_draw_arms_reaching(o, s, sh_l, sh_r, leanoff)

	# ── Neck ──
	var neck_base = shoulder + Vector2(0, -2) * s + Vector2(leanoff * 0.3, 0)
	var neck_top = shoulder + Vector2(0, -10) * s + Vector2(leanoff * 0.3, 0)
	_draw_line_seg(neck_base, neck_top, 2.2)

	# ── Head: round, tilted forward with lean ──
	var head_center = neck_top + Vector2(0, -20) * s + Vector2(leanoff * 0.2, -leanoff * 0.3)
	var head_rx = 16.0 * s
	var head_ry = 18.0 * s
	_draw_head_circle(head_center, head_rx, head_ry)

	# ── Messy hair (wild, curvy strokes) ──
	var hair_pts = PackedVector2Array([
		head_center + Vector2(-16, -10) * s,
		head_center + Vector2(-12, -22) * s,
		head_center + Vector2(-4, -20) * s,
		head_center + Vector2(2, -24) * s,
		head_center + Vector2(10, -18) * s,
		head_center + Vector2(16, -12) * s,
	])
	draw_polyline(hair_pts, LINE_COLOR, 2.2, true)
	# Extra messy strands
	_draw_line_seg(head_center + Vector2(-14, -12) * s, head_center + Vector2(-18, -18) * s, 1.5)
	_draw_line_seg(head_center + Vector2(14, -10) * s, head_center + Vector2(18, -16) * s, 1.5)

	# ── Face ──
	_draw_face(head_center, s)

	# ── Emotional speech/thought bubbles floating around ──
	_draw_speech_fragments(head_center, s)

func _draw_head_circle(center: Vector2, rx: float, ry: float) -> void:
	var points := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		points.append(center + Vector2(cos(angle) * rx, sin(angle) * ry))
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Huge watery eyes, open mouth mid-sentence
			_draw_watery_eyes(hc, s, false)
			# Open mouth, always talking
			draw_arc(hc + Vector2(0, 10) * s, 6 * s, 0.2, PI - 0.2, 14, LINE_COLOR, 1.5, true)
			# Mouth interior slightly darker
			draw_arc(hc + Vector2(0, 10) * s, 5 * s, 0.3, PI - 0.3, 12, DIM_COLOR, 0.8, true)
			# Tears streaming down
			_draw_tears(hc, s, false)

		Emotion.HAPPY:
			# Eyes still wide but slightly happier (less droopy)
			_draw_watery_eyes(hc, s, true)
			# Open smile
			draw_arc(hc + Vector2(0, 9) * s, 6 * s, 0.1, PI - 0.1, 14, LINE_COLOR, 1.5, true)
			# Still crying (brief moment of connection)
			_draw_tears(hc, s, true)

		Emotion.ANGRY:
			# Trauma dump: eyes SQUINTING from crying hard
			# Upper lid closure (arc from top)
			draw_arc(hc + Vector2(-8, -2) * s, 5 * s, 0.1, PI - 0.1, 12, LINE_COLOR, 2.2, true)
			draw_arc(hc + Vector2(8, -2) * s, 5 * s, 0.1, PI - 0.1, 12, LINE_COLOR, 2.2, true)
			# Pupils barely visible through squint
			draw_circle(hc + Vector2(-8, 1) * s, 1.2 * s, LINE_COLOR)
			draw_circle(hc + Vector2(8, 1) * s, 1.2 * s, LINE_COLOR)
			# Mouth WIDE OPEN, screaming
			_draw_circle_outline(hc + Vector2(0, 11) * s, 8 * s, 2.5)
			draw_polyline(PackedVector2Array([
				hc + Vector2(-6, 8) * s, hc + Vector2(0, 6) * s, hc + Vector2(6, 8) * s
			]), LINE_COLOR, 2.0, true)
			# LOTS of tears
			_draw_tears(hc, s, true)
			# Arms gesticulating wildly (handled in _draw_arms_reaching)

		Emotion.SCARED:
			# Looking away, clutching journal
			draw_arc(hc + Vector2(-8, 1) * s, 5 * s, 1.0, PI + 0.5, 12, LINE_COLOR, 1.8, true)
			draw_circle(hc + Vector2(-8, 2) * s, 2 * s, LINE_COLOR)
			# Other eye looking down/away
			draw_arc(hc + Vector2(8, 3) * s, 4 * s, PI + 0.3, TAU - 0.3, 12, LINE_COLOR, 1.5, true)
			draw_circle(hc + Vector2(8, 5) * s, 1.5 * s, LINE_COLOR)
			# Mouth: fearful grimace
			_draw_line_seg(hc + Vector2(-4, 10) * s, hc + Vector2(4, 10) * s, 1.2)
			# Heavy tears from fear
			_draw_tears(hc, s, true)

		Emotion.SPECIAL:
			# FULL UGLY CRY: maximum tears, maximum emotion
			# Eyes wide and red-rimmed
			_draw_circle_outline(hc + Vector2(-8, 1) * s, 6 * s, 2.0)
			draw_circle(hc + Vector2(-8, 2) * s, 2.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(8, 1) * s, 6 * s, 2.0)
			draw_circle(hc + Vector2(8, 2) * s, 2.5 * s, LINE_COLOR)
			# Eyebrows squeezed down in anguish
			_draw_line_seg(hc + Vector2(-14, -5) * s, hc + Vector2(-2, -6) * s, 2.5)
			_draw_line_seg(hc + Vector2(2, -6) * s, hc + Vector2(14, -5) * s, 2.5)
			# Open screaming mouth
			_draw_circle_outline(hc + Vector2(0, 12) * s, 9 * s, 2.8)
			# Maximum tears pouring
			_draw_tears(hc, s, true)

func _draw_watery_eyes(hc: Vector2, s: float, happy: bool) -> void:
	# Big round eyes with dark pupils and shiny tear highlights
	for offset_x in [-8, 8]:
		_draw_circle_outline(hc + Vector2(offset_x, 0) * s, 5.5 * s, 1.8)
		# Pupil
		draw_circle(hc + Vector2(offset_x, 1) * s, 2.3 * s, LINE_COLOR)
		# Tear highlight (shiny spot)
		draw_circle(hc + Vector2(offset_x - 1.5, -1.5) * s, 1.0 * s, TEAR_BLUE_SEMI)

	if not happy:
		# Sad eyebrows (downward angled)
		_draw_line_seg(hc + Vector2(-13, -5) * s, hc + Vector2(-3, -7) * s, 1.8)
		_draw_line_seg(hc + Vector2(3, -7) * s, hc + Vector2(13, -5) * s, 1.8)

func _draw_tears(hc: Vector2, s: float, heavy: bool) -> void:
	# Tears streaming down from both eyes
	var tear_color = TEAR_BLUE_SEMI
	var num_tears = 3 if heavy else 2
	var tear_length = 18.0 if heavy else 12.0

	for eye_x in [-8, 8]:
		for i in num_tears:
			var offset_x = -2 + i * 2.0
			var tear_start = hc + Vector2(eye_x + offset_x, 5) * s
			var tear_end = tear_start + Vector2(0, tear_length) * s
			draw_line(tear_start, tear_end, tear_color, 2.0 * s)
			# Tear droplet at end
			draw_circle(tear_end, 1.5 * s, tear_color)

func _draw_arms_reaching(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2, leanoff: float) -> void:
	match expression:
		Emotion.ANGRY:
			# Gesticulating wildly
			var elbow_l = sh_l + Vector2(-8, 16) * s + Vector2(leanoff * 0.3, 0)
			var hand_l = elbow_l + Vector2(-12, 12) * s + Vector2(leanoff * 0.2, 0)
			_draw_line_seg(sh_l, elbow_l, 2.2)
			_draw_line_seg(elbow_l, hand_l, 2.2)
			_draw_grabby_hand(hand_l, s)

			var elbow_r = sh_r + Vector2(8, 14) * s + Vector2(leanoff * 0.3, 0)
			var hand_r = elbow_r + Vector2(12, 14) * s + Vector2(leanoff * 0.2, 0)
			_draw_line_seg(sh_r, elbow_r, 2.2)
			_draw_line_seg(elbow_r, hand_r, 2.2)
			_draw_grabby_hand(hand_r, s)

			# Journal flying open with pages
			var journal_flying = sh_r + Vector2(18, -16) * s
			for pi in 2:
				var page_pts = PackedVector2Array([
					journal_flying + Vector2(-8 + pi * 6, 0) * s,
					journal_flying + Vector2(-6 + pi * 6, -8) * s,
					journal_flying + Vector2(4 + pi * 6, -8) * s,
					journal_flying + Vector2(2 + pi * 6, 0) * s,
				])
				draw_polyline(page_pts, DIM_COLOR, 0.8, true)

		_:
			# Default: both arms reaching toward you, hands open and grabby
			var elbow_l = sh_l + Vector2(-6, 20) * s + Vector2(leanoff * 0.4, 0)
			var hand_l = elbow_l + Vector2(-8, 14) * s + Vector2(leanoff * 0.3, 0)
			_draw_line_seg(sh_l, elbow_l, 2.2)
			_draw_line_seg(elbow_l, hand_l, 2.2)
			_draw_grabby_hand(hand_l, s)

			var elbow_r = sh_r + Vector2(6, 20) * s + Vector2(leanoff * 0.4, 0)
			var hand_r = elbow_r + Vector2(8, 14) * s + Vector2(leanoff * 0.3, 0)
			_draw_line_seg(sh_r, elbow_r, 2.2)
			_draw_line_seg(elbow_r, hand_r, 2.2)
			_draw_grabby_hand(hand_r, s)

func _draw_grabby_hand(pos: Vector2, s: float) -> void:
	# Open hand with splayed fingers, reaching out
	var palm_pts = PackedVector2Array([
		pos + Vector2(-3, 0) * s,
		pos + Vector2(-4, 4) * s,
		pos + Vector2(4, 4) * s,
		pos + Vector2(3, 0) * s,
	])
	draw_polyline(palm_pts, LINE_COLOR, 1.8, true)

	# Fingers reaching outward (above hand)
	var fingers = [
		Vector2(-4, -5) * s,
		Vector2(-2, -6) * s,
		Vector2(0, -6.5) * s,
		Vector2(2, -6) * s,
		Vector2(4, -5) * s,
	]
	for f in fingers:
		_draw_line_seg(pos + Vector2.DOWN * 1.5 * s, pos + f, 1.2)

func _draw_speech_fragments(hc: Vector2, s: float) -> void:
	# Word fragments floating around emotionally
	# Simple circles with text hints (actual text would be too complex to draw)
	var fragments = [
		hc + Vector2(-28, -12) * s,
		hc + Vector2(28, -16) * s,
		hc + Vector2(-20, 20) * s,
	]

	for frag_pos in fragments:
		# Thought bubble outline
		_draw_circle_outline(frag_pos, 6 * s, 1.2)
		# Small connector dot to head
		var connector = frag_pos.direction_to(hc) * 8.0 * s
		draw_circle(frag_pos - connector, 1.5 * s, LINE_COLOR)
		# Interior soft fill to suggest emotion
		draw_arc(frag_pos, 4 * s, 0, TAU, 12, Color(LINE_COLOR.r, LINE_COLOR.g, LINE_COLOR.b, 0.1), 0.5, true)
