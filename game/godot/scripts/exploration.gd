extends Control
## Main exploration scene: rooms, NPC interaction, dialogue, HUD, navigation.

# ── HUD References ──
@onready var hp_bar: ProgressBar = %HPBar
@onready var hp_label: Label = %HPLabel
@onready var ep_bar: ProgressBar = %EPBar
@onready var ep_label: Label = %EPLabel
@onready var norm_bar: ProgressBar = %NormBar
@onready var insight_label: Label = %InsightLabel
@onready var cacao_label: Label = %CacaoLabel

# ── Scene Area ──
@onready var scene_bg: ColorRect = %SceneBG
@onready var location_label: Label = %LocationLabel
@onready var npc_container: HBoxContainer = %NPCContainer
@onready var nav_left: Button = %NavLeft
@onready var nav_right: Button = %NavRight

# ── Dialogue Area ──
@onready var speaker_label: Label = %SpeakerLabel
@onready var dialogue_label: RichTextLabel = %DialogueText
@onready var choices_container: VBoxContainer = %ChoicesContainer
@onready var continue_prompt: Label = %ContinuePrompt
@onready var dialogue_box: PanelContainer = %DialogueBox

# ── Room Definitions ──
var rooms: Dictionary = {
	"pavilion": {
		"name": "THE WELCOME PAVILION",
		"color": Color(0.1, 0.14, 0.1),
		"npcs": [
			{"id": "receptionist", "label": "Receptionist", "emoji": "🧘‍♀️"}
		],
		"nav_left": "",
		"nav_right": "path",
		"enter_text": "The air smells like nag champa and broken expectations. A woman sits behind a desk decorated with crystals and a very normal Dell laptop."
	},
	"path": {
		"name": "THE GARDEN PATH",
		"color": Color(0.1, 0.14, 0.14),
		"npcs": [
			{"id": "oil_warrior", "label": "???", "emoji": "🧴", "hide_flag": "oil_defeated"}
		],
		"nav_left": "pavilion",
		"nav_right": "garden",
		"enter_text": "A gravel path winds between prayer flags and hand-painted signs that say things like \"You Are Enough\" and \"Please Compost.\""
	},
	"garden": {
		"name": "THE SACRED GARDEN",
		"color": Color(0.06, 0.1, 0.06),
		"npcs": [
			{"id": "frank", "label": "Groundskeeper", "emoji": "👷"}
		],
		"nav_left": "path",
		"nav_right": "",
		"enter_text": "A quiet garden with meditation cushions, crystal grids, and a man in overalls fixing a fence. He is the first normal thing you've seen."
	}
}

var current_room_id: String = "pavilion"
var _dialogue_waiting: bool = false
var _typing: bool = false
var _full_text: String = ""
var _char_index: int = 0
var _type_timer: float = 0.0
var _blink_time: float = 0.0

const TYPE_SPEED: float = 0.025

func _ready() -> void:
	# Connect signals
	DialogueManager.dialogue_line_shown.connect(_on_dialogue_line)
	DialogueManager.choices_shown.connect(_on_choices_shown)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)
	GameState.hp_changed.connect(_update_hud)
	GameState.ep_changed.connect(_update_hud)
	GameState.normality_changed.connect(_update_hud)
	GameState.insight_changed.connect(_update_hud)
	GameState.cacao_changed.connect(_update_hud)
	GameState.flag_set.connect(_on_flag_set)

	nav_left.pressed.connect(_on_nav_left)
	nav_right.pressed.connect(_on_nav_right)

	_update_hud(0)
	enter_room(GameState.current_room_id)

func _process(delta: float) -> void:
	if _typing:
		_type_timer += delta
		while _type_timer >= TYPE_SPEED and _char_index < _full_text.length():
			_type_timer -= TYPE_SPEED
			_char_index += 1
			dialogue_label.text = _full_text.substr(0, _char_index)
		if _char_index >= _full_text.length():
			_typing = false
			_dialogue_waiting = true
			continue_prompt.visible = true

	if continue_prompt.visible:
		_blink_time += delta
		continue_prompt.modulate.a = 0.3 + 0.7 * abs(sin(_blink_time * 2.5))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_handle_advance()
	if event.is_action_pressed("move_left"):
		_on_nav_left()
	if event.is_action_pressed("move_right"):
		_on_nav_right()

func _handle_advance() -> void:
	if _typing:
		# Complete typewriter instantly
		_typing = false
		_char_index = _full_text.length()
		dialogue_label.text = _full_text
		_dialogue_waiting = true
		continue_prompt.visible = true
	elif _dialogue_waiting:
		_dialogue_waiting = false
		continue_prompt.visible = false
		DialogueManager.advance()

# ── Room Management ──
func enter_room(room_id: String) -> void:
	current_room_id = room_id
	GameState.current_room_id = room_id
	var room = rooms[room_id]

	# Update visuals
	scene_bg.color = room["color"]
	location_label.text = room["name"]

	# Navigation
	nav_left.visible = room["nav_left"] != ""
	nav_right.visible = room["nav_right"] != ""

	# NPCs
	_populate_npcs(room)

	# Enter text
	_show_room_text(room["enter_text"])

