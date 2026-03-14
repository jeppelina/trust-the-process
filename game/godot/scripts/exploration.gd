extends Control
## Main exploration scene: 10-room Sanctuary, multi-directional navigation, NPC interaction, dialogue, HUD.

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
@onready var scenery_drawer = %SceneryDrawer

# ── Dialogue Area ──
@onready var speaker_label: Label = %SpeakerLabel
@onready var dialogue_label: RichTextLabel = %DialogueText
@onready var choices_container: VBoxContainer = %ChoicesContainer
@onready var continue_prompt: Label = %ContinuePrompt
@onready var click_area: Button = %ClickArea

# ── Speaker Colors ──
# Each speaker gets a unique color for their name in the dialogue panel
# Speaker colors — vivid, saturated tones that POP on white panels
const SPEAKER_COLORS: Dictionary = {
	"Steve": Color(0.13, 0.55, 0.13),           # strong green — spreadsheet guy
	"Receptionist": Color(0.80, 0.45, 0.0),     # vivid amber-orange
	"Essential Oil Warrior": Color(0.82, 0.12, 0.40),  # hot pink-rose
	"???": Color(0.82, 0.12, 0.40),             # same as oil warrior (pre-reveal)
	"Frank": Color(0.42, 0.42, 0.42),           # solid gray — grounded
	"Breathwork Monk": Color(0.10, 0.35, 0.78), # vivid blue
	"Cacao Dealer": Color(0.18, 0.62, 0.18),    # rich green
	"The Founder": Color(0.78, 0.55, 0.0),      # bold gold
	"Maya": Color(0.72, 0.35, 0.15),            # warm terracotta
	"Brandon": Color(0.10, 0.55, 0.55),         # teal
	"Dharma John": Color(0.30, 0.25, 0.55),     # dark indigo
	"Gatekeeper": Color(0.65, 0.15, 0.15),      # deep crimson
	"Competitive Meditator": Color(0.50, 0.20, 0.60),  # purple
	"Meditator": Color(0.50, 0.20, 0.60),  # same as competitive meditator
	"Facilitator": Color(0.55, 0.45, 0.20),  # warm brown
	"The Oversharer": Color(0.75, 0.35, 0.55),  # pink
}
const DEFAULT_SPEAKER_COLOR := Color(0.30, 0.30, 0.30)

