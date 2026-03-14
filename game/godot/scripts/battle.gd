extends Control
## Turn-based combat scene. Data-driven: supports multiple enemies.
## Reads GameState.current_battle_enemy to determine which fight to run.

# ── Node References ──
@onready var steve_container: Control = %SteveContainer
@onready var steve_hp_bar: ProgressBar = %SteveHPBar
@onready var steve_hp_label: Label = %SteveHPLabel
@onready var steve_status_label: Label = %SteveStatusLabel
@onready var enemy_name_label: Label = %EnemyNameLabel
@onready var enemy_container: Control = %EnemyContainer
@onready var enemy_hp_bar: ProgressBar = %EnemyHPBar
@onready var enemy_hp_label: Label = %EnemyHPLabel
@onready var enemy_status_label: Label = %EnemyStatusLabel

@onready var battle_log: RichTextLabel = %BattleLog
@onready var main_menu: VBoxContainer = %MainMenu
@onready var sub_menu: VBoxContainer = %SubMenu
@onready var sub_menu_panel: PanelContainer = %SubMenuPanel

@onready var victory_overlay: Control = %VictoryOverlay
@onready var victory_title: Label = %VictoryTitle
@onready var victory_text: RichTextLabel = %VictoryText

# ── Characters (created at runtime) ──
var steve_char: StickCharacter
var enemy_char: StickCharacter

