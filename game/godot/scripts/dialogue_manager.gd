extends Node
## Manages dialogue trees, typewriter text, and branching choices.

signal dialogue_started()
signal dialogue_line_shown(speaker: String, text: String, is_thought: bool)
signal choices_shown(choices: Array)
signal dialogue_finished()

var dialogue_data: Dictionary = {}
var current_tree: Array = []
var current_index: int = 0
var is_active: bool = false
var is_typing: bool = false
var _pending_callback: Callable

func _ready() -> void:
	_load_all_dialogues()

# ── Dialogue Data ──
func _load_all_dialogues() -> void:
	dialogue_data = {
		# ── Receptionist ──
		"receptionist": [
			{"speaker": "Receptionist", "text": "Namaste, beautiful soul! Welcome to The Sanctuary of Infinite Becoming. I can feel your energy from here. It's very... dense."},
			{"speaker": "Steve", "text": "I have a reservation. Steve Stevens. The weekend package."},
			{"speaker": "Receptionist", "text": "We don't use the word \"reservation\" here. You've set an INTENTION to arrive, and the universe has honored it."},
			{"speaker": "", "text": "(She opens a completely normal Excel spreadsheet.)", "thought": true},
			{"speaker": "Receptionist", "text": "Before we begin, I'll need your phone, any watches, and anything with a screen. We're creating a sacred container free from digital interference."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"My phone? Absolutely not.\"", "next": "receptionist_phone_no"},
				{"text": "\"Fine. Take it.\"", "next": "receptionist_phone_yes"},
				{"text": "\"Is there Wi-Fi here?\"", "next": "receptionist_wifi"}
			]}
		],
		"receptionist_phone_no": [
			{"speaker": "Receptionist", "text": "I hear your resistance. That's beautiful. The attachment you feel is exactly what we're here to release. Also it's mandatory — it says so in the waiver you signed online. On your phone."},
			{"speaker": "", "text": "(Steve reluctantly hands over his phone. He feels a phantom vibration in his pocket immediately.)", "thought": true},
			{"speaker": "", "text": "", "goto": "receptionist_name"}
		],
		"receptionist_phone_yes": [
			{"speaker": "Receptionist", "text": "Beautiful surrender. You're already doing the work."},
			{"speaker": "", "text": "(Steve hands over his phone. He feels a phantom vibration in his pocket immediately.)", "thought": true},
			{"speaker": "", "text": "", "goto": "receptionist_name"}
		],
		"receptionist_wifi": [
			{"speaker": "Receptionist", "text": "We find that disconnecting from the digital realm allows us to connect more deeply with..."},
			{"speaker": "Receptionist", "text": "(her voice drops to a whisper) ...there's none. There's no Wi-Fi. I haven't checked my email in nine weeks. I don't know what's happening out there. Is everything okay out there?"},
			{"speaker": "", "text": "(The smile returns.)", "thought": true},
			{"speaker": "Receptionist", "text": "I mean — isn't that LIBERATING?"},
			{"speaker": "", "text": "(Steve hands over his phone.)", "thought": true},
			{"speaker": "", "text": "", "goto": "receptionist_name"}
		],
		"receptionist_name": [
			{"speaker": "Receptionist", "text": "Now! Every guest receives a Sanskrit name to honor their soul's essence. I'm going to look into your eyes and channel the name that's been waiting for you across lifetimes."},
			{"speaker": "", "text": "(She stares at Steve for an uncomfortable amount of time.)", "thought": true},
			{"speaker": "Receptionist", "text": "...Akash Prem. Sky Love."},
			{"speaker": "Steve", "text": "My name is Steve."},
			{"speaker": "Receptionist", "text": "Steve is the name your PARENTS gave you. Akash Prem is the name your SOUL chose before incarnation."},
			{"speaker": "", "text": "(She hands you a name tag. It says \"Akash Prem\" in Comic Sans.)", "thought": true},
			{"speaker": "", "text": "", "goto": "receptionist_wife"}
		],
		"receptionist_wife": [
			{"speaker": "Steve", "text": "I'm looking for my wife. She was here a few weeks ago?"},
			{"speaker": "Receptionist", "text": "We honor the privacy of all souls who pass through The Sanctuary. I can't share details about another person's journey."},
			{"speaker": "Steve", "text": "She's my WIFE."},
			{"speaker": "Receptionist", "text": "She's the universe's wife, Steve. We all belong to each other. And also to ourselves. Especially to ourselves."},
			{"speaker": "Receptionist", "text": "I'd invite you to settle in first. Attend a session. Let the land hold you. The answers you seek will come when you stop seeking them."},
			{"speaker": "", "text": "(She touches her heart with both hands and bows. Steve is dismissed.)", "thought": true},
			{"speaker": "", "text": "(Maybe someone else here knows something. You should look around.)", "thought": true, "callback": "talked_receptionist"}
		],

		# ── Oil Warrior ──
		"oil_warrior": [
			{"speaker": "???", "text": "Hey! Hey, wait! Can I just — have you heard of doTERRA?"},
			{"speaker": "Steve", "text": "No."},
			{"speaker": "Essential Oil Warrior", "text": "It's not what you think. It's not a pyramid scheme. It's a WELLNESS ECOSYSTEM with a tiered distribution model."},
			{"speaker": "Steve", "text": "That is exactly what a pyramid scheme is."},
			{"speaker": "Essential Oil Warrior", "text": "A pyramid has a POINT at the TOP. This has a DIAMOND shape. Completely different geometry. Here — smell this."},
			{"speaker": "", "text": "(She thrusts a tiny bottle toward your face. The smell hits you like a forest fire in a health food store.)", "thought": true},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"Get that away from me.\"", "next": "oil_fight"},
				{"text": "\"How much do you actually make?\"", "next": "oil_fight"},
				{"text": "(Try to walk away)", "next": "oil_fight"}
			]}
		],
		"oil_fight": [
			{"speaker": "Essential Oil Warrior", "text": "RECEIVE THIS BLESSING!"},
			{"speaker": "", "text": "(She throws peppermint oil at you. It burns. Combat is unavoidable.)", "thought": true, "callback": "start_battle"}
		],

		# ── Frank ──
		"frank": [
			{"speaker": "", "text": "(A man in overalls is fixing a fence with actual tools. He is the first person you've seen doing real physical work without calling it \"sacred.\")", "thought": true},
			{"speaker": "Frank", "text": "You're new. Guest or volunteer?"},
			{"speaker": "Steve", "text": "Guest, I think. I paid money."},
			{"speaker": "Frank", "text": "You paid? Then you're a guest. The ones who didn't pay work harder. Funny system. Been trying to work it out for twelve years. Think it's called feudalism but with candles."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"I'm looking for my wife.\"", "next": "frank_wife"},
				{"text": "\"How long have you worked here?\"", "next": "frank_long"},
				{"text": "\"This place seems... unusual.\"", "next": "frank_unusual"}
			]}
		],
		"frank_wife": [
			{"speaker": "Frank", "text": "Your wife. What's she look like?"},
			{"speaker": "", "text": "(Steve describes her.)", "thought": true},
			{"speaker": "Frank", "text": "Yeah. I remember her. Helped me carry wood one afternoon. Only guest who ever did that. Then she stopped coming outside. Got pulled into the inner circle."},
			{"speaker": "Frank", "text": "The inner circle means The Founder took an interest. Real name's Derek. Don't tell anyone I told you that."},
			{"speaker": "Steve", "text": "Where is she now?"},
			{"speaker": "Frank", "text": "Gone. They always go. Derek sends them to the next place down the pipeline. Your wife's trail will be in his files. Back office or his cabin."},
			{"speaker": "", "text": "", "goto": "frank_end"}
		],
		"frank_long": [
			{"speaker": "Frank", "text": "Twelve years. Was here when it was a golf course. Better business model. At least golfers know they're wasting money."},
			{"speaker": "", "text": "", "goto": "frank_end"}
		],
		"frank_unusual": [
			{"speaker": "Frank", "text": "You know what I've learned in twelve years? These people talk about being present, but none of them can change a tire."},
			{"speaker": "Frank", "text": "They talk about connection but never asked my last name. They talk about non-attachment but try moving one of their crystals."},
			{"speaker": "Frank", "text": "Not bad people. Mostly. Just people who got lost looking for something and found a building instead."},
			{"speaker": "", "text": "", "goto": "frank_end"}
		],
		"frank_end": [
			{"speaker": "Frank", "text": "Tell you what, Steve. You seem alright. If you need anything practical — and I mean PRACTICAL, not energetic — come find me."},
			{"speaker": "", "text": "(Frank nods and returns to his fence. It's the most straightforward interaction you've had since arriving.)", "thought": true, "callback": "talked_frank"}
		],

		# ── Return visit dialogues ──
		"receptionist_return": [
			{"speaker": "Receptionist", "text": "Welcome back, Akash Prem! How are you LANDING today?"}
		],
		"frank_return": [
			{"speaker": "Frank", "text": "Still here? Good luck, accountant."}
		]
	}