# ── Room Definitions ──
# Each room has: name, color, npcs, exits (array of direction dicts), enter_text
# Exits format: [{"label": "X", "room": "x", "require": "flag_name"}, ...]
#   - "require" is optional; if present, only show exit if player has that flag
var rooms: Dictionary = {
	"pavilion": {
		"name": "THE WELCOME PAVILION",
		"color": Color(0.88, 0.84, 0.76),  # warm cream — wooden reception hall
		"npcs": [
			{"id": "receptionist", "label": "Receptionist", "emoji": "🧘‍♀️"}
		],
		"exits": [
			{"label": "Path", "room": "path"}
		],
		"enter_text": "The air smells like nag champa and broken expectations. A woman sits behind a desk decorated with crystals and a very normal Dell laptop."
	},
	"path": {
		"name": "THE GARDEN PATH",
		"color": Color(0.82, 0.88, 0.78),  # soft sage — dappled light
		"npcs": [
			{"id": "oil_warrior", "label": "???", "emoji": "🧴", "hide_flag": "oil_defeated"}
		],
		"exits": [
			{"label": "Pavilion", "room": "pavilion"},
			{"label": "Garden", "room": "garden"},
			{"label": "Kitchen", "room": "kitchen", "require": "has_map"}
		],
		"enter_text": "A gravel path winds between prayer flags and hand-painted signs that say things like \"You Are Enough\" and \"Please Compost.\""
	},
	"garden": {
		"name": "THE SACRED GARDEN",
		"color": Color(0.78, 0.85, 0.75),  # light garden green — peaceful
		"npcs": [
			{"id": "frank", "label": "Groundskeeper", "emoji": "👷"}
		],
		"exits": [
			{"label": "Path", "room": "path"},
			{"label": "Movement Studio", "room": "studio", "require": "has_map"},
			{"label": "Dorms", "room": "dorms", "require": "has_map"},
			{"label": "Fire Pit", "room": "firepit", "require": "night_mode"}
		],
		"enter_text": "A quiet garden with meditation cushions, crystal grids, and a man in overalls fixing a fence. He is the first normal thing you've seen."
	},
	"kitchen": {
		"name": "THE KITCHEN",
		"color": Color(0.90, 0.86, 0.72),  # warm yellow
		"npcs": [
			{"id": "maya", "label": "Maya", "emoji": "👩‍🍳"},
			{"id": "cacao_dealer", "label": "Cacao Dealer", "emoji": "🧥", "show_flag": "talked_maya"},
		],
		"exits": [
			{"label": "Path", "room": "path"},
			{"label": "Main Hall", "room": "main_hall", "require": "has_map"}
		],
		"enter_text": "The kitchen smells like coconut, turmeric, and ambition. A woman with paint-stained hands is stirring something with the intensity of someone meditating on the concept of soup."
	},
	"dorms": {
		"name": "THE DORMS",
		"color": Color(0.85, 0.82, 0.88),  # dusty lavender
		"npcs": [
			{"id": "brandon", "label": "Brandon", "emoji": "🧑"}
		],
		"exits": [
			{"label": "Garden", "room": "garden"}
		],
		"enter_text": "A converted barn with narrow rooms. Recycled yoga mats are stacked in corners. Someone has written \"OM\" on the wall in pencil, then immediately erased it and written \"WHY\"."
	},
	"studio": {
		"name": "THE MOVEMENT STUDIO",
		"color": Color(0.88, 0.85, 0.78),  # pale wood
		"npcs": [
			{"id": "competitive_meditator", "label": "???", "emoji": "🧘"},
			{"id": "breathwork_monk", "label": "Breathwork Monk", "emoji": "🌬️", "show_flag": "meditator_defeated"},
		],
		"exits": [
			{"label": "Garden", "room": "garden"}
		],
		"enter_text": "A vast studio with mirrored walls and a speaker system that broadcasts whale sounds. Someone is aggressively stretching in the corner with the focus of someone trying to win at flexibility."
	},
	"main_hall": {
		"name": "THE MAIN HALL",
		"color": Color(0.86, 0.82, 0.70),  # warm amber
		"npcs": [
			{"id": "oversharer", "label": "The Oversharer", "emoji": "😭", "hide_flag": "circle_done"},
		],
		"exits": [
			{"label": "Kitchen", "room": "kitchen"},
			{"label": "Ceremony Space", "room": "ceremony", "require": "circle_done"}
		],
		"enter_text": "A large communal space with cushions scattered randomly, like someone dropped spirituality from a great height. A banner reads \"TRUST THE PROCESS\" in Comic Sans."
	},
	"firepit": {
		"name": "THE FIRE PIT",
		"color": Color(0.35, 0.22, 0.15),  # dark warm
		"npcs": [
			{"id": "maya", "label": "Maya", "emoji": "🔥"}
		],
		"exits": [
			{"label": "Garden", "room": "garden"}
		],
		"enter_text": "Night has fallen. A fire crackles in the pit, throwing shadows. The warmth feels earned, not spiritual—just warm."
	},
	"ceremony": {
		"name": "THE CEREMONY SPACE",
		"color": Color(0.30, 0.28, 0.32),  # deep purple-gray
		"npcs": [
			{"id": "gatekeeper", "label": "Gatekeeper", "emoji": "🧔", "hide_flag": "gatekeeper_cleared"}
		],
		"exits": [
			{"label": "Main Hall", "room": "main_hall"},
			{"label": "Back Office", "room": "back_office", "require": "gatekeeper_cleared"}
		],
		"enter_text": "A darkened space hung with fabric. A figure sits silhouetted in the center, radiating the kind of authority that comes from having once been important."
	},
	"back_office": {
		"name": "THE BACK OFFICE",
		"color": Color(0.92, 0.92, 0.90),  # fluorescent
		"npcs": [
			{"id": "founder", "label": "The Founder", "emoji": "👨‍💼", "show_flag": "found_documents"}
		],
		"exits": [
			{"label": "Ceremony Space", "room": "ceremony"}
		],
		"enter_text": "Fluorescent lights buzz overhead. Cardboard boxes are stacked in corners. A desk sits covered in paperwork. This space has no spiritual energy—just administrative ambition."
	}
}

