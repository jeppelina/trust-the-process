extends Node
class_name CharacterFactory
## Creates stick figure character nodes by NPC ID.
## Add new characters here as the game grows.

# Map of NPC IDs to their configuration
const NPC_CONFIG := {
	"receptionist": {
		"class": "generic",
		"name": "Receptionist",
		"accent": Color(0.83, 0.64, 0.29),
		"body_type": 0,  # NORMAL
		"hair_style": 2,  # bun
	},
	"oil_warrior": {
		"class": "oil_warrior",
		"name": "???",
		"accent": Color(0.83, 0.42, 0.54),
	},
	"frank": {
		"class": "frank",
		"name": "Frank",
		"accent": Color(0.60, 0.60, 0.54),
	},
	"maya": {
		"class": "maya",
		"name": "Maya",
		"accent": Color(0.72, 0.42, 0.30),
	},
	"brandon": {
		"class": "brandon",
		"name": "Brandon",
		"accent": Color(0.20, 0.65, 0.65),
	},
	"gatekeeper": {
		"class": "gatekeeper",
		"name": "Dharma John",
		"accent": Color(0.25, 0.22, 0.55),
	},
	"breathwork_monk": {
		"class": "breathwork_monk",
		"name": "Breathwork Monk",
		"accent": Color(0.42, 0.60, 0.83),
	},
	"cacao_dealer": {
		"class": "cacao_dealer",
		"name": "Cacao Dealer",
		"accent": Color(0.54, 0.83, 0.42),
	},
	"steve": {
		"class": "steve",
		"name": "Steve",
		"accent": Color(0.42, 0.54, 0.42),
	},
	"oversharer": {
		"class": "oversharer",
		"name": "The Oversharer",
		"accent": Color(0.42, 0.60, 0.83),
	},
	"founder": {
		"class": "founder",
		"name": "The Founder",
		"accent": Color(0.83, 0.64, 0.29),
	},
	"competitive_meditator": {
		"class": "competitive_meditator",
		"name": "The Competitive Meditator",
		"accent": Color(0.55, 0.30, 0.70),
	},
}

static func create_character(npc_id: String, override_name: String = "") -> StickCharacter:
	var config = NPC_CONFIG.get(npc_id, null)
	var character: StickCharacter

	if config == null:
		# Unknown NPC — create a basic generic
		character = CharGenericNPC.new()
		character.character_id = npc_id
		character.display_name = override_name if override_name != "" else npc_id.capitalize()
		return character

	match config["class"]:
		"steve":
			character = CharSteve.new()
		"oil_warrior":
			character = CharOilWarrior.new()
		"frank":
			character = CharFrank.new()
		"maya":
			character = CharMaya.new()
		"brandon":
			character = CharBrandon.new()
		"gatekeeper":
			character = CharGatekeeper.new()
		"breathwork_monk":
			character = CharBreathworkMonk.new()
		"cacao_dealer":
			character = CharCacaoDealer.new()
		"oversharer":
			character = CharOversharer.new()
		"founder":
			character = CharFounder.new()
		"competitive_meditator":
			character = CharCompetitiveMeditator.new()
		_:
			character = CharGenericNPC.new()
			if config.has("body_type"):
				(character as CharGenericNPC).body_type = config["body_type"] as CharGenericNPC.BodyType
			if config.has("hair_style"):
				(character as CharGenericNPC).hair_style = config["hair_style"]

	character.character_id = npc_id
	character.accent_color = config.get("accent", Color(0.83, 0.64, 0.29))

	if override_name != "":
		character.display_name = override_name
	else:
		character.display_name = config.get("name", npc_id.capitalize())

	return character
