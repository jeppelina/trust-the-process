extends Control
## Turn-based combat scene: Steve vs Essential Oil Warrior.

# ── Node References ──
@onready var steve_sprite: Label = %SteveSprite
@onready var steve_hp_bar: ProgressBar = %SteveHPBar
@onready var steve_hp_label: Label = %SteveHPLabel
@onready var steve_status_label: Label = %SteveStatusLabel
@onready var enemy_name_label: Label = %EnemyNameLabel
@onready var enemy_sprite: Label = %EnemySprite
@onready var enemy_hp_bar: ProgressBar = %EnemyHPBar
@onready var enemy_hp_label: Label = %EnemyHPLabel
@onready var enemy_status_label: Label = %EnemyStatusLabel

@onready var battle_log: RichTextLabel = %BattleLog
@onready var main_menu: VBoxContainer = %MainMenu
@onready var sub_menu: VBoxContainer = %SubMenu

@onready var victory_overlay: Control = %VictoryOverlay
@onready var victory_title: Label = %VictoryTitle
@onready var victory_text: RichTextLabel = %VictoryText

# ── Enemy Data ──
var enemy: Dictionary = {
	"name": "ESSENTIAL OIL WARRIOR",
	"emoji": "🧴",
	"hp": 45, "max_hp": 45,
	"atk": 12,
	"def": 0,
	"weakness": "bureaucratic",
	"attacks": [
		{
			"name": "Anoint",
			"dmg": 14,
			"msg": "\"RECEIVE THIS BLESSING!\" She hurls peppermint oil at Steve.",
			"effect": "smudge"
		},
		{
			"name": "MLM Pitch",
			"dmg": 10,
			"msg": "\"What if I told you that for a ONE-TIME investment of $150...\"",
			"effect": "enroll"
		},
		{
			"name": "\"It's Not a Pyramid\"",
			"dmg": 0,
			"msg": "\"A PYRAMID has a POINT. This is a DIAMOND. Completely different geometry.\"",
			"effect": "defend"
		}
	],
	"analyze_text": "Type: MLM Zealot\nWeakness: Bureaucratic (financial truth)\nResistance: Spiritual\nInventory invested: $6,000\nTotal sales: $340 (to her mother)\nNet position: -$5,660\n[color=#aa7744]NOTE: Spreadsheet Analysis may be instantly fatal.[/color]",
	"defeat_text": "\"My mother bought out of pity, didn't she.\"\n(She walks away slowly. Somehow this feels worse than winning.)",
	"xp": 3,
	"cacao": 25,
	"drops": [{"id": "oil_bottle", "name": "Tiny Bottle of Overpriced Oil", "desc": "\"Thieves Blend. Named after the historical plague remedy or the business model.\"", "type": "consumable", "qty": 1}]
}

# ── Battle State ──
var player_turn: bool = true
var battle_over: bool = false
var analyzed: bool = false
var smudged: int = 0
var enrolled: bool = false
var enrolled_timer: int = 0
var enduring: bool = false

func _ready() -> void:
	enemy_name_label.text = enemy["name"]
	enemy_sprite.text = enemy["emoji"]
	victory_overlay.visible = false
	sub_menu.visible = false
	_update_display()
	_log("\"Have you tried peppermint oil for your energy? You look like your chi is STAGNANT.\"", Color(0.54, 0.7, 0.83))
	_log("Battle Start!", Color(0.53, 0.47, 0.33))
	_set_menu_enabled(true)

func _update_display() -> void:
	steve_hp_bar.value = float(GameState.hp) / float(GameState.max_hp) * 100.0
	steve_hp_label.text = "%d/%d" % [GameState.hp, GameState.max_hp]
	enemy_hp_bar.value = float(enemy["hp"]) / float(enemy["max_hp"]) * 100.0
	enemy_hp_label.text = "%d/%d" % [enemy["hp"], enemy["max_hp"]]

	# Status text
	var statuses: PackedStringArray = []
	if smudged > 0:
		statuses.append("Smudged(%d)" % smudged)
	if enrolled:
		statuses.append("Enrolled(%d)" % (5 - enrolled_timer))
	steve_status_label.text = " | ".join(statuses)
	enemy_status_label.text = "DEF +%d" % enemy["def"] if enemy["def"] > 0 else ""