var current_room_id: String = "pavilion"
var _dialogue_waiting: bool = false
var _typing: bool = false
var _full_text: String = ""
var _char_index: int = 0
var _type_timer: float = 0.0
var _blink_time: float = 0.0
var _current_exits: Array = []  # Cached available exits for current room
var _exit_page: int = 0  # Which pair of exits to show (0 = first two, 1 = next two, etc.)

const TYPE_SPEED: float = 0.015

func _ready() -> void:
	# Connect dialogue signals
	DialogueManager.dialogue_line_shown.connect(_on_dialogue_line)
	DialogueManager.choices_shown.connect(_on_choices_shown)
	DialogueManager.dialogue_finished.connect(_on_dialogue_finished)

	# Connect HUD signals
	GameState.hp_changed.connect(_update_hud)
	GameState.ep_changed.connect(_update_hud)
	GameState.normality_changed.connect(_update_hud)
	GameState.insight_changed.connect(_update_hud)
	GameState.cacao_changed.connect(_update_hud)
	GameState.flag_set.connect(_on_flag_set)

	# Connect navigation — now use dynamic exit system
	nav_left.pressed.connect(_on_nav_left)
	nav_right.pressed.connect(_on_nav_right)

	# Connect the click area for advancing dialogue
	click_area.pressed.connect(_handle_advance)

	_update_hud(0)
	enter_room(GameState.current_room_id)

func _process(delta: float) -> void:
	# Typewriter effect
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
			DialogueManager.is_typing = false

	# Blink the continue prompt
	if continue_prompt.visible:
		_blink_time += delta
		continue_prompt.modulate.a = 0.3 + 0.7 * abs(sin(_blink_time * 2.5))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		_handle_advance()
	# Arrow keys navigate first two exits (for keyboard users)
	if event.is_action_pressed("move_left"):
		if _current_exits.size() > 0:
			_navigate_to(_current_exits[0]["room"])
	if event.is_action_pressed("move_right"):
		if _current_exits.size() > 1:
			_navigate_to(_current_exits[1]["room"])

func _handle_advance() -> void:
	if _typing:
		# Skip typewriter — show full text immediately
		_typing = false
		_char_index = _full_text.length()
		dialogue_label.text = _full_text
		_dialogue_waiting = true
		continue_prompt.visible = true
		DialogueManager.is_typing = false
	elif _dialogue_waiting:
		_dialogue_waiting = false
		continue_prompt.visible = false
		DialogueManager.advance()

# ═══════════════════════════════════════
# ROOM MANAGEMENT & NAVIGATION
# ═══════════════════════════════════════
func enter_room(room_id: String) -> void:
	current_room_id = room_id
	GameState.current_room_id = room_id
	var room = rooms[room_id]

	scene_bg.color = room["color"]
	location_label.text = room["name"]
	scenery_drawer.set_room(room_id)

	# Calculate available exits based on requirements
	_current_exits = _get_available_exits(room)
	_exit_page = 0
	_update_nav_buttons()

	_populate_npcs(room)
	_show_room_text(room["enter_text"])

	# Auto-trigger special room events
	if room_id == "back_office" and not GameState.has_flag("found_documents"):
		# Delay to let the enter text show first, then auto-start discovery
		await get_tree().create_timer(0.5).timeout
		GameState.set_flag("found_documents")
		DialogueManager.start_dialogue("back_office_discover")