func _populate_npcs(room: Dictionary) -> void:
	# Clear existing
	for child in npc_container.get_children():
		child.queue_free()

	for npc in room["npcs"]:
		# Check if this NPC should be hidden
		if npc.has("hide_flag") and GameState.has_flag(npc["hide_flag"]):
			continue

		var btn = Button.new()
		btn.text = npc["emoji"] + "\n" + npc["label"]
		btn.custom_minimum_size = Vector2(120, 100)
		btn.add_theme_font_size_override("font_size", 16)

		# Style the button
		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.15, 0.12, 0.08, 0.6)
		style.border_color = Color(0.3, 0.25, 0.15)
		style.set_border_width_all(1)
		style.set_corner_radius_all(4)
		btn.add_theme_stylebox_override("normal", style)

		var hover_style = style.duplicate()
		hover_style.bg_color = Color(0.25, 0.2, 0.12, 0.8)
		hover_style.border_color = Color(0.83, 0.64, 0.29)
		btn.add_theme_stylebox_override("hover", hover_style)
		btn.add_theme_color_override("font_color", Color(0.83, 0.64, 0.29))
		btn.add_theme_color_override("font_hover_color", Color(1.0, 0.85, 0.5))

		var npc_id = npc["id"]
		btn.pressed.connect(_on_npc_clicked.bind(npc_id))
		npc_container.add_child(btn)

func _on_npc_clicked(npc_id: String) -> void:
	if DialogueManager.is_active:
		return

	# Check for return dialogues
	match npc_id:
		"receptionist":
			if GameState.has_flag("talked_receptionist"):
				DialogueManager.start_dialogue("receptionist_return")
				return
		"frank":
			if GameState.has_flag("talked_frank"):
				DialogueManager.start_dialogue("frank_return")
				return

	DialogueManager.start_dialogue(npc_id)

func _on_nav_left() -> void:
	if DialogueManager.is_active:
		return
	var room = rooms[current_room_id]
	if room["nav_left"] != "":
		enter_room(room["nav_left"])

func _on_nav_right() -> void:
	if DialogueManager.is_active:
		return
	var room = rooms[current_room_id]
	if room["nav_right"] != "":
		enter_room(room["nav_right"])

# ── Dialogue Display ──
func _show_room_text(text: String) -> void:
	speaker_label.text = ""
	_start_typewriter(text, true)

func _on_dialogue_line(speaker: String, text: String, is_thought: bool) -> void:
	speaker_label.text = speaker
	choices_container.visible = false
	_start_typewriter(text, is_thought)

func _start_typewriter(text: String, is_thought: bool) -> void:
	_full_text = text
	_char_index = 0
	_type_timer = 0.0
	_typing = true
	_dialogue_waiting = false
	continue_prompt.visible = false

	if is_thought:
		dialogue_label.add_theme_color_override("default_color", Color(0.48, 0.54, 0.48))
	else:
		dialogue_label.add_theme_color_override("default_color", Color(0.75, 0.72, 0.6))
	dialogue_label.text = ""

func _on_choices_shown(choices: Array) -> void:
	speaker_label.text = ""
	dialogue_label.text = ""
	continue_prompt.visible = false
	_dialogue_waiting = false
	_typing = false

	# Clear old choices
	for child in choices_container.get_children():
		child.queue_free()

	choices_container.visible = true

	for i in choices.size():
		var btn = Button.new()
		btn.text = choices[i]["text"]
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.add_theme_font_size_override("font_size", 18)

		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.15, 0.12, 0.06, 0.6)
		style.border_color = Color(0.35, 0.3, 0.17)
		style.set_border_width_all(1)
		style.set_corner_radius_all(2)
		style.content_margin_left = 12
		style.content_margin_right = 12
		style.content_margin_top = 6
		style.content_margin_bottom = 6
		btn.add_theme_stylebox_override("normal", style)

		var hover_style = style.duplicate()
		hover_style.bg_color = Color(0.25, 0.2, 0.1, 0.8)
		hover_style.border_color = Color(0.83, 0.64, 0.29)
		btn.add_theme_stylebox_override("hover", hover_style)
		btn.add_theme_color_override("font_color", Color(0.83, 0.64, 0.29))
		btn.add_theme_color_override("font_hover_color", Color(1.0, 0.85, 0.5))

		var idx = i
		btn.pressed.connect(func(): _on_choice_selected(idx))
		choices_container.add_child(btn)

func _on_choice_selected(index: int) -> void:
	choices_container.visible = false
	DialogueManager.select_choice(index)

func _on_dialogue_finished() -> void:
	# Check if battle should start
	if GameState.has_flag("start_oil_battle"):
		GameState.flags.erase("start_oil_battle")
		SceneManager.change_scene("res://scenes/battle.tscn")

# ── HUD ──
func _update_hud(_value = null) -> void:
	hp_bar.value = float(GameState.hp) / float(GameState.max_hp) * 100.0
	hp_label.text = str(GameState.hp)
	ep_bar.value = float(GameState.ep) / float(GameState.max_ep) * 100.0
	ep_label.text = str(GameState.ep)
	norm_bar.value = GameState.normality
	insight_label.text = "INSIGHT: " + str(GameState.insight)
	cacao_label.text = "🫘 " + str(GameState.cacao)

func _on_flag_set(flag_name: String) -> void:
	# Refresh NPCs when flags change (e.g., oil_defeated hides the warrior)
	if rooms.has(current_room_id):
		_populate_npcs(rooms[current_room_id])