func start_dialogue(tree_id: String) -> void:
	if not dialogue_data.has(tree_id):
		push_warning("Dialogue tree not found: " + tree_id)
		return
	current_tree = dialogue_data[tree_id]
	current_index = 0
	is_active = true
	dialogue_started.emit()
	_show_current_line()

func advance() -> void:
	if not is_active:
		return
	if is_typing:
		is_typing = false  # Skip typewriter, show full text
		return
	current_index += 1
	if current_index >= current_tree.size():
		_end_dialogue()
		return
	_show_current_line()

func select_choice(choice_index: int) -> void:
	var line = current_tree[current_index]
	if not line.has("choices"):
		return
	var choice = line["choices"][choice_index]
	if choice.has("next"):
		start_dialogue(choice["next"])

func _show_current_line() -> void:
	var line = current_tree[current_index]

	# Handle goto
	if line.has("goto"):
		start_dialogue(line["goto"])
		return

	# Handle choices
	if line.has("choices"):
		choices_shown.emit(line["choices"])
		return

	# Handle callback
	if line.has("callback"):
		_handle_callback(line["callback"])

	# Show the line
	var speaker: String = line.get("speaker", "")
	var text: String = line.get("text", "")
	var is_thought: bool = line.get("thought", false)

	if text == "" and not line.has("choices"):
		# Empty line, auto-advance
		current_index += 1
		if current_index < current_tree.size():
			_show_current_line()
		else:
			_end_dialogue()
		return

	is_typing = true
	dialogue_line_shown.emit(speaker, text, is_thought)

func _end_dialogue() -> void:
	is_active = false
	current_tree = []
	current_index = 0
	dialogue_finished.emit()

func _handle_callback(callback_name: String) -> void:
	match callback_name:
		"talked_receptionist":
			GameState.set_flag("talked_receptionist")
			GameState.insight += 1
		"talked_frank":
			GameState.set_flag("talked_frank")
			GameState.insight += 1
		"start_battle":
			GameState.set_flag("start_oil_battle")