func _update_nav_buttons() -> void:
	# Hide the fixed nav buttons — we'll use dynamic exit buttons instead
	nav_left.visible = false
	nav_right.visible = false

	# Clear any previously created dynamic exit buttons
	for child in scene_bg.get_children():
		if child.is_in_group("exit_btn"):
			child.queue_free()

	var count = _current_exits.size()
	if count == 0:
		return

	# Create a dynamic exit button for each available exit
	# Position them along the bottom of the scene area
	var btn_width = 160.0
	var btn_height = 36.0
	var spacing = 12.0
	var total_width = count * btn_width + (count - 1) * spacing
	var start_x = (scene_bg.size.x - total_width) / 2.0
	var btn_y = scene_bg.size.y - btn_height - 12

	for i in count:
		var btn = Button.new()
		btn.text = _current_exits[i]["label"]
		btn.add_theme_font_size_override("font_size", 16)
		btn.add_theme_color_override("font_color", Color(0.35, 0.30, 0.18))
		btn.custom_minimum_size = Vector2(btn_width, btn_height)
		btn.position = Vector2(start_x + i * (btn_width + spacing), btn_y)
		btn.add_to_group("exit_btn")
		var room_id_target = _current_exits[i]["room"]
		btn.pressed.connect(func(): _navigate_to(room_id_target))
		scene_bg.add_child(btn)

func _navigate_to(room_id: String) -> void:
	if DialogueManager.is_active:
		return
	enter_room(room_id)

## Returns array of exits that are available (pass requirement flags)
func _get_available_exits(room: Dictionary) -> Array:
	var available: Array = []
	if not room.has("exits"):
		return available

	for exit in room["exits"]:
		# If exit has a requirement flag, only show if player has it
		if exit.has("require"):
			if not GameState.has_flag(exit["require"]):
				continue
		available.append(exit)

	return available

func _populate_npcs(room: Dictionary) -> void:
	for child in npc_container.get_children():
		child.queue_free()

	for npc in room["npcs"]:
		# Check hide_flag (NPC hidden if flag is set)
		if npc.has("hide_flag") and GameState.has_flag(npc["hide_flag"]):
			continue

		# Check show_flag (NPC only shown if flag is set)
		if npc.has("show_flag") and not GameState.has_flag(npc["show_flag"]):
			continue

		# Create a VBox to hold the stick figure + name label
		var npc_slot = VBoxContainer.new()
		npc_slot.custom_minimum_size = Vector2(240, 240)
		npc_slot.alignment = BoxContainer.ALIGNMENT_END

		# Create the stick figure character via factory
		var character = CharacterFactory.create_character(npc["id"], npc.get("label", ""))
		character.custom_minimum_size = Vector2(240, 200)
		character.size_flags_vertical = Control.SIZE_EXPAND_FILL
		character.character_clicked.connect(_on_npc_clicked)
		npc_slot.add_child(character)

		# Name label below the character
		var name_label = Label.new()
		name_label.text = npc["label"]
		name_label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		name_label.add_theme_font_size_override("font_size", 16)
		name_label.add_theme_color_override("font_color", Color(0.35, 0.30, 0.20))
		npc_slot.add_child(name_label)

		npc_container.add_child(npc_slot)

