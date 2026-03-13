extends Control
## Title screen: "TRUST THE PROCESS" — press space/click to begin.

@onready var prompt_label: Label = %PromptLabel

var _blink_time: float = 0.0

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	_blink_time += delta
	prompt_label.modulate.a = 0.3 + 0.7 * abs(sin(_blink_time * 2.5))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or (event is InputEventMouseButton and event.pressed):
		SceneManager.change_scene("res://scenes/intro_screen.tscn")
