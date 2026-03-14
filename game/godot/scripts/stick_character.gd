extends Control
class_name StickCharacter
## Base class for all stick figure characters. Subclass and override _draw_character().
## Handles shared logic: idle animation, expressions, hover glow, reactions.

# ── Exports ──
@export var accent_color: Color = Color(0.83, 0.64, 0.29)
@export var character_id: String = ""
@export var display_name: String = ""

# ── Emotion & Pose ──
enum Emotion { NEUTRAL, HAPPY, ANGRY, SCARED, SPECIAL }
enum Pose { IDLE, TALK, ATTACK, HIT }

var expression: Emotion = Emotion.NEUTRAL
var pose: Pose = Pose.IDLE

# ── Drawing Constants ──
const DRAW_SCALE := 1.8                              # canvas scale — makes figures fill the container
const LINE_COLOR := Color(0.18, 0.16, 0.13)         # dark charcoal — reads on bright BGs
const LINE_WIDTH := 2.8
const THIN_LINE := 1.8
const HAIR_LINE := 1.2
const DIM_COLOR := Color(0.35, 0.32, 0.27)          # muted brown for secondary details
const BG_DIM := Color(0.35, 0.32, 0.27, 0.25)

# ── Animation State ──
var _idle_time: float = 0.0
var _hover: bool = false
var _reaction_offset := Vector2.ZERO
var _appear_scale: float = 0.0
var _bob_amplitude: float = 2.0
var _bob_speed: float = 1.5
var _sway_amplitude: float = 0.0
var _sway_speed: float = 0.0
var _breath_scale: float = 0.0
var _breath_speed: float = 0.0
var _lean_amplitude: float = 0.0
var _lean_speed: float = 0.0

# ── Signals ──
signal character_clicked(id: String)

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	# Appear animation
	var tween = create_tween()
	tween.tween_property(self, "_appear_scale", 1.0, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BACK)
	custom_minimum_size = Vector2(240, 240)

func _process(delta: float) -> void:
	_idle_time += delta
	queue_redraw()

func _draw() -> void:
	# Calculate idle animation offsets
	var bob_y = sin(_idle_time * _bob_speed) * _bob_amplitude
	var sway_x = sin(_idle_time * _sway_speed) * _sway_amplitude
	var breath = sin(_idle_time * _breath_speed) * _breath_scale
	var lean = sin(_idle_time * _lean_speed) * _lean_amplitude

	var scale_f = _appear_scale

	# Hover glow (drawn in unscaled space)
	if _hover:
		draw_circle(Vector2(size.x / 2.0, size.y / 2.0), 80, Color(accent_color.r, accent_color.g, accent_color.b, 0.08))

	# Apply canvas transform: scale from bottom-center anchor
	# Characters draw upward from origin (0,0) = feet, so we anchor at bottom-center
	var anchor = Vector2(size.x / 2.0, size.y - 10.0)
	var ds = DRAW_SCALE
	draw_set_transform(anchor, 0, Vector2(ds, ds))

	# Idle animation offsets in local (pre-scale) space
	var local_offset = (Vector2(sway_x, bob_y) + _reaction_offset) / ds

	# Call subclass drawing at origin (0,0) + tiny idle offsets
	if scale_f > 0.01:
		_draw_character(local_offset, scale_f, breath, lean)

	# Reset transform
	draw_set_transform(Vector2.ZERO)

func _draw_character(_origin: Vector2, _scale: float, _breath: float, _lean: float) -> void:
	# Override in subclass
	pass

# ── Hover / Click ──
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		character_clicked.emit(character_id)

func _notification(what: int) -> void:
	if what == NOTIFICATION_MOUSE_ENTER:
		_hover = true
	elif what == NOTIFICATION_MOUSE_EXIT:
		_hover = false

# ── Reactions ──
func react_shake() -> void:
	var tween = create_tween()
	tween.tween_property(self, "_reaction_offset", Vector2(4, 0), 0.05)
	tween.tween_property(self, "_reaction_offset", Vector2(-4, 0), 0.05)
	tween.tween_property(self, "_reaction_offset", Vector2(3, 0), 0.05)
	tween.tween_property(self, "_reaction_offset", Vector2(-3, 0), 0.05)
	tween.tween_property(self, "_reaction_offset", Vector2.ZERO, 0.05)

func react_bounce() -> void:
	var tween = create_tween()
	tween.tween_property(self, "_reaction_offset", Vector2(0, -8), 0.12).set_ease(Tween.EASE_OUT)
	tween.tween_property(self, "_reaction_offset", Vector2.ZERO, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)

func set_expression(expr: Emotion) -> void:
	expression = expr
	queue_redraw()

func set_pose(p: Pose) -> void:
	pose = p
	queue_redraw()

# ── Drawing Helpers ──
func _draw_line_seg(from: Vector2, to: Vector2, width: float = LINE_WIDTH, color: Color = LINE_COLOR) -> void:
	draw_line(from, to, color, width, true)

func _draw_circle_outline(center: Vector2, radius: float, width: float = LINE_WIDTH, color: Color = LINE_COLOR) -> void:
	draw_arc(center, radius, 0, TAU, 48, color, width, true)

func _draw_arc_seg(center: Vector2, radius: float, start_angle: float, end_angle: float, width: float = THIN_LINE, color: Color = LINE_COLOR) -> void:
	draw_arc(center, radius, start_angle, end_angle, 24, color, width, true)