## Handle NPC clicks with branching dialogue logic
func _on_npc_clicked(npc_id: String) -> void:
	if DialogueManager.is_active:
		return

	# Route NPC conversations based on flags and state
	match npc_id:
		"receptionist":
			if GameState.has_flag("talked_receptionist"):
				DialogueManager.start_dialogue("receptionist_return")
			else:
				DialogueManager.start_dialogue("receptionist")
			return

		"frank":
			if GameState.has_flag("talked_frank"):
				DialogueManager.start_dialogue("frank_return")
			else:
				DialogueManager.start_dialogue("frank")
			return

		"oil_warrior":
			DialogueManager.start_dialogue("oil_warrior")
			return

		"maya":
			if GameState.has_flag("founder_defeated"):
				DialogueManager.start_dialogue("maya_post_boss")
			elif current_room_id == "firepit":
				DialogueManager.start_dialogue("maya_firepit")
			elif GameState.has_flag("talked_maya"):
				DialogueManager.start_dialogue("maya_return")
			else:
				DialogueManager.start_dialogue("maya_kitchen")
			return

		"brandon":
			if GameState.has_flag("founder_defeated"):
				DialogueManager.start_dialogue("brandon_post_boss")
			elif GameState.has_flag("night_mode") and not GameState.has_flag("circle_done"):
				DialogueManager.start_dialogue("brandon_night")
			elif GameState.has_flag("circle_done"):
				DialogueManager.start_dialogue("brandon_act2")
			else:
				DialogueManager.start_dialogue("brandon_arrive")
			return

		"competitive_meditator":
			if GameState.has_flag("meditator_defeated"):
				DialogueManager.start_dialogue("meditator_post")
			else:
				DialogueManager.start_dialogue("meditator_challenge")
			return

		"gatekeeper":
			DialogueManager.start_dialogue("gatekeeper_confront")
			return

		"founder":
			if GameState.has_flag("founder_defeated"):
				DialogueManager.start_dialogue("founder_end_restructure")
			else:
				DialogueManager.start_dialogue("founder_prefight")
			return

		"oversharer":
			if not GameState.has_flag("circle_done"):
				DialogueManager.start_dialogue("sharing_circle")
			return

		"cacao_dealer":
			DialogueManager.start_dialogue("cacao_dealer_shop")
			return

		"breathwork_monk":
			DialogueManager.start_dialogue("breathwork_monk")
			return

	# Fallback: start dialogue with NPC ID as tree name
	DialogueManager.start_dialogue(npc_id)

## Navigate left (first exit on current page)
func _on_nav_left() -> void:
	if DialogueManager.is_active:
		return
	var idx = _exit_page * 2
	if idx < _current_exits.size():
		enter_room(_current_exits[idx]["room"])

## Navigate right (second exit on current page)
func _on_nav_right() -> void:
	if DialogueManager.is_active:
		return
	var idx = _exit_page * 2 + 1
	if idx < _current_exits.size():
		enter_room(_current_exits[idx]["room"])

# ═══════════════════════════════════════
# DIALOGUE DISPLAY
# ═══════════════════════════════════════
func _show_room_text(text: String) -> void:
	speaker_label.text = ""
	_start_typewriter(text, true, Color.TRANSPARENT)

func _on_dialogue_line(speaker: String, text: String, is_thought: bool) -> void:
	speaker_label.text = speaker
	# Color the speaker name AND dialogue text per-character
	var sp_color = SPEAKER_COLORS.get(speaker, DEFAULT_SPEAKER_COLOR)
	speaker_label.add_theme_color_override("font_color", sp_color)
	choices_container.visible = false
	_start_typewriter(text, is_thought, sp_color)
	# Bounce the speaking NPC character
	_bounce_speaking_npc(speaker)

func _start_typewriter(text: String, is_thought: bool, speaker_color: Color = Color.TRANSPARENT) -> void:
	_full_text = text
	_char_index = 0
	_type_timer = 0.0
	_typing = true
	_dialogue_waiting = false
	continue_prompt.visible = false

	if is_thought:
		dialogue_label.add_theme_color_override("default_color", Color(0.50, 0.50, 0.50))  # gray for thoughts/narrator
	elif speaker_color != Color.TRANSPARENT:
		dialogue_label.add_theme_color_override("default_color", speaker_color)  # speaker color for all text
	else:
		dialogue_label.add_theme_color_override("default_color", Color(0.15, 0.15, 0.15))  # near-black fallback
	dialogue_label.text = ""