# ══════════════════════════════════════════════════════════
# ENEMY DATABASE
# ══════════════════════════════════════════════════════════
const ENEMY_DB := {
	"oil_warrior": {
		"name": "ESSENTIAL OIL WARRIOR",
		"char_id": "oil_warrior",
		"hp": 45, "max_hp": 45,
		"atk": 12, "def": 0,
		"weakness": "bureaucratic",
		"intro": "\"Have you tried peppermint oil for your energy? You look like your chi is STAGNANT.\"",
		"attacks": [
			{"name": "Anoint", "dmg": 14, "msg": "\"RECEIVE THIS BLESSING!\" She hurls peppermint oil at Steve.", "effect": "smudge"},
			{"name": "MLM Pitch", "dmg": 10, "msg": "\"What if I told you that for a ONE-TIME investment of $150...\"", "effect": "enroll"},
			{"name": "\"It's Not a Pyramid\"", "dmg": 0, "msg": "\"A PYRAMID has a POINT. This is a DIAMOND. Completely different geometry.\"", "effect": "defend"},
		],
		"analyze_text": "Type: MLM Zealot\nWeakness: Bureaucratic (financial truth)\nResistance: Spiritual\nInventory invested: $6,000\nTotal sales: $340 (to her mother)\nNet position: -$5,660\n[color=#aa7744]NOTE: Spreadsheet Analysis may be instantly fatal.[/color]",
		"defeat_text": "\"My mother bought out of pity, didn't she.\"\n(She walks away slowly. Somehow this feels worse than winning.)",
		"defeat_flag": "oil_defeated",
		"xp": 3, "cacao": 25,
		"drops": [{"id": "oil_bottle", "name": "Tiny Bottle of Overpriced Oil", "desc": "\"Thieves Blend. Named after the historical plague remedy or the business model.\"", "type": "consumable", "heal": 15, "qty": 1}],
	},

	"meditator": {
		"name": "COMPETITIVE MEDITATOR",
		"char_id": "competitive_meditator",
		"hp": 60, "max_hp": 60,
		"atk": 14, "def": 2,
		"weakness": "psychic",
		"intro": "\"Your breathing technique is AMATEUR. Prepare to be out-meditated.\"",
		"attacks": [
			{"name": "Judgmental Silence", "dmg": 12, "msg": "He stares at Steve with the intensity of a man who meditates competitively. It hurts.", "effect": ""},
			{"name": "Aggressive Namaste", "dmg": 16, "msg": "\"NAMASTE!\" (He bows so aggressively it's basically a headbutt.)", "effect": ""},
			{"name": "Chakra Flex", "dmg": 8, "msg": "He aligns all seven chakras visibly. Steve's one chakra feels inadequate.", "effect": "defend"},
			{"name": "\"I Meditate Harder\"", "dmg": 0, "msg": "\"I once meditated for 72 hours straight. I SAW COLORS THAT DON'T EXIST.\"", "effect": "buff_atk"},
		],
		"analyze_text": "Type: Spiritual Athlete\nWeakness: Psychic (genuine questions about meaning)\nResistance: Physical\nMeditation hours logged: 14,000\nEnlightenments claimed: 7\nActual enlightenments: 0\n[color=#aa7744]NOTE: His ego is his weak point. Talk options may be effective.[/color]",
		"defeat_text": "\"I... I wasn't even the best meditator here?\"\n(He unfolds from lotus position for the first time in three days. His knees crack loudly.)",
		"defeat_flag": "meditator_defeated",
		"xp": 4, "cacao": 35,
		"drops": [{"id": "meditation_cushion", "name": "Competition-Grade Meditation Cushion", "desc": "\"Ergonomically designed for aggressive sitting. Steve respects the engineering.\"", "type": "consumable", "heal": 25, "qty": 1}],
	},

	"gatekeeper": {
		"name": "THE GATEKEEPER",
		"char_id": "gatekeeper",
		"hp": 80, "max_hp": 80,
		"atk": 16, "def": 4,
		"weakness": "bureaucratic",
		"intro": "\"You dare challenge the guardian of the Ceremony Space? Your energy signature is INSUFFICIENT.\"",
		"attacks": [
			{"name": "Gatekeep", "dmg": 18, "msg": "\"YOU ARE NOT READY.\" He blocks the entrance with his entire being. It's surprisingly painful.", "effect": ""},
			{"name": "Spiritual Authority", "dmg": 14, "msg": "\"I have studied with masters in seven countries.\" (He went to Bali once for a week.)", "effect": "smudge"},
			{"name": "Ego Shield", "dmg": 0, "msg": "He wraps himself in seventeen layers of spiritual authority. His defense increases.", "effect": "defend"},
			{"name": "Past Life Guilt", "dmg": 10, "msg": "\"In a past life, you owed me a great debt. PAY IT NOW.\"", "effect": "enroll"},
		],
		"analyze_text": "Type: Former Middle Manager\nWeakness: Bureaucratic (corporate past)\nResistance: Spiritual\nPrevious career: Verizon District Manager (2019-2024)\nLinkedIn recommendations: 17\nYears of 'spiritual training': 2\n[color=#aa7744]NOTE: His corporate past is his weakness. Remind him who he really is.[/color]",
		"defeat_text": "\"My name is Dave. Dave Carver. I managed a Verizon store in Paramus.\"\n(He sits on the floor. For the first time, he looks like himself.)",
		"defeat_flag": "gatekeeper_cleared",
		"xp": 5, "cacao": 50,
		"drops": [{"id": "verizon_badge", "name": "Verizon Employee Badge", "desc": "\"Dave Carver. District Manager. Employee of the Month, March 2022. He looks happy in the photo.\"", "type": "quest", "qty": 1}],
	},

	"founder": {
		"name": "THE FOUNDER",
		"char_id": "founder",
		"hp": 50, "max_hp": 50,
		"atk": 18, "def": 3,
		"weakness": "bureaucratic",
		"intro": "\"I really hoped you wouldn't do this, Akash Prem. I liked you. You have a very... acquisitive energy.\"",
		"is_boss": true,
		# Phase 1: Brandon shields Paul
		"phase1_hp": 30,
		"phase1_name": "BRANDON (BRAINWASHED)",
		"phase1_char_id": "brandon",
		"phase1_attacks": [
			{"name": "Eager Defense", "dmg": 10, "msg": "\"I WON'T LET YOU HURT HIM! He SEES me!\" Brandon throws himself in the way.", "effect": ""},
			{"name": "Gratitude Shield", "dmg": 0, "msg": "Brandon's blind devotion creates a barrier of positive energy. Paul's defense rises.", "effect": "defend"},
			{"name": "Love Bomb", "dmg": 8, "msg": "\"You just don't UNDERSTAND, Steve! The Founder LOVES us!\" The sincerity stings.", "effect": ""},
		],
		"phase1_talk_options": {
			"talk_boundary": {"text": "\"Brandon, when was the last time you ate?\"", "dmg": 12, "msg": "Brandon blinks. His stomach growls audibly. \"I... food is densifying... but...\""},
			"talk_question": {"text": "\"Brandon, where's your watch? The one your dad gave you?\"", "dmg": 15, "msg": "Brandon's hand goes to his empty wrist. His eyes water. \"My... my Timex...\""},
			"talk_bore": {"text": "Steve explains payroll tax obligations for non-profit organizations.", "dmg": 8, "msg": "Brandon's glazed expression gets even more glazed, but in a different way."},
			"talk_validate": {"text": "\"Brandon, you're a good person. That's why he chose you.\"", "dmg": 10, "msg": "Brandon freezes. \"He... chose me because I'm good? Or because I'm easy?\""},
		},
		"phase1_defeat_text": "Brandon collapses, shaking. \"I haven't eaten in three days. I gave him my dad's watch. Why did I give him my dad's watch?\"",

		# Phase 2: Paul fights directly
		"attacks": [
			{"name": "Charismatic Redirect", "dmg": 16, "msg": "\"What you're feeling right now is RESISTANCE. That means we're close to a breakthrough.\"", "effect": ""},
			{"name": "Gaslighting", "dmg": 12, "msg": "\"I never said that. You're projecting. This is your trauma speaking.\"", "effect": "smudge"},
			{"name": "Financial Restructure", "dmg": 0, "msg": "Paul adjusts his pricing model mid-battle. His defense increases and he gains 2 ATK.", "effect": "boss_buff"},
			{"name": "Inner Circle Invitation", "dmg": 20, "msg": "\"Join me, Steve. You have a gift for systems. Imagine what we could BUILD together.\"", "effect": "enroll"},
		],

		# Phase 3: Desperate Paul
		"phase3_hp_threshold": 15,
		"phase3_attacks": [
			{"name": "Desperate Plea", "dmg": 8, "msg": "\"Please. I built this from NOTHING. You can't take it away.\"", "effect": ""},
			{"name": "Full Meltdown", "dmg": 25, "msg": "Paul throws the desk. Papers fly everywhere. \"I AM THE FOUNDER! I AM THE VISION!\"", "effect": ""},
			{"name": "Vulnerable Honesty", "dmg": 0, "msg": "\"I was a used car salesman in Tucson. I read one book about chakras. ONE BOOK.\"", "effect": "lower_def"},
		],

		"analyze_text": "Type: Wellness Entrepreneur\nWeakness: Bureaucratic (financial records)\nResistance: Spiritual, Psychic\nReal name: Paul Fontaine\nPrevious career: Used car sales (2016-2021)\nAnnual revenue: $1.2M\nPaid to staff: $0\nVolunteers: 40 (unpaid)\nPassports held: 12\n[color=#aa7744]BOSS: 3 phases. Break Brandon's conditioning first.[/color]",
		"defeat_text": "Paul sits in his ergonomic office chair. The one normal thing in the whole compound.\n\"It started as a joke. A weekend retreat for my ex's book club. Then they came back. And they brought friends. And they brought money.\"\nHe looks at his hands. \"I'm not enlightened. I'm just good at PowerPoint.\"",
		"defeat_flag": "founder_defeated",
		"xp": 10, "cacao": 100,
		"drops": [
			{"id": "wife_letter", "name": "Wife's Recommendation Letter", "desc": "\"Addressed to Pranayama Peak. 'Advanced work.' Dated three months ago.\"", "type": "quest", "qty": 1},
			{"id": "maya_passport", "name": "Maya's Passport", "desc": "\"She's been here seven months. The photo shows someone who used to smile.\"", "type": "quest", "qty": 1},
		],
	},
}