func _set_menu_enabled(on: bool) -> void:
	for btn in main_menu.get_children():
		if btn is Button:
			btn.disabled = not on

func _log(text: String, color: Color = Color(0.75, 0.72, 0.6)) -> void:
	battle_log.push_color(color)
	battle_log.append_text(text + "\n")
	battle_log.pop()
	# Scroll to bottom
	await get_tree().process_frame
	battle_log.scroll_to_line(battle_log.get_line_count())

# ── Menu Actions ──
func _on_attack_pressed() -> void:
	if not player_turn or battle_over:
		return
	_execute_player_turn("attack")

func _on_skills_pressed() -> void:
	if not player_turn or battle_over:
		return
	_show_submenu("skills")

func _on_talk_pressed() -> void:
	if not player_turn or battle_over:
		return
	_show_submenu("talk")

func _on_analyze_pressed() -> void:
	if not player_turn or battle_over:
		return
	_execute_player_turn("analyze")

func _on_items_pressed() -> void:
	if not player_turn or battle_over:
		return
	_show_submenu("items")

func _on_endure_pressed() -> void:
	if not player_turn or battle_over:
		return
	_execute_player_turn("endure")

func _show_submenu(menu_type: String) -> void:
	main_menu.visible = false
	sub_menu.visible = true

	# Clear old buttons
	for child in sub_menu.get_children():
		child.queue_free()

	# Back button
	var back_btn = Button.new()
	back_btn.text = "← Back"
	back_btn.add_theme_font_size_override("font_size", 18)
	back_btn.add_theme_color_override("font_color", Color(0.53, 0.47, 0.33))
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
	btn.add_theme_color_override("font_color", Color(0.54, 0.7, 0.83))
	if enabled and action != "":
		btn.pressed.connect(func():
			_hide_submenu()
			_execute_player_turn(action)
		)
	sub_menu.add_child(btn)

func _hide_submenu() -> void:
	sub_menu.visible = false
	main_menu.visible = true

