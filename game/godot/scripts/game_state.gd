extends Node
## Global game state singleton. Tracks all player stats, inventory, flags, and progression.

# ── Signals ──
signal hp_changed(new_hp: int)
signal ep_changed(new_ep: int)
signal normality_changed(new_val: int)
signal insight_changed(new_val: int)
signal cacao_changed(new_val: int)
signal inventory_changed()
signal flag_set(flag_name: String)

# ── Player Stats ──
var max_hp: int = 100
var hp: int = 100:
	set(v):
		hp = clampi(v, 0, max_hp)
		hp_changed.emit(hp)

var max_ep: int = 50
var ep: int = 50:
	set(v):
		ep = clampi(v, 0, max_ep)
		ep_changed.emit(ep)

var normality: int = 90:  # 0-100 scale
	set(v):
		normality = clampi(v, 0, 100)
		normality_changed.emit(normality)

var insight: int = 0:
	set(v):
		insight = maxi(v, 0)
		insight_changed.emit(insight)

var cacao: int = 0:
	set(v):
		cacao = maxi(v, 0)
		cacao_changed.emit(cacao)

# ── Inventory ──
var inventory: Array[Dictionary] = []

# ── Flags (quest progress, dialogue memory) ──
var flags: Dictionary = {}

# ── Current zone tracking ──
var current_room_id: String = "pavilion"

func _ready() -> void:
	_init_inventory()

func _init_inventory() -> void:
	inventory = [
		{
			"id": "pamphlet",
			"name": "Orientation Pamphlet",
			"desc": "\"Welcome to The Sanctuary of Infinite Becoming! Please note the non-refundable deposit policy on page 3 (in very small print).\"",
			"type": "weapon",
			"equipped": true,
			"dmg": 5
		},
		{
			"id": "polo",
			"name": "Steve's Polo Shirt",
			"desc": "\"100% polyester. Machine washable. Spiritually impenetrable.\"",
			"type": "armor",
			"equipped": true,
			"def": 2
		},
		{
			"id": "energy_bar",
			"name": "Energy Bar",
			"desc": "\"From the glove compartment. Slightly melted. The most normal food within a 50-mile radius.\"",
			"type": "consumable",
			"heal": 20,
			"qty": 3
		},
		{
			"id": "receipt",
			"name": "Wife's Credit Card Receipt",
			"desc": "\"$2,400 for a Transformational Immersion (non-refundable). Steve has thoughts about the non-refundable part.\"",
			"type": "quest"
		}
	]
	inventory_changed.emit()

func set_flag(flag_name: String, value: Variant = true) -> void:
	flags[flag_name] = value
	flag_set.emit(flag_name)

func has_flag(flag_name: String) -> bool:
	return flags.has(flag_name)

func add_item(item: Dictionary) -> void:
	# Check if stackable item already exists
	for i in inventory.size():
		if inventory[i]["id"] == item["id"] and inventory[i].has("qty"):
			inventory[i]["qty"] += item.get("qty", 1)
			inventory_changed.emit()
			return
	inventory.append(item)
	inventory_changed.emit()

func remove_item(item_id: String) -> void:
	for i in inventory.size():
		if inventory[i]["id"] == item_id:
			if inventory[i].has("qty"):
				inventory[i]["qty"] -= 1
				if inventory[i]["qty"] <= 0:
					inventory.remove_at(i)
			else:
				inventory.remove_at(i)
			inventory_changed.emit()
			return

func get_consumables() -> Array[Dictionary]:
	var result: Array[Dictionary] = []
	for item in inventory:
		if item["type"] == "consumable" and item.get("qty", 1) > 0:
			result.append(item)
	return result

func reset() -> void:
	hp = max_hp
	ep = max_ep
	normality = 90
	insight = 0
	cacao = 0
	flags = {}
	current_room_id = "pavilion"
	_init_inventory()