# ── Battle State ──
var enemy: Dictionary = {}
var player_turn: bool = true
var battle_over: bool = false
var analyzed: bool = false
var smudged: int = 0
var enrolled: bool = false
var enrolled_timer: int = 0
var enduring: bool = false

# Boss state
var is_boss: bool = false
var boss_phase: int = 1  # 1=Brandon shield, 2=Paul direct, 3=Paul desperate
var phase1_hp: int = 0
var phase1_max_hp: int = 0

# ── Log Colors (bright theme) ──
const COL_NARRATOR := Color(0.45, 0.40, 0.35)
const COL_DIALOGUE := Color(0.15, 0.45, 0.65)
const COL_DAMAGE := Color(0.80, 0.25, 0.20)
const COL_EFFECT := Color(0.70, 0.45, 0.15)
const COL_HEAL := Color(0.20, 0.55, 0.20)
const COL_STEVE := Color(0.13, 0.55, 0.13)

func _ready() -> void:
	# Load enemy data from database
	var enemy_id = GameState.current_battle_enemy
	if not ENEMY_DB.has(enemy_id):
		enemy_id = "oil_warrior"
	enemy = ENEMY_DB[enemy_id].duplicate(true)

	is_boss = enemy.get("is_boss", false)

	# Set up boss phase tracking
	if is_boss:
		boss_phase = 1
		phase1_hp = enemy["phase1_hp"]
		phase1_max_hp = enemy["phase1_hp"]

	# Spawn stick figure characters
	_spawn_characters(enemy_id)

	victory_overlay.visible = false
	sub_menu_panel.visible = false
	_update_display()

	# Show intro text
	_log(enemy["intro"], COL_DIALOGUE)
	if is_boss:
		_log("BOSS BATTLE — Phase 1: Break Brandon's conditioning!", Color(0.75, 0.20, 0.20))
	else:
		_log("Battle Start!", COL_NARRATOR)
	_set_menu_enabled(true)

