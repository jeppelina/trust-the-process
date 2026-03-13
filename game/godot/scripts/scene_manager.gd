extends Node
## Handles scene transitions with optional fade effects.

signal transition_started()
signal transition_finished()

var _fade_rect: ColorRect

func _ready() -> void:
	# Create a full-screen fade overlay
	var canvas = CanvasLayer.new()
	canvas.layer = 100
	add_child(canvas)

	_fade_rect = ColorRect.new()
	_fade_rect.color = Color(0, 0, 0, 0)
	_fade_rect.mouse_filter = Control.MOUSE_FILTER_IGNORE
	_fade_rect.set_anchors_preset(Control.PRESET_FULL_RECT)
	canvas.add_child(_fade_rect)

func change_scene(scene_path: String, fade_duration: float = 0.3) -> void:
	transition_started.emit()
	if fade_duration > 0:
		var tween = create_tween()
		tween.tween_property(_fade_rect, "color:a", 1.0, fade_duration)
		await tween.finished
	get_tree().change_scene_to_file(scene_path)
	if fade_duration > 0:
		var tween = create_tween()
		tween.tween_property(_fade_rect, "color:a", 0.0, fade_duration)
		await tween.finished
	transition_finished.emit()