# ── Player Turn ──
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
				_log("Steve swings the Orientation Pamphlet... and misses! (Smudged)", Color(0.53, 0.47, 0.33))
			else:
				var dmg = maxi(1, base_dmg - enemy["def"])
				_deal_enemy_dmg(dmg)
				_log("Steve attacks with the Orientation Pamphlet! %d damage!" % dmg, Color(0.8, 0.4, 0.27))

		"spreadsheet":
			GameState.ep -= 5
			_log("Steve pulls out a spreadsheet.", Color(0.53, 0.47, 0.33))
			_log("\"You've invested $6,000. Total sales: $340. Net position: -$5,660.\"", Color(0.54, 0.7, 0.83))
			if enemy["weakness"] == "bureaucratic":
				var dmg = enemy["hp"]
				_deal_enemy_dmg(dmg)
				_log("CRITICAL! Bureaucratic damage obliterates financial delusion! %d damage!" % dmg, Color(0.87, 0.27, 0.27))
			else:
				_deal_enemy_dmg(20)
				_log("Spreadsheet Analysis deals 20 bureaucratic damage!", Color(0.8, 0.4, 0.27))

		"schedule_opt":
			GameState.ep -= 4
			_log("\"I've blocked out 15 minutes for this conflict.\" Extra action!", Color(0.53, 0.47, 0.33))
			player_turn = true
			_set_menu_enabled(true)
			_update_display()
			return

		"risk_assess":
			GameState.ep -= 3
			_log("Steve evaluates the risk profile...", Color(0.53, 0.47, 0.33))
			_log("60% chance of oil stains. 30% chance of pyramid scheme enrollment. 10% chance of genuine personal growth (unacceptable).", Color(0.53, 0.47, 0.33))
			enemy["def"] = maxi(0, enemy["def"] - 2)
			_log("Enemy defense reduced!", Color(0.67, 0.47, 0.27))

		"audit":
			GameState.ep -= 8
			_log("Steve initiates a FULL AUDIT.", Color(0.53, 0.47, 0.33))
			_deal_enemy_dmg(25)
			enemy["def"] = 0
			_log("The audit deals 25 damage and strips all defenses!", Color(0.87, 0.27, 0.27))
			_log("\"Your LLC was filed incorrectly.\"", Color(0.54, 0.7, 0.83))

		"tax_writeoff":
			GameState.ep -= 4
			enduring = true
			_log("\"This confrontation is a deductible business expense.\" Next attack -50%.", Color(0.53, 0.47, 0.33))

		"talk_boundary":
			_log("Steve: \"I'm not interested. Thank you.\"", Color(0.54, 0.7, 0.83))
			_log("The Essential Oil Warrior is stunned by clear communication!", Color(0.67, 0.47, 0.27))
			_log("She sputters: \"But — you didn't even SMELL it properly—\"", Color(0.54, 0.7, 0.83))
			# Skip enemy turn
			_update_display()
			await get_tree().create_timer(0.8).timeout
			_end_enemy_turn()
			return

		"talk_question":
			_log("Steve: \"How much do you actually make from this?\"", Color(0.54, 0.7, 0.83))
			_deal_enemy_dmg(8)
			_log("8 psychic damage! (self-inflicted cognitive dissonance)", Color(0.8, 0.4, 0.27))
			_log("\"Well it's not about the MONEY — I mean there IS money — well...\"", Color(0.54, 0.7, 0.83))

		"talk_bore":
			_log("Steve explains the difference between FIFO and LIFO inventory methods.", Color(0.54, 0.7, 0.83))
			_deal_enemy_dmg(6)
			_log("6 damage from sheer boredom. Her will to sell weakens.", Color(0.8, 0.4, 0.27))

		"talk_validate":
			_log("Steve: \"It sounds like you really believe in what you're doing.\"", Color(0.54, 0.7, 0.83))
			enemy["atk"] = maxi(5, enemy["atk"] - 3)
			_log("She tears up. Attack power drops.", Color(0.67, 0.47, 0.27))
			_log("\"Nobody ever says that. Thank you.\" (Steve feels guilty.)", Color(0.54, 0.7, 0.83))

		"endure":
			enduring = true
			_log("Steve grits his teeth. Damage reduced this turn.", Color(0.53, 0.47, 0.33))
			_log("(He thinks about his desk. His ergonomic chair. The hum of fluorescent lighting.)", Color(0.53, 0.47, 0.33))

		"analyze":
			if analyzed:
				_log("Already analyzed. You know everything about her finances. It's depressing.", Color(0.53, 0.47, 0.33))
			else:
				analyzed = true
				_log("═══ ANALYSIS ═══", Color(0.53, 0.47, 0.33))
				battle_log.push_color(Color(0.53, 0.47, 0.33))
				battle_log.append_text(enemy["analyze_text"] + "\n")
				battle_log.pop()

		var item_action:
			if item_action.begins_with("use_item:"):
				var item_id = item_action.split(":")[1]
				_use_item(item_id)

	_update_display()

	if enemy["hp"] <= 0:
		_end_battle(true)
		return

	await get_tree().create_timer(0.8).timeout
	_enemy_turn()

func _deal_enemy_dmg(dmg: int) -> void:
	enemy["hp"] = maxi(0, enemy["hp"] - dmg)
	_flash_sprite(enemy_sprite)

func _use_item(item_id: String) -> void:
	for item in GameState.inventory:
		if item["id"] == item_id:
			if item.has("heal"):
				var heal = mini(item["heal"], GameState.max_hp - GameState.hp)
				GameState.hp += heal
				_log("Steve uses %s. Restored %d HP!" % [item["name"], heal], Color(0.42, 0.54, 0.29))
				if item_id == "energy_bar":
					_log("(Slightly melted but it tastes like civilization.)", Color(0.53, 0.47, 0.33))
				_flash_sprite(steve_sprite, Color(0.4, 0.8, 0.4))
			GameState.remove_item(item_id)
			break