func _spawn_characters(enemy_id: String) -> void:
	# Spawn Steve
	steve_char = CharacterFactory.create_character("steve")
	steve_char.custom_minimum_size = Vector2(200, 180)
	steve_char.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	steve_char.size_flags_vertical = Control.SIZE_EXPAND_FILL
	steve_container.add_child(steve_char)

	# Spawn enemy (or boss phase 1 character)
	var char_id = enemy.get("char_id", enemy_id)
	if is_boss and boss_phase == 1:
		char_id = enemy["phase1_char_id"]
	enemy_char = CharacterFactory.create_character(char_id)
	enemy_char.custom_minimum_size = Vector2(200, 180)
	enemy_char.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	enemy_char.size_flags_vertical = Control.SIZE_EXPAND_FILL
	enemy_container.add_child(enemy_char)

	# Update name label
	if is_boss and boss_phase == 1:
		enemy_name_label.text = enemy["phase1_name"]
	else:
		enemy_name_label.text = enemy["name"]

func _update_display() -> void:
	steve_hp_bar.value = float(GameState.hp) / float(GameState.max_hp) * 100.0
	steve_hp_label.text = "%d/%d" % [GameState.hp, GameState.max_hp]

	if is_boss and boss_phase == 1:
		enemy_hp_bar.value = float(phase1_hp) / float(phase1_max_hp) * 100.0
		enemy_hp_label.text = "%d/%d" % [phase1_hp, phase1_max_hp]
	else:
		enemy_hp_bar.value = float(enemy["hp"]) / float(enemy["max_hp"]) * 100.0
		enemy_hp_label.text = "%d/%d" % [enemy["hp"], enemy["max_hp"]]

	# Status text
	var statuses: PackedStringArray = []
	if smudged > 0:
		statuses.append("Smudged(%d)" % smudged)
	if enrolled:
		statuses.append("Enrolled(%d)" % (5 - enrolled_timer))
	steve_status_label.text = " | ".join(statuses)

	var enemy_statuses: PackedStringArray = []
	if enemy["def"] > 0:
		enemy_statuses.append("DEF +%d" % enemy["def"])
	if is_boss:
		enemy_statuses.append("Phase %d/3" % boss_phase)
	enemy_status_label.text = " | ".join(enemy_statuses)

func _set_menu_enabled(on: bool) -> void:
	for btn in main_menu.get_children():
		if btn is Button:
			btn.disabled = not on

func _log(text: String, color: Color = COL_NARRATOR) -> void:
	battle_log.push_color(color)
	battle_log.append_text(text + "\n")
	battle_log.pop()
	await get_tree().process_frame
	battle_log.scroll_to_line(battle_log.get_line_count())

# ══════════════════════════════════════════════════════════
# MENU ACTIONS
# ══════════════════════════════════════════════════════════
func _on_attack_pressed() -> void:
	if not player_turn or battle_over: return
	_execute_player_turn("attack")

func _on_skills_pressed() -> void:
	if not player_turn or battle_over: return
	_show_submenu("skills")

func _on_talk_pressed() -> void:
	if not player_turn or battle_over: return
	_show_submenu("talk")

func _on_analyze_pressed() -> void:
	if not player_turn or battle_over: return
	_execute_player_turn("analyze")

func _on_items_pressed() -> void:
	if not player_turn or battle_over: return
	_show_submenu("items")

func _on_endure_pressed() -> void:
	if not player_turn or battle_over: return
	_execute_player_turn("endure")

