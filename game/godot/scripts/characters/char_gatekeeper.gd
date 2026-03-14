extends StickCharacter
class_name CharGatekeeper
## The Gatekeeper. Immovable wall, blocking triangle of judgment.
## Signature: long beard, crossed arms over massive chest, loose robe, bare feet, intense stare.
## He's the barrier to Burning Man. Deep-set eyes, heavy brow, NO SMILE.
## Special trait: When scared, the Verizon guy underneath cracks through.

func _ready() -> void:
	accent_color = Color(0.25, 0.22, 0.55)  # dark indigo
	character_id = "gatekeeper"
	display_name = "The Gatekeeper"
	# Idle: very slow breathing, nearly motionless, intimidating presence
	_breath_scale = 2.0
	_breath_speed = 0.5
	_bob_amplitude = 0.2
	_bob_speed = 0.6
	custom_minimum_size = Vector2(160, 180)
	super._ready()

const INDIGO := Color(0.25, 0.22, 0.55)
const INDIGO_DIM := Color(0.25, 0.22, 0.55, 0.4)
const ROBE := Color(0.50, 0.48, 0.60)

func _draw_character(origin: Vector2, sc: float, breath: float, _lean: float) -> void:
	var o = origin
	var s = sc
	var br = breath * 6.0  # breathing expansion

	# ── Bare feet (grounded, immovable) ──
	var foot_l = o + Vector2(-18, 0) * s
	var foot_r = o + Vector2(18, 0) * s
	_draw_line_seg(foot_l + Vector2(-6, 0) * s, foot_l + Vector2(3, -3) * s, THIN_LINE)
	_draw_line_seg(foot_r + Vector2(-3, -3) * s, foot_r + Vector2(6, 0) * s, THIN_LINE)
	# Toe lines
	for i in 3:
		var tx_l = foot_l.x + (-3 + i * 3) * s
		var tx_r = foot_r.x + (-3 + i * 3) * s
		_draw_line_seg(Vector2(tx_l, foot_l.y), Vector2(tx_l, foot_l.y - 2 * s), HAIR_LINE)
		_draw_line_seg(Vector2(tx_r, foot_r.y), Vector2(tx_r, foot_r.y - 2 * s), HAIR_LINE)

	# ── Legs (sturdy, wide base) ──
	var hip = o + Vector2(0, -56) * s
	_draw_line_seg(foot_l, hip + Vector2(-12, 0) * s, 3.2)
	_draw_line_seg(foot_r, hip + Vector2(12, 0) * s, 3.2)

	# ── Robe: wide triangle, breathing expansion ──
	_draw_robe(o, hip, s, br)

	# ── Torso beneath robe ──
	var shoulder = o + Vector2(0, -88) * s
	_draw_line_seg(hip, shoulder, 2.8)

	# ── Shoulders: massively broad ──
	var sh_l = shoulder + Vector2(-32, 4) * s
	var sh_r = shoulder + Vector2(32, 4) * s
	draw_polyline(PackedVector2Array([
		sh_l,
		shoulder + Vector2(-10, 0) * s,
		shoulder + Vector2(10, 0) * s,
		sh_r
	]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms: ALWAYS CROSSED (unless SCARED) ──
	match expression:
		Emotion.SCARED:
			_draw_arms_broken(o, s, sh_l, sh_r)
		_:
			_draw_arms_crossed(o, s, sh_l, sh_r)

	# ── Neck: thick ──
	var neck_base = shoulder + Vector2(0, -2) * s
	var neck_top = shoulder + Vector2(0, -12) * s
	_draw_line_seg(neck_base, neck_top, 3.2)

	# ── Head: immobile stone ──
	var head_center = neck_top + Vector2(0, -20) * s
	var head_rx = 18.0 * s
	var head_ry = 20.0 * s
	_draw_head_oval(head_center, head_rx, head_ry)

	# ── Beard: long, flows down ──
	_draw_beard(head_center, s)

	# ── Face ──
	_draw_face(head_center, s)

func _draw_robe(o: Vector2, hip: Vector2, s: float, br: float) -> void:
	# Robe: wide flowing triangle that breathes outward
	var shoulder = o + Vector2(0, -88) * s
	var robe_pts = PackedVector2Array([
		shoulder + Vector2(-28, 4) * s,
		hip + Vector2(-32 - br, 0) * s,
		o + Vector2(-40 - br * 1.5, 0) * s,
		o + Vector2(40 + br * 1.5, 0) * s,
		hip + Vector2(32 + br, 0) * s,
		shoulder + Vector2(28, 4) * s,
	])
	draw_polyline(robe_pts, ROBE, 3.0, true)

	# Robe center seam (breathing with the character)
	_draw_line_seg(shoulder + Vector2(0, 4) * s, o + Vector2(0, 0) * s, THIN_LINE, INDIGO_DIM)

	# Robe side folds
	draw_polyline(PackedVector2Array([
		shoulder + Vector2(-20, 6) * s,
		hip + Vector2(-25 - br * 0.5, -2) * s,
		o + Vector2(-30 - br, 2) * s,
	]), INDIGO_DIM, HAIR_LINE, true)
	draw_polyline(PackedVector2Array([
		shoulder + Vector2(20, 6) * s,
		hip + Vector2(25 + br * 0.5, -2) * s,
		o + Vector2(30 + br, 2) * s,
	]), INDIGO_DIM, HAIR_LINE, true)

func _draw_head_oval(center: Vector2, rx: float, ry: float) -> void:
	var points := PackedVector2Array()
	for i in 49:
		var angle = float(i) / 48.0 * TAU
		points.append(center + Vector2(cos(angle) * rx, sin(angle) * ry))
	draw_polyline(points, LINE_COLOR, LINE_WIDTH, true)

func _draw_beard(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.SCARED:
			# Beard falls apart, showing scared Verizon guy underneath
			_draw_line_seg(hc + Vector2(-8, 8) * s, hc + Vector2(-6, 16) * s, 2.0)
			_draw_line_seg(hc + Vector2(0, 10) * s, hc + Vector2(0, 16) * s, 1.8)
			_draw_line_seg(hc + Vector2(8, 8) * s, hc + Vector2(6, 16) * s, 2.0)
			# Falling apart effect
			draw_circle(hc + Vector2(-12, 14) * s, 2 * s, Color(0.18, 0.16, 0.13, 0.4))
			draw_circle(hc + Vector2(12, 12) * s, 1.8 * s, Color(0.18, 0.16, 0.13, 0.4))
		_:
			# Full long beard, maintained and intimidating
			var beard_pts = PackedVector2Array([
				hc + Vector2(-10, 8) * s,
				hc + Vector2(-8, 14) * s,
				hc + Vector2(-6, 20) * s,
				hc + Vector2(-2, 22) * s,
				hc + Vector2(0, 24) * s,
				hc + Vector2(2, 22) * s,
				hc + Vector2(6, 20) * s,
				hc + Vector2(8, 14) * s,
				hc + Vector2(10, 8) * s,
			])
			draw_polyline(beard_pts, LINE_COLOR, 2.8, true)

			# Beard texture lines
			_draw_line_seg(hc + Vector2(-6, 10) * s, hc + Vector2(-5, 16) * s, HAIR_LINE)
			_draw_line_seg(hc + Vector2(-2, 11) * s, hc + Vector2(-1, 18) * s, HAIR_LINE)
			_draw_line_seg(hc + Vector2(2, 11) * s, hc + Vector2(1, 18) * s, HAIR_LINE)
			_draw_line_seg(hc + Vector2(6, 10) * s, hc + Vector2(5, 16) * s, HAIR_LINE)

func _draw_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			# Judging stare, deep-set eyes, no smile
			_draw_circle_outline(hc + Vector2(-8, -1) * s, 4.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(-8, 0) * s, 2.0 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(8, -1) * s, 4.5 * s, THIN_LINE)
			draw_circle(hc + Vector2(8, 0) * s, 2.0 * s, LINE_COLOR)

			# Heavy brow (thunderous)
			_draw_line_seg(hc + Vector2(-14, -7) * s, hc + Vector2(-2, -8) * s, 3.0)
			_draw_line_seg(hc + Vector2(2, -8) * s, hc + Vector2(14, -7) * s, 3.0)

			# No mouth line (perpetual judgment)
			pass

		Emotion.HAPPY:
			# Slight nod of approval (rare, very rare)
			draw_circle(hc + Vector2(-8, 0) * s, 1.8 * s, LINE_COLOR)
			draw_circle(hc + Vector2(8, 0) * s, 1.8 * s, LINE_COLOR)
			# Slightly softer brows
			_draw_line_seg(hc + Vector2(-14, -6) * s, hc + Vector2(-2, -7) * s, 2.2)
			_draw_line_seg(hc + Vector2(2, -7) * s, hc + Vector2(14, -6) * s, 2.2)
			# Very faint hint of mouth (impossible to see approval)
			_draw_line_seg(hc + Vector2(-3, 9) * s, hc + Vector2(3, 9) * s, 0.8, Color(0.18, 0.16, 0.13, 0.2))

		Emotion.ANGRY:
			# Brow THUNDERS DOWN, massive anger
			_draw_circle_outline(hc + Vector2(-8, -1) * s, 4.8 * s, 2.0)
			draw_circle(hc + Vector2(-8, 0) * s, 2.2 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(8, -1) * s, 4.8 * s, 2.0)
			draw_circle(hc + Vector2(8, 0) * s, 2.2 * s, LINE_COLOR)

			# THUNDEROUS BROW
			_draw_line_seg(hc + Vector2(-16, -4) * s, hc + Vector2(-2, -10) * s, 3.5)
			_draw_line_seg(hc + Vector2(2, -10) * s, hc + Vector2(16, -4) * s, 3.5)

			# Tightly pressed mouth
			_draw_line_seg(hc + Vector2(-6, 9) * s, hc + Vector2(6, 9) * s, 2.5)

		Emotion.SCARED:
			# The Verizon guy cracks through — eyes widen in fear
			_draw_circle_outline(hc + Vector2(-8, -1) * s, 5.5 * s, 1.8)
			draw_circle(hc + Vector2(-8, 0) * s, 2.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(8, -1) * s, 5.5 * s, 1.8)
			draw_circle(hc + Vector2(8, 0) * s, 2.5 * s, LINE_COLOR)

			# Brows soften (crack in the facade)
			draw_arc(hc + Vector2(-8, -6) * s, 5 * s, PI + 0.3, TAU - 0.3, 10, LINE_COLOR, 1.5, true)
			draw_arc(hc + Vector2(8, -6) * s, 5 * s, PI + 0.3, TAU - 0.3, 10, LINE_COLOR, 1.5, true)

			# Vulnerable O mouth (scared)
			_draw_circle_outline(hc + Vector2(0, 10) * s, 3.5 * s, 1.5)

		Emotion.SPECIAL:
			# Steps aside — defeated, accepting his fate
			# Eyes half-closed (resignation)
			draw_arc(hc + Vector2(-8, 0) * s, 4 * s, PI + 0.2, TAU - 0.2, 10, LINE_COLOR, 1.8, true)
			draw_circle(hc + Vector2(-8, 1) * s, 1.2 * s, LINE_COLOR)
			draw_arc(hc + Vector2(8, 0) * s, 4 * s, PI + 0.2, TAU - 0.2, 10, LINE_COLOR, 1.8, true)
			draw_circle(hc + Vector2(8, 1) * s, 1.2 * s, LINE_COLOR)

			# Softened brows (acceptance)
			_draw_line_seg(hc + Vector2(-12, -5) * s, hc + Vector2(-2, -6) * s, 1.8)
			_draw_line_seg(hc + Vector2(2, -6) * s, hc + Vector2(12, -5) * s, 1.8)

			# Faint sad line (has given up the gate)
			draw_arc(hc + Vector2(0, 9) * s, 3 * s, PI + 0.2, TAU - 0.2, 8, DIM_COLOR, 1.0, true)

func _draw_arms_crossed(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Arms ALWAYS crossed over massive chest
	# Left arm: across body
	var elbow_l = sh_l + Vector2(-8, 28) * s
	var hand_l = elbow_l + Vector2(20, 4) * s
	_draw_line_seg(sh_l, elbow_l, 3.5)
	_draw_line_seg(elbow_l, hand_l, 3.2)

	# Right arm: on top, across
	var elbow_r = sh_r + Vector2(8, 24) * s
	var hand_r = elbow_r + Vector2(-20, 8) * s
	_draw_line_seg(sh_r, elbow_r, 3.5)
	_draw_line_seg(elbow_r, hand_r, 3.2)

	# Show the crossed pose with heavier lines
	draw_circle(hand_l, 3.5 * s, DIM_COLOR)
	draw_circle(hand_r, 3.5 * s, DIM_COLOR)

func _draw_arms_broken(o: Vector2, s: float, sh_l: Vector2, sh_r: Vector2) -> void:
	# Scared: arms drop, posture breaks
	var elbow_l = sh_l + Vector2(-4, 32) * s
	var hand_l = elbow_l + Vector2(-2, 18) * s
	_draw_line_seg(sh_l, elbow_l, 3.0)
	_draw_line_seg(elbow_l, hand_l, 2.8)

	var elbow_r = sh_r + Vector2(4, 30) * s
	var hand_r = elbow_r + Vector2(2, 20) * s
	_draw_line_seg(sh_r, elbow_r, 3.0)
	_draw_line_seg(elbow_r, hand_r, 2.8)

	# Hands trembling/weak
	draw_circle(hand_l, 2.5 * s, DIM_COLOR)
	draw_circle(hand_r, 2.5 * s, DIM_COLOR)