# ── Enemy Turn ──
func _enemy_turn() -> void:
	if battle_over:
		return

	# Tick status effects
	if smudged > 0:
		smudged -= 1
		if smudged == 0:
			_log("The smudge smoke clears.", Color(0.53, 0.47, 0.33))

	if enrolled:
		enrolled_timer += 1
		GameState.cacao = maxi(0, GameState.cacao - 5)
		_log("Enrolled! Steve loses 5 cacao to the subscription.", Color(0.67, 0.47, 0.27))
		if enrolled_timer >= 5:
			_log("The starter kit ships. Steve loses 150 cacao.", Color(0.87, 0.27, 0.27))
			GameState.cacao = maxi(0, GameState.cacao - 150)
			enrolled = false

	# Pick attack
	var atk = enemy["attacks"][randi() % enemy["attacks"].size()]

	_log("%s uses %s!" % [enemy["name"], atk["name"]], Color(0.53, 0.47, 0.33))
	_log(atk["msg"], Color(0.54, 0.7, 0.83))

	if atk["dmg"] > 0:
		var dmg = atk["dmg"] + randi_range(-2, 2)
		if enduring:
			dmg = dmg / 2
			_log("(Endure reduces damage!)", Color(0.53, 0.47, 0.33))
		dmg = maxi(1, dmg)
		GameState.hp -= dmg
		_log("Steve takes %d damage!" % dmg, Color(0.8, 0.4, 0.27))
		_flash_sprite(steve_sprite, Color(1.0, 0.3, 0.3))

	# Apply effect
	match atk["effect"]:
		"smudge":
			if smudged == 0:
				smudged = 3
				_log("Steve is Smudged! (Accuracy -20% for 3 turns)", Color(0.67, 0.47, 0.27))
		"enroll":
			if not enrolled:
				enrolled = true
				enrolled_timer = 0
				_log("Steve is being Enrolled! (Losing cacao each turn)", Color(0.67, 0.47, 0.27))
		"defend":
			enemy["def"] += 3
			_log("Essential Oil Warrior's defense increased!", Color(0.67, 0.47, 0.27))

	_update_display()

	if GameState.hp <= 0:
		_end_battle(false)
		return

	_end_enemy_turn()

func _end_enemy_turn() -> void:
	player_turn = true
	_set_menu_enabled(true)
	_update_display()

# ── Battle End ──
func _end_battle(won: bool) -> void:
	battle_over = true
	_set_menu_enabled(false)

	if won:
		_log("───────────────", Color(0.53, 0.47, 0.33))
		_log(enemy["defeat_text"], Color(0.54, 0.7, 0.83))
		_log("───────────────", Color(0.53, 0.47, 0.33))
		_log("+%d Insight!" % enemy["xp"], Color(0.83, 0.64, 0.29))
		_log("+%d Cacao Coins!" % enemy["cacao"], Color(0.75, 0.56, 0.25))

		GameState.insight += enemy["xp"]
		GameState.cacao += enemy["cacao"]
		GameState.set_flag("oil_defeated")

		for drop in enemy["drops"]:
			GameState.add_item(drop.duplicate(true))
			_log("Obtained: %s" % drop["name"], Color(0.67, 0.47, 0.27))

		await get_tree().create_timer(1.5).timeout
		_show_victory(true)
	else:
		_log("Steve collapses. Not from the oils. From the exhaustion of a world that makes no sense.", Color(0.53, 0.47, 0.33))
		await get_tree().create_timer(1.5).timeout
		_show_victory(false)

func _show_victory(won: bool) -> void:
	victory_overlay.visible = true
	if won:
		victory_title.text = "VICTORY"
		victory_text.text = "%s\n\n+%d Insight  +%d Cacao\nObtained: %s" % [
			enemy["defeat_text"],
			enemy["xp"],
			enemy["cacao"],
			", ".join(enemy["drops"].map(func(d): return d["name"]))
		]
	else:
		victory_title.text = "DEFEAT"
		victory_text.text = "Steve sits on the floor and refuses to continue.\nHis Homeostasis Points have reached zero.\n\nThe Essential Oil Warrior leaves a business card on his chest.\n\"Call me when you're ready to invest in yourself.\""

func _on_overlay_clicked() -> void:
	if victory_title.text == "VICTORY":
		SceneManager.change_scene("res://scenes/exploration.tscn")
	else:
		GameState.hp = GameState.max_hp
		GameState.ep = GameState.max_ep
		# Restart battle
		get_tree().reload_current_scene()

# ── Visual Effects ──
func _flash_sprite(sprite: Label, color: Color = Color(1.0, 0.4, 0.3)) -> void:
	var orig = sprite.modulate
	var tween = create_tween()
	tween.tween_property(sprite, "modulate", color, 0.1)
	tween.tween_property(sprite, "modulate", orig, 0.2)