func _show_submenu(menu_type: String) -> void:
	main_menu.visible = false
	sub_menu_panel.visible = true

	for child in sub_menu.get_children():
		child.queue_free()

	# Back button
	var back_btn = Button.new()
	back_btn.text = "← Back"
	back_btn.add_theme_font_size_override("font_size", 18)
	back_btn.add_theme_color_override("font_color", COL_NARRATOR)
	back_btn.pressed.connect(_hide_submenu)
	sub_menu.add_child(back_btn)

	match menu_type:
		"skills":
			_add_sub_btn("Spreadsheet Analysis [5 EP]", "spreadsheet", GameState.ep >= 5)
			_add_sub_btn("Schedule Optimization [4 EP]", "schedule_opt", GameState.ep >= 4)
			_add_sub_btn("Risk Assessment [3 EP]", "risk_assess", GameState.ep >= 3)
			if GameState.insight >= 2:
				_add_sub_btn("Audit [8 EP]", "audit", GameState.ep >= 8)
				_add_sub_btn("Tax Write-Off [4 EP]", "tax_writeoff", GameState.ep >= 4)
		"talk":
			_add_sub_btn("Set Boundary", "talk_boundary")
			_add_sub_btn("Question", "talk_question")
			_add_sub_btn("Bore", "talk_bore")
			_add_sub_btn("Validate", "talk_validate")
		"items":
			var consumables = GameState.get_consumables()
			if consumables.is_empty():
				_add_sub_btn("(no items)", "", false)
			for item in consumables:
				var label = item["name"]
				if item.has("qty"):
					label += " x%d" % item["qty"]
				_add_sub_btn(label, "use_item:" + item["id"])

func _add_sub_btn(label: String, action: String, enabled: bool = true) -> void:
	var btn = Button.new()
	btn.text = label
	btn.disabled = not enabled or action == ""
	btn.add_theme_font_size_override("font_size", 17)
	btn.add_theme_color_override("font_color", COL_DIALOGUE)
	if enabled and action != "":
		btn.pressed.connect(func():
			_hide_submenu()
			_execute_player_turn(action)
		)
	sub_menu.add_child(btn)

func _hide_submenu() -> void:
	sub_menu_panel.visible = false
	main_menu.visible = true