func _on_choices_shown(choices: Array) -> void:
	speaker_label.text = ""
	dialogue_label.text = ""
	continue_prompt.visible = false
	_dialogue_waiting = false
	_typing = false
	click_area.visible = false  # Hide so choice buttons can receive clicks

	for child in choices_container.get_children():
		child.queue_free()

	choices_container.visible = true

	for i in choices.size():
		var btn = Button.new()
		btn.text = choices[i]["text"]
		btn.alignment = HORIZONTAL_ALIGNMENT_LEFT
		btn.add_theme_font_size_override("font_size", 22)

		var style = StyleBoxFlat.new()
		style.bg_color = Color(0.94, 0.94, 0.94, 0.8)
		style.border_color = Color(0.70, 0.70, 0.70)
		style.set_border_width_all(1)
		style.set_corner_radius_all(3)
		style.content_margin_left = 14
		style.content_margin_right = 14
		style.content_margin_top = 8
		style.content_margin_bottom = 8
		btn.add_theme_stylebox_override("normal", style)

		var hover_style = style.duplicate()
		hover_style.bg_color = Color(0.88, 0.95, 0.88, 0.9)
		hover_style.border_color = Color(0.13, 0.55, 0.13)
		btn.add_theme_stylebox_override("hover", hover_style)
		btn.add_theme_color_override("font_color", Color(0.20, 0.20, 0.20))
		btn.add_theme_color_override("font_hover_color", Color(0.0, 0.0, 0.0))

		var idx = i
		btn.pressed.connect(func(): _on_choice_selected(idx))
		choices_container.add_child(btn)

func _on_choice_selected(index: int) -> void:
	choices_container.visible = false
	click_area.visible = true  # Restore click-to-advance after choice made
	DialogueManager.select_choice(index)

## Handle various dialogue callbacks and state transitions
func _on_dialogue_finished() -> void:
	# Battle transitions — set which enemy to fight, then go to battle scene
	if GameState.has_flag("start_oil_battle"):
		GameState.flags.erase("start_oil_battle")
		GameState.current_battle_enemy = "oil_warrior"
		SceneManager.change_scene("res://scenes/battle.tscn")
		return

	if GameState.has_flag("start_meditator_battle"):
		GameState.flags.erase("start_meditator_battle")
		GameState.current_battle_enemy = "meditator"
		SceneManager.change_scene("res://scenes/battle.tscn")
		return

	if GameState.has_flag("start_gatekeeper_battle"):
		GameState.flags.erase("start_gatekeeper_battle")
		GameState.current_battle_enemy = "gatekeeper"
		SceneManager.change_scene("res://scenes/battle.tscn")
		return

	if GameState.has_flag("start_founder_battle"):
		GameState.flags.erase("start_founder_battle")
		GameState.current_battle_enemy = "founder"
		SceneManager.change_scene("res://scenes/battle.tscn")
		return

	# Room navigation via dialogue
	if GameState.has_flag("enter_back_office"):
		GameState.flags.erase("enter_back_office")
		enter_room("back_office")
		return

	if GameState.has_flag("enter_firepit"):
		GameState.flags.erase("enter_firepit")
		enter_room("firepit")
		return

# ═══════════════════════════════════════
# HUD
# ═══════════════════════════════════════
func _update_hud(_value = null) -> void:
	hp_bar.value = float(GameState.hp) / float(GameState.max_hp) * 100.0
	hp_label.text = str(GameState.hp)
	ep_bar.value = float(GameState.ep) / float(GameState.max_ep) * 100.0
	ep_label.text = str(GameState.ep)
	norm_bar.value = GameState.normality
	insight_label.text = "INSIGHT: " + str(GameState.insight)
	cacao_label.text = "🫘 " + str(GameState.cacao)

func _on_flag_set(_flag_name: String) -> void:
	if rooms.has(current_room_id):
		_populate_npcs(rooms[current_room_id])

# ═══════════════════════════════════════
# CHARACTER REACTIONS
# ═══════════════════════════════════════
func _bounce_speaking_npc(speaker_name: String) -> void:
	# Find the character whose display_name matches the speaker and bounce them
	for slot in npc_container.get_children():
		if slot is VBoxContainer:
			for child in slot.get_children():
				if child is StickCharacter and child.display_name == speaker_name:
					child.react_bounce()
					child.set_expression(StickCharacter.Emotion.HAPPY)
					return

func _get_npc_character(npc_id: String) -> StickCharacter:
	# Utility to find a character node by NPC ID
	for slot in npc_container.get_children():
		if slot is VBoxContainer:
			for child in slot.get_children():
				if child is StickCharacter and child.character_id == npc_id:
					return child
	return null
