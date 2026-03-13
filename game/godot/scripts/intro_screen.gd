extends Control
## Intro sequence: cinematic text screens telling Steve's backstory.

@onready var text_label: RichTextLabel = %IntroText
@onready var prompt_label: Label = %IntroPrompt

var pages: Array[String] = [
	"You are Steve Stevens.\n\nYou are 38 years old. You work in accounting.\nYou are adequate at your job.\nYou are adequate at most things.",

	"Three weeks ago, your wife went to an\nAyahuasca retreat in the mountains.\n\nShe said it would be \"just a weekend.\"\nShe said she'd be back by Monday.",

	"She did not come back by Monday.\n\nShe texted: \"I need more time.\nSomething is opening inside me.\"\n\nSteve did not know what was opening.\nSteve did not want to know.",

	"Then the texts stopped.\n\nThe credit card did not stop.\n$2,400 — \"Transformational Immersion.\"\n$800 — \"Sacred Sound Healing Intensive.\"\n$340 — \"Artisanal Cacao Ceremony Kit.\"\n\nSteve does not know what artisanal cacao is.\nSteve knows what $3,540 is.",

	"You have tracked the charges to a place called\n\"The Sanctuary of Infinite Becoming.\"\n\nIt used to be a golf course.\n\nYou have packed sensible shoes, a change of\nclothes, and the quiet certainty of a man\nwho has filed fourteen years of tax returns\nwithout a single error.",

	"You are going to find your wife.\n\nYou are going to bring her home.\n\nYou are not going to \"open\" anything."
]

var current_page: int = 0
var _typing: bool = false
var _full_text: String = ""
var _char_index: int = 0
var _type_timer: float = 0.0
var _blink_time: float = 0.0

const TYPE_SPEED: float = 0.03  # seconds per character

func _ready() -> void:
	prompt_label.visible = false
	_show_page()

func _process(delta: float) -> void:
	if _typing:
		_type_timer += delta
		while _type_timer >= TYPE_SPEED and _char_index < _full_text.length():
			_type_timer -= TYPE_SPEED
			_char_index += 1
			text_label.text = _full_text.substr(0, _char_index)
		if _char_index >= _full_text.length():
			_typing = false
			prompt_label.visible = true

	if prompt_label.visible:
		_blink_time += delta
		prompt_label.modulate.a = 0.3 + 0.7 * abs(sin(_blink_time * 2.5))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") or (event is InputEventMouseButton and event.pressed):
		if _typing:
			# Skip typewriter, show full text
			_typing = false
			_char_index = _full_text.length()
			text_label.text = _full_text
			prompt_label.visible = true
		else:
			current_page += 1
			if current_page >= pages.size():
				SceneManager.change_scene("res://scenes/exploration.tscn")
			else:
				_show_page()

func _show_page() -> void:
	_full_text = pages[current_page]
	_char_index = 0
	_type_timer = 0.0
	_typing = true
	text_label.text = ""
	prompt_label.visible = false