# ══════════════════════════════════════════════════════════
# PLAYER TURN
# ══════════════════════════════════════════════════════════
func _execute_player_turn(action: String) -> void:
	player_turn = false
	_set_menu_enabled(false)
	enduring = false

	var hit = true
	if smudged > 0 and randf() < 0.2:
		hit = false

	match action:
		"attack":
			var base_dmg = 5 + randi_range(0, 3)
			if not hit:
				_log("Steve swings the Orientation Pamphlet... and misses! (Smudged)", COL_NARRATOR)
			else:
				var dmg = maxi(1, base_dmg - _get_enemy_def())
				_deal_enemy_dmg(dmg)
				_log("Steve attacks with the Orientation Pamphlet! %d damage!" % dmg, COL_DAMAGE)
				_react_enemy_hit()

		"spreadsheet":
			GameState.ep -= 5
			_log("Steve pulls out a spreadsheet.", COL_NARRATOR)
			if is_boss and boss_phase == 1:
				_log("\"Brandon, you donated $2,400 to a gratitude fund with no receipts.\"", COL_STEVE)
				_deal_enemy_dmg(15)
				_log("The numbers hit hard! 15 psychic damage!", COL_DAMAGE)
			elif enemy.get("weakness", "") == "bureaucratic":
				var dmg = _get_current_hp()
				_deal_enemy_dmg(dmg)
				_log("CRITICAL! Bureaucratic damage obliterates financial delusion! %d damage!" % dmg, COL_DAMAGE)
			else:
				_deal_enemy_dmg(20)
				_log("Spreadsheet Analysis deals 20 bureaucratic damage!", COL_DAMAGE)
			_react_enemy_hit()

		"schedule_opt":
			GameState.ep -= 4
			_log("\"I've blocked out 15 minutes for this conflict.\" Extra action!", COL_STEVE)
			player_turn = true
			_set_menu_enabled(true)
			_update_display()
			return

		"risk_assess":
			GameState.ep -= 3
			_log("Steve evaluates the risk profile...", COL_NARRATOR)
			if is_boss and boss_phase == 1:
				_log("\"Brandon, your risk exposure is... everything. You've given up everything.\"", COL_STEVE)
			else:
				_log("Risk assessment reveals vulnerabilities.", COL_NARRATOR)
			enemy["def"] = maxi(0, enemy.get("def", 0) - 2)
			_log("Enemy defense reduced!", COL_EFFECT)

		"audit":
			GameState.ep -= 8
			_log("Steve initiates a FULL AUDIT.", COL_NARRATOR)
			if is_boss and boss_phase >= 2:
				_deal_enemy_dmg(30)
				_log("The audit reveals years of financial misconduct! 30 damage!", COL_DAMAGE)
			else:
				_deal_enemy_dmg(25)
				_log("25 damage! All defenses stripped!", COL_DAMAGE)
			enemy["def"] = 0
			_log("\"Your LLC was filed incorrectly.\"", COL_STEVE)
			_react_enemy_hit()

		"tax_writeoff":
			GameState.ep -= 4
			enduring = true
			_log("\"This confrontation is a deductible business expense.\" Next attack -50%.", COL_STEVE)

		"talk_boundary":
			if is_boss and boss_phase == 1:
				var talk = enemy["phase1_talk_options"]["talk_boundary"]
				_log(talk["text"], COL_STEVE)
				_deal_enemy_dmg(talk["dmg"])
				_log(talk["msg"], COL_DIALOGUE)
			else:
				_log("Steve: \"I'm not interested. Thank you.\"", COL_STEVE)
				_log("Clear communication stuns the enemy!", COL_EFFECT)
				_update_display()
				await get_tree().create_timer(0.8).timeout
				_end_enemy_turn()
				return

		"talk_question":
			if is_boss and boss_phase == 1:
				var talk = enemy["phase1_talk_options"]["talk_question"]
				_log(talk["text"], COL_STEVE)
				_deal_enemy_dmg(talk["dmg"])
				_log(talk["msg"], COL_DIALOGUE)
			else:
				_log("Steve asks a deeply uncomfortable question.", COL_STEVE)
				_deal_enemy_dmg(8)
				_log("8 psychic damage! (self-inflicted cognitive dissonance)", COL_DAMAGE)

		"talk_bore":
			if is_boss and boss_phase == 1:
				var talk = enemy["phase1_talk_options"]["talk_bore"]
				_log(talk["text"], COL_STEVE)
				_deal_enemy_dmg(talk["dmg"])
				_log(talk["msg"], COL_DIALOGUE)
			else:
				_log("Steve explains the difference between FIFO and LIFO inventory methods.", COL_STEVE)
				_deal_enemy_dmg(6)
				_log("6 damage from sheer boredom.", COL_DAMAGE)

		"talk_validate":
			if is_boss and boss_phase == 1:
				var talk = enemy["phase1_talk_options"]["talk_validate"]
				_log(talk["text"], COL_STEVE)
				_deal_enemy_dmg(talk["dmg"])
				_log(talk["msg"], COL_DIALOGUE)
			else:
				_log("Steve: \"It sounds like you really believe in what you're doing.\"", COL_STEVE)
				enemy["atk"] = maxi(5, enemy.get("atk", 12) - 3)
				_log("Attack power drops. Validation is devastatingly effective.", COL_EFFECT)

		"endure":
			enduring = true
			_log("Steve grits his teeth. Damage reduced this turn.", COL_NARRATOR)
			_log("(He thinks about his desk. His ergonomic chair. The hum of fluorescent lighting.)", COL_NARRATOR)

		"analyze":
			if analyzed:
				_log("Already analyzed. Steve's thorough but not redundant.", COL_NARRATOR)
			else:
				analyzed = true
				_log("═══ ANALYSIS ═══", COL_NARRATOR)
				battle_log.push_color(COL_NARRATOR)
				battle_log.append_text(enemy["analyze_text"] + "\n")
				battle_log.pop()

		var item_action:
			if item_action.begins_with("use_item:"):
				var item_id = item_action.split(":")[1]
				_use_item(item_id)

	_update_display()

	# Check for phase transitions or victory
	if _check_enemy_defeated():
		return

	await get_tree().create_timer(0.8).timeout
	_enemy_turn()

func _get_enemy_def() -> int:
	return enemy.get("def", 0)

func _get_current_hp() -> int:
	if is_boss and boss_phase == 1:
		return phase1_hp
	return enemy["hp"]

