extends StickCharacter
class_name CharGenericNPC
## A simple, customizable stick figure NPC for minor characters.
## Configured via properties rather than a unique subclass.

enum BodyType { NORMAL, WIDE, THIN, SHORT }

@export var body_type: BodyType = BodyType.NORMAL
@export var has_hair: bool = true
@export var hair_style: int = 0  # 0=short, 1=long, 2=bun, 3=bald
@export var prop_text: String = ""  # emoji or symbol for held prop

func _ready() -> void:
	_bob_amplitude = 1.5
	_bob_speed = 1.3
	super._ready()

func _draw_character(origin: Vector2, sc: float, _breath: float, _lean: float) -> void:
	var o = origin
	var s = sc

	var width_mult = 1.0
	var height_mult = 1.0
	match body_type:
		BodyType.WIDE:
			width_mult = 1.4
		BodyType.THIN:
			width_mult = 0.7
		BodyType.SHORT:
			height_mult = 0.8
			width_mult = 1.1

	# ── Feet ──
	var spread = 10 * width_mult
	_draw_line_seg(o + Vector2(-spread - 4, 0) * s, o + Vector2(-spread + 4, -3) * s)
	_draw_line_seg(o + Vector2(spread - 4, -3) * s, o + Vector2(spread + 4, 0) * s)

	# ── Legs ──
	var hip = o + Vector2(0, -45 * height_mult) * s
	_draw_line_seg(o + Vector2(-spread, 0) * s, hip + Vector2(-4, 0) * s, 2.5)
	_draw_line_seg(o + Vector2(spread, 0) * s, hip + Vector2(4, 0) * s, 2.5)

	# ── Torso ──
	var shoulder = o + Vector2(0, -78 * height_mult) * s
	_draw_line_seg(hip, shoulder, 2.5)

	# ── Shoulders ──
	var sh_w = 18 * width_mult
	var sh_l = shoulder + Vector2(-sh_w, 5) * s
	var sh_r = shoulder + Vector2(sh_w, 5) * s
	draw_polyline(PackedVector2Array([sh_l, shoulder + Vector2(0, -2) * s, sh_r]), LINE_COLOR, LINE_WIDTH, true)

	# ── Arms: simple hanging ──
	var elbow_l = sh_l + Vector2(-3, 20) * s
	var hand_l = elbow_l + Vector2(2, 14) * s
	_draw_line_seg(sh_l, elbow_l)
	_draw_line_seg(elbow_l, hand_l)

	var elbow_r = sh_r + Vector2(3, 20) * s
	var hand_r = elbow_r + Vector2(-2, 14) * s
	_draw_line_seg(sh_r, elbow_r)
	_draw_line_seg(elbow_r, hand_r)

	# ── Neck ──
	var neck_top = shoulder + Vector2(0, -10) * s
	_draw_line_seg(shoulder, neck_top, 2.0)

	# ── Head ──
	var hc = neck_top + Vector2(0, -15 * height_mult) * s
	_draw_circle_outline(hc, 14 * s)

	# ── Hair ──
	match hair_style:
		0:  # Short
			draw_arc(hc, 15 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, 2.0, true)
		1:  # Long
			draw_polyline(PackedVector2Array([
				hc + Vector2(-14, -4) * s, hc + Vector2(-16, 10) * s,
				hc + Vector2(-14, 22) * s,
			]), LINE_COLOR, 2.0, true)
			draw_polyline(PackedVector2Array([
				hc + Vector2(14, -4) * s, hc + Vector2(16, 10) * s,
				hc + Vector2(14, 22) * s,
			]), LINE_COLOR, 2.0, true)
			draw_arc(hc, 15 * s, PI + 0.4, TAU - 0.4, 12, LINE_COLOR, 2.0, true)
		2:  # Bun
			draw_arc(hc, 15 * s, PI + 0.3, TAU - 0.3, 12, LINE_COLOR, 2.0, true)
			_draw_circle_outline(hc + Vector2(0, -18) * s, 6 * s, 2.0)
		3:  # Bald
			pass  # Just the circle

	# ── Face: simple version ──
	_draw_simple_face(hc, s)

	# ── Name tag (accent colored) ──
	var tag_pos = shoulder + Vector2(-8, 6) * s
	draw_rect(Rect2(tag_pos, Vector2(16, 8) * s), Color(accent_color, 0.6), true)
	draw_rect(Rect2(tag_pos, Vector2(16, 8) * s), accent_color, false, 1.0)

func _draw_simple_face(hc: Vector2, s: float) -> void:
	match expression:
		Emotion.NEUTRAL:
			draw_circle(hc + Vector2(-4, -1) * s, 1.5 * s, LINE_COLOR)
			draw_circle(hc + Vector2(4, -1) * s, 1.5 * s, LINE_COLOR)
			_draw_line_seg(hc + Vector2(-3, 6) * s, hc + Vector2(3, 6) * s, 1.3)

		Emotion.HAPPY:
			_draw_line_seg(hc + Vector2(-6, -1) * s, hc + Vector2(-2, -1) * s, 1.8)
			_draw_line_seg(hc + Vector2(2, -1) * s, hc + Vector2(6, -1) * s, 1.8)
			draw_arc(hc + Vector2(0, 4) * s, 5 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.3, true)

		Emotion.ANGRY:
			draw_circle(hc + Vector2(-4, -1) * s, 1.5 * s, LINE_COLOR)
			draw_circle(hc + Vector2(4, -1) * s, 1.5 * s, LINE_COLOR)
			_draw_line_seg(hc + Vector2(-8, -4) * s, hc + Vector2(-1, -6) * s, 1.8)
			_draw_line_seg(hc + Vector2(1, -6) * s, hc + Vector2(8, -4) * s, 1.8)
			draw_arc(hc + Vector2(0, 8) * s, 4 * s, PI + 0.3, TAU - 0.3, 8, LINE_COLOR, 1.3, true)

		Emotion.SCARED:
			_draw_circle_outline(hc + Vector2(-4, -1) * s, 3 * s, 1.2)
			draw_circle(hc + Vector2(-4, 0) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(4, -1) * s, 3 * s, 1.2)
			draw_circle(hc + Vector2(4, 0) * s, 1.5 * s, LINE_COLOR)
			_draw_circle_outline(hc + Vector2(0, 7) * s, 3 * s, 1.3)

		Emotion.SPECIAL:
			draw_circle(hc + Vector2(-4, -1) * s, 2 * s, LINE_COLOR)
			draw_circle(hc + Vector2(4, -1) * s, 2 * s, LINE_COLOR)
			draw_arc(hc + Vector2(0, 4) * s, 5 * s, 0.2, PI - 0.2, 12, LINE_COLOR, 1.5, true)