func _deal_enemy_dmg(dmg: int) -> void:
	if is_boss and boss_phase == 1:
		phase1_hp = maxi(0, phase1_hp - dmg)
	else:
		enemy["hp"] = maxi(0, enemy["hp"] - dmg)
	_react_enemy_hit()

func _react_enemy_hit() -> void:
	if enemy_char:
		enemy_char.react_shake()
		enemy_char.set_expression(StickCharacter.Emotion.ANGRY)

func _check_enemy_defeated() -> bool:
	if is_boss and boss_phase == 1 and phase1_hp <= 0:
		_advance_boss_phase()
		return true
	elif is_boss and boss_phase >= 2 and enemy["hp"] <= 0:
		_end_battle(true)
		return true
	elif not is_boss and enemy["hp"] <= 0:
		_end_battle(true)
		return true
	return false

func _advance_boss_phase() -> void:
	if boss_phase == 1:
		# Brandon falls, Paul steps forward
		boss_phase = 2
		_log("───────────────", COL_NARRATOR)
		_log(enemy["phase1_defeat_text"], COL_DIALOGUE)
		_log("───────────────", COL_NARRATOR)
		_log("Phase 2: Paul steps forward!", Color(0.75, 0.20, 0.20))
		enemy_name_label.text = enemy["name"]

		# Swap the enemy character
		if enemy_char:
			enemy_char.queue_free()
		enemy_char = CharacterFactory.create_character(enemy["char_id"])
		enemy_char.custom_minimum_size = Vector2(200, 180)
		enemy_char.size_flags_horizontal = Control.SIZE_EXPAND_FILL
		enemy_char.size_flags_vertical = Control.SIZE_EXPAND_FILL
		enemy_container.add_child(enemy_char)

		# Reset some state
		smudged = 0
		enrolled = false
		enemy["def"] = 3

		_update_display()
		await get_tree().create_timer(1.0).timeout
		player_turn = true
		_set_menu_enabled(true)

func _use_item(item_id: String) -> void:
	for item in GameState.inventory:
		if item["id"] == item_id:
			if item.has("heal"):
				var heal = mini(item["heal"], GameState.max_hp - GameState.hp)
				GameState.hp += heal
				_log("Steve uses %s. Restored %d HP!" % [item["name"], heal], COL_HEAL)
				steve_char.react_bounce()
			GameState.remove_item(item_id)
			break

# ══════════════════════════════════════════════════════════
# ENEMY TURN
# ══════════════════════════════════════════════════════════
func _enemy_turn() -> void:
	if battle_over:
		return

	# Tick status effects
	if smudged > 0:
		smudged -= 1
		if smudged == 0:
			_log("The smudge smoke clears.", COL_NARRATOR)

	if enrolled:
		enrolled_timer += 1
		GameState.cacao = maxi(0, GameState.cacao - 5)
		_log("Enrolled! Steve loses 5 cacao to the subscription.", COL_EFFECT)
		if enrolled_timer >= 5:
			_log("The starter kit ships. Steve loses 150 cacao.", COL_DAMAGE)
			GameState.cacao = maxi(0, GameState.cacao - 150)
			enrolled = false

	# Pick attack based on phase
	var attacks_pool: Array
	if is_boss and boss_phase == 1:
		attacks_pool = enemy.get("phase1_attacks", enemy["attacks"])
	elif is_boss and boss_phase >= 2 and enemy["hp"] <= enemy.get("phase3_hp_threshold", 15):
		# Switch to phase 3
		if boss_phase == 2:
			boss_phase = 3
			_log("Paul is desperate! Phase 3!", Color(0.75, 0.20, 0.20))
		attacks_pool = enemy.get("phase3_attacks", enemy["attacks"])
	else:
		attacks_pool = enemy["attacks"]

	var atk = attacks_pool[randi() % attacks_pool.size()]

	var display_name = enemy["name"]
	if is_boss and boss_phase == 1:
		display_name = enemy["phase1_name"]
	_log("%s uses %s!" % [display_name, atk["name"]], COL_NARRATOR)
	_log(atk["msg"], COL_DIALOGUE)

	if atk["dmg"] > 0:
		var dmg = atk["dmg"] + randi_range(-2, 2)
		if enduring:
			dmg = dmg / 2
			_log("(Endure reduces damage!)", COL_NARRATOR)
		dmg = maxi(1, dmg)
		GameState.hp -= dmg
		_log("Steve takes %d damage!" % dmg, COL_DAMAGE)
		if steve_char:
			steve_char.react_shake()
			steve_char.set_expression(StickCharacter.Emotion.SCARED)

	# Apply effect
	match atk.get("effect", ""):
		"smudge":
			if smudged == 0:
				smudged = 3
				_log("Steve is Smudged! (Accuracy -20% for 3 turns)", COL_EFFECT)
		"enroll":
			if not enrolled:
				enrolled = true
				enrolled_timer = 0
				_log("Steve is being Enrolled! (Losing cacao each turn)", COL_EFFECT)
		"defend":
			enemy["def"] = enemy.get("def", 0) + 3
			_log("Enemy defense increased!", COL_EFFECT)
		"buff_atk":
			enemy["atk"] = enemy.get("atk", 12) + 4
			_log("Enemy attack power surges!", COL_EFFECT)
		"boss_buff":
			enemy["def"] = enemy.get("def", 0) + 2
			enemy["atk"] = enemy.get("atk", 18) + 2
			_log("Paul restructures mid-fight! ATK and DEF increase!", COL_EFFECT)
		"lower_def":
			enemy["def"] = 0
			_log("Paul's defenses crumble with honesty!", COL_HEAL)

	_update_display()

	if GameState.hp <= 0:
		_end_battle(false)
		return

	_end_enemy_turn()

func _end_enemy_turn() -> void:
	player_turn = true
	_set_menu_enabled(true)
	_update_display()

# ══════════════════════════════════════════════════════════
# BATTLE END
# ══════════════════════════════════════════════════════════
func _end_battle(won: bool) -> void:
	battle_over = true
	_set_menu_enabled(false)

	if won:
		_log("───────────────", COL_NARRATOR)
		_log(enemy["defeat_text"], COL_DIALOGUE)
		_log("───────────────", COL_NARRATOR)
		_log("+%d Insight!" % enemy["xp"], COL_HEAL)
		_log("+%d Cacao Coins!" % enemy["cacao"], COL_HEAL)

		GameState.insight += enemy["xp"]
		GameState.cacao += enemy["cacao"]
		GameState.set_flag(enemy["defeat_flag"])

		for drop in enemy.get("drops", []):
			GameState.add_item(drop.duplicate(true))
			_log("Obtained: %s" % drop["name"], COL_EFFECT)

		if enemy_char:
			enemy_char.set_expression(StickCharacter.Emotion.SCARED)

		await get_tree().create_timer(1.5).timeout
		_show_victory(true)
	else:
		# EGO DEATH — use the death mechanic
		var death_msg = GameState.ego_death()
		_log(death_msg, COL_DIALOGUE)
		if steve_char:
			steve_char.set_expression(StickCharacter.Emotion.SCARED)

		await get_tree().create_timer(1.5).timeout
		_show_victory(false)

func _show_victory(won: bool) -> void:
	victory_overlay.visible = true
	if won:
		victory_title.text = "VICTORY"
		var drops_text = ", ".join(enemy.get("drops", []).map(func(d): return d["name"]))
		victory_text.text = "%s\n\n+%d Insight  +%d Cacao%s" % [
			enemy["defeat_text"],
			enemy["xp"],
			enemy["cacao"],
			"\nObtained: " + drops_text if drops_text != "" else ""
		]
	else:
		victory_title.text = "EGO DEATH"
		var death_msg = GameState.DEATH_MESSAGES[GameState.death_count % GameState.DEATH_MESSAGES.size()]
		victory_text.text = death_msg + "\n\nSteve wakes up in the dorms.\nHP restored to %d. EP restored to %d.\nNormality decreased by 5. (Steve is getting \"open\" against his will.)\n\n[ Click to continue ]" % [GameState.hp, GameState.ep]

func _on_overlay_clicked() -> void:
	# Always return to exploration after battle
	SceneManager.change_scene("res://scenes/exploration.tscn")

# ── Visual Effects ──
func _flash_node(node: Control, color: Color = Color(1.0, 0.4, 0.3)) -> void:
	if not node: return
	var orig = node.modulate
	var tween = create_tween()
	tween.tween_property(node, "modulate", color, 0.1)
	tween.tween_property(node, "modulate", orig, 0.2)
