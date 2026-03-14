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
			{"speaker": "Receptionist", "text": "Here's a map of the grounds. Your assigned space is in the dorms. The kitchen serves at five. And remember — there are no strangers here, only fellow travelers."},
			{"speaker": "", "text": "(She hands you a hand-drawn map on recycled paper. It smells like lavender.)", "thought": true, "callback": "add_retreat_map"},
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
			{"speaker": "", "text": "(She throws peppermint oil at you. It burns. Combat is unavoidable.)", "thought": true, "callback": "start_oil_battle"}
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
		],

		# ── Maya (Kitchen) ──
		"maya_kitchen": [
			{"speaker": "", "text": "(A woman with tired eyes is washing dishes in the industrial kitchen. She looks up sharply when you enter.)", "thought": true},
			{"speaker": "Maya", "text": "We're not serving until five. Kitchen's closed."},
			{"speaker": "Steve", "text": "I'm looking for my wife. She was here maybe three months ago?"},
			{"speaker": "", "text": "(Maya's hands go still in the dishwater. She doesn't turn around.)", "thought": true},
			{"speaker": "Maya", "text": "I don't know anything."},
			{"speaker": "Steve", "text": "You're lying. You froze when I mentioned it."},
			{"speaker": "Maya", "text": "(quietly) Too many ears in here. Meet me at the fire pit after the evening program. When the stupid meditation circle is over. Don't tell anyone."},
			{"speaker": "Steve", "text": "How long have you been here?"},
			{"speaker": "Maya", "text": "Seven months. On a two-week stay. (bitter laugh) I attended the sharing circle once. That was a mistake. Then Derek paid attention to me. And now I'm still here."},
			{"speaker": "Maya", "text": "Attend the sharing circle tonight. You'll understand. Maybe you'll see things I don't."},
			{"speaker": "", "text": "(Maya returns to the dishes. The conversation is over.)", "thought": true, "callback": "talked_maya"}
		],

		# ── Maya (Return Visit) ──
		"maya_return": [
			{"speaker": "Maya", "text": "(glancing toward the door) Fire pit. After the circle. Don't be late."},
			{"speaker": "", "text": "", "callback": ""}
		],

		# ── Maya (Fire Pit) — KEY SCENE ──
		"maya_firepit": [
			{"speaker": "", "text": "(The fire pit is ringed with benches. Sparks rise into the night sky. Maya sits alone, silhouetted by orange light.)", "thought": true},
			{"speaker": "Maya", "text": "Your wife arrived three months ago. She worked in the kitchen with me at first. She was practical. Smart. She asked questions about why volunteers did all the work and Derek took all the money."},
			{"speaker": "Maya", "text": "He noticed her immediately. He always notices the smart ones. Invited her to the inner circle — that means private sessions in his cabin."},
			{"speaker": "Maya", "text": "After two weeks, she was gone. Derek gave her a recommendation letter to Pranayama Peak — the next place on the pipeline. Each retreat feeds the next one. It's like... a supply chain."},
			{"speaker": "", "text": "(She pokes the fire with a stick. Embers scatter.)", "thought": true},
			{"speaker": "Steve", "text": "Does he have her documents? Passport?"},
			{"speaker": "Maya", "text": "He has everyone's. He calls it 'safekeeping.' Really, he just holds them. Makes you more likely to come back. Or recommend your friends."},
			{"speaker": "Maya", "text": "He has her passport. He has mine too. That's why I'm still here."},
			{"speaker": "Steve", "text": "Then we get them back."},
			{"speaker": "Maya", "text": "The documents are in the back office. Next to the ceremony space. The Gatekeeper sits at the entrance but he falls asleep after 10pm meditation. The ceremony space connects to it through a back passage."},
			{"speaker": "Maya", "text": "If you're going in there, grab my documents too. And don't get caught. Derek doesn't react well to... audits."},
			{"speaker": "", "text": "(The fire crackles. In the distance, someone is humming a didgeridoo.)", "thought": true, "callback": "firepit_done"}
		],

		# ── Maya (Post Boss) ──
		"maya_post_boss": [
			{"speaker": "", "text": "(Maya stands at the sanctuary gates, holding a worn passport.)", "thought": true},
			{"speaker": "Maya", "text": "Thank you. I've been here seven months. I almost forgot what outside felt like."},
			{"speaker": "Steve", "text": "Are you going to look for her? Your wife?"},
			{"speaker": "Maya", "text": "She's not the same person you married. Derek's pipeline doesn't just move bodies — it transforms them."},
			{"speaker": "Steve", "text": "Neither am I. I just restructured a wellness center that was running at two million in annual revenue. That's not in my job description."},
			{"speaker": "", "text": "(Maya almost smiles.)", "thought": true},
			{"speaker": "Maya", "text": "Good luck, Steve. Pranayama Peak is north of here. Three days' drive if you follow the recommendations."}
		],

		# ── Brandon (Arrival) ──
		"brandon_arrive": [
			{"speaker": "", "text": "(A young man with a backward baseball cap bounces on the bunk above yours.)", "thought": true},
			{"speaker": "Brandon", "text": "Dude! Welcome! You are going to LOVE it here. This place is incredible!"},
			{"speaker": "Steve", "text": "I've been here for four hours."},
			{"speaker": "Brandon", "text": "Exactly! Isn't it amazing? I just got here yesterday. The energy is like... (gestures wildly) ...everywhere."},
			{"speaker": "", "text": "(He jumps down and pulls a yoga mat from his backpack.)", "thought": true},
			{"speaker": "Brandon", "text": "I'm Brandon, by the way. Well, spiritually I'm Surya. But Brandon for official stuff. You should come to yoga with me this afternoon. It's going to change your life. I can feel it."},
			{"speaker": "Steve", "text": "Where's your watch?"},
			{"speaker": "Brandon", "text": "Oh man, I donated it! They have this gratitude fund and I just felt like... why am I enslaved to timekeeping, you know?"},
			{"speaker": "", "text": "(He looks genuinely happy about this poor decision.)", "thought": true},
			{"speaker": "Brandon", "text": "You should donate something too. It's liberation, bro."},
			{"speaker": "", "text": "", "callback": "talked_brandon"}
		],

		# ── Brandon (Act 2) ──
		"brandon_act2": [
			{"speaker": "Brandon", "text": "Hey brother! I'm feeling my edges dissolve, you know? Like, I'm becoming one with the universe."},
			{"speaker": "Steve", "text": "That's... concerning."},
			{"speaker": "Brandon", "text": "No, man, it's beautiful. The Founder — Derek — he talked to me for like three hours last night. He said I have special sensitivity. I've only been here two days and I'm already in the inner circle."},
			{"speaker": "", "text": "(Brandon's pupils are dilated. His gaze is unfocused.)", "thought": true},
			{"speaker": "Brandon", "text": "Everything is vibrations, bro. I can hear the vibrations. They're so loud..."},
			{"speaker": "Steve", "text": "When was the last time you ate?"},
			{"speaker": "Brandon", "text": "Food is densifying. The Founder says enlightenment requires fasting. I feel so light, man. So... light..."}
		],

		# ── Brandon (Night) ──
		"brandon_night": [
			{"speaker": "", "text": "(Brandon stands in the garden at 2 AM, staring at the moon. His hands are open at his sides. He doesn't blink.)", "thought": true},
			{"speaker": "Brandon", "text": "Akash... the universe is singing... can you hear it..."},
			{"speaker": "Steve", "text": "Brandon, we need to get you out of here."},
			{"speaker": "Brandon", "text": "(dreamily) I am the universe... I am the song... I am the dissolution..."},
			{"speaker": "", "text": "(He hasn't slept in forty hours. His mind is gone.)", "thought": true}
		],

		# ── Brandon (Post Boss) ──
		"brandon_post_boss": [
			{"speaker": "", "text": "(Brandon is sitting on the front steps, shaking. He looks at his own hands like he's meeting them for the first time.)", "thought": true},
			{"speaker": "Brandon", "text": "I... I can think again. What day is it?"},
			{"speaker": "Steve", "text": "Tuesday. Or Wednesday. Time's weird here."},
			{"speaker": "Brandon", "text": "My dad gave me that watch. My Timex. I told him I'd carry it forever. I... I gave it to Derek. For a gratitude fund that I've never seen receipts for."},
			{"speaker": "", "text": "(Brandon stares at his empty wrist. Tears are forming.)", "thought": true},
			{"speaker": "Brandon", "text": "What was he doing to me?"}
		],

		# ── Cacao Dealer ──
		"cacao_dealer_shop": [
			{"speaker": "", "text": "(A figure in a dark hoodie appears at the kitchen's back door. He's carrying a small canvas bag.)", "thought": true},
			{"speaker": "Cacao Dealer", "text": "Pssst. You didn't get this from me."},
			{"speaker": "Steve", "text": "Is this... a black market?"},
			{"speaker": "Cacao Dealer", "text": "I prefer 'alternative distribution network.' Anyway. They took your phone. Probably told you it was liberating."},
			{"speaker": "Cacao Dealer", "text": "I have things that will help. Things that are... discouraged here."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"What are you selling?\"", "next": "cacao_dealer_inventory"},
				{"text": "(Walk away)", "next": ""}
			]}
		],

		"cacao_dealer_inventory": [
			{"speaker": "Cacao Dealer", "text": "Actual Coffee. Real stuff. 80 cacao per cup."},
			{"speaker": "Cacao Dealer", "text": "Cacao Ceremony Drink. The good kind, not the spiritual kind. 50 cacao."},
			{"speaker": "Cacao Dealer", "text": "Kombucha. Gas, but at least it's fermented. 20 cacao."},
			{"speaker": "Cacao Dealer", "text": "And... WiFi password to the admin network. 100 cacao. You didn't get this from me."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"Actual Coffee.\" (80 cacao)", "next": "", "callback": "add_coffee"},
				{"text": "\"Cacao Ceremony Drink.\" (50 cacao)", "next": "", "callback": "add_cacao_drink"},
				{"text": "\"Kombucha.\" (20 cacao)", "next": "", "callback": "add_kombucha"},
				{"text": "\"WiFi password.\" (100 cacao)", "next": "", "callback": "add_wifi_password"},
				{"text": "\"Never mind.\"", "next": ""}
			]}
		],

		# ── Meditator Challenge ──
		"meditator_challenge": [
			{"speaker": "", "text": "(A man sits cross-legged in the movement studio, eyes closed. His jaw is clenched. You feel him register your presence before you enter.)", "thought": true},
			{"speaker": "Meditator", "text": "(not opening his eyes) I sensed a disturbance."},
			{"speaker": "", "text": "(His eyes snap open, blazing with intensity.)", "thought": true},
			{"speaker": "Meditator", "text": "Your energy is... nascent. Unrefined."},
			{"speaker": "Steve", "text": "I'm not here for energy criticism."},
			{"speaker": "Meditator", "text": "Yet here you are. In my space. Disrupting my practice. This is a test."},
			{"speaker": "Meditator", "text": "Prove your practice. Fight me. If you win, I will show you the path to the Ceremony Space."},
			{"speaker": "", "text": "", "callback": "start_meditator_battle"}
		],

		# ── Meditator (Post) ──
		"meditator_post": [
			{"speaker": "", "text": "(The meditator is on his knees, breathing hard.)", "thought": true},
			{"speaker": "Meditator", "text": "Your... unconventional approach has merit. I have underestimated the power of spreadsheet-based martial arts."},
			{"speaker": "Meditator", "text": "The real work happens in the Ceremony Space, but the Gatekeeper guards it. He's been Derek's instrument for three years."},
			{"speaker": "Meditator", "text": "There is a back passage through the Back Office. If you can get past the Gatekeeper, you can access it."},
			{"speaker": "", "text": "", "callback": "meditator_intel"}
		],

		# ── Sharing Circle ──
		"sharing_circle": [
			{"speaker": "", "text": "(The main hall has been arranged in a circle. About 30 people sit on cushions. There's a fire pit in the center. Someone starts playing a didgeridoo.)", "thought": true},
			{"speaker": "Facilitator", "text": "Welcome, beautiful souls, to our sharing circle. This is a sacred space. What's shared in circle stays in circle. Unless it needs processing in another circle."},
			{"speaker": "Facilitator", "text": "Who wants to begin?"},
			{"speaker": "", "text": "(A woman's hand shoots up. She's shaking with emotion.)", "thought": true},
			{"speaker": "The Oversharer", "text": "(sobbing) I just... I used to work in corporate. In marketing. And I was dead inside. So dead."},
			{"speaker": "The Oversharer", "text": "But this journey... being here... it's given me... I don't even know who I am yet but it's better than who I was!"},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"That's beautiful. Thank you for sharing.\" (Validate)", "next": "sharing_circle_r1_validate"},
				{"text": "\"Have you considered your ROI on this emotional labor?\" (Deflect)", "next": "sharing_circle_r1_deflect"},
				{"text": "(Say nothing. Just sit with it.)", "next": "sharing_circle_r1_endure"}
			]}
		],

		"sharing_circle_r1_validate": [
			{"speaker": "Steve", "text": "That's beautiful. Thank you for sharing your truth."},
			{"speaker": "The Oversharer", "text": "(beaming through tears) Oh my god, thank you. That means so much."},
			{"speaker": "", "text": "(Everyone nods sagely. You've passed the first test of spiritual conformity.)", "thought": true, "callback": "add_insight"},
			{"speaker": "", "text": "", "goto": "sharing_circle_r2"}
		],

		"sharing_circle_r1_deflect": [
			{"speaker": "Steve", "text": "Have you calculated the ROI on this emotional labor? From a cost-benefit standpoint?"},
			{"speaker": "", "text": "(Long silence.)", "thought": true},
			{"speaker": "The Oversharer", "text": "(confused) I... what?"},
			{"speaker": "Facilitator", "text": "Let's honor all perspectives in circle."},
			{"speaker": "", "text": "(You've made the first enemy at the Sanctuary.)", "thought": true},
			{"speaker": "", "text": "", "goto": "sharing_circle_r2"}
		],

		"sharing_circle_r1_endure": [
			{"speaker": "", "text": "(Steve says nothing. The silence stretches. The Oversharer finishes her sentence and sits down, satisfied.)", "thought": true},
			{"speaker": "The Oversharer", "text": "Thank you for witnessing my process."},
			{"speaker": "", "text": "", "goto": "sharing_circle_r2"}
		],

		"sharing_circle_r2": [
			{"speaker": "Facilitator", "text": "Akash Prem. We haven't heard from you yet. What brought you to The Sanctuary?"},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"My wife disappeared here. I need to find her.\" (Honest)", "next": "sharing_circle_r2_honest"},
				{"text": "\"Professional development and synergistic alignment.\" (Corporate)", "next": "sharing_circle_r2_corporate"},
				{"text": "\"I'm just observing. Processing quietly.\" (Refuse)", "next": "sharing_circle_r2_refuse"}
			]}
		],

		"sharing_circle_r2_honest": [
			{"speaker": "Steve", "text": "My wife came here three months ago. She disappeared. I'm here to find her."},
			{"speaker": "", "text": "(The circle goes very still.)", "thought": true},
			{"speaker": "Facilitator", "text": "We honor your journey of reunion. When we're ready, what we seek finds us."},
			{"speaker": "", "text": "(It's clear no one in this circle is going to help.)", "thought": true},
			{"speaker": "", "text": "", "goto": "sharing_circle_r3"}
		],

		"sharing_circle_r2_corporate": [
			{"speaker": "Steve", "text": "Professional development. Synergistic team alignment. Exploring paradigm shifts in organizational wellness."},
			{"speaker": "", "text": "(Everyone nods enthusiastically.)", "thought": true},
			{"speaker": "Facilitator", "text": "Beautiful corporate framing of your soul's work."},
			{"speaker": "", "text": "", "goto": "sharing_circle_r3"}
		],

		"sharing_circle_r2_refuse": [
			{"speaker": "Steve", "text": "I'm still processing. Observing with reverence."},
			{"speaker": "Facilitator", "text": "Wise. Silent witnessing is a profound practice."},
			{"speaker": "", "text": "", "goto": "sharing_circle_r3"}
		],

		"sharing_circle_r3": [
			{"speaker": "Facilitator", "text": "Now we move into our final exercise. A vibrational alignment."},
			{"speaker": "Facilitator", "text": "This requires us to make sounds from our root chakra. Deep sounds. Primal sounds."},
			{"speaker": "", "text": "(Everyone is looking at you expectantly.)", "thought": true},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"Let's do it.\" (Join in)", "next": "sharing_circle_r3_join"},
				{"text": "(Sit quietly and don't participate)", "next": "sharing_circle_r3_sit"},
				{"text": "\"I need air. Excuse me.\" (Leave)", "next": "sharing_circle_r3_leave"}
			]}
		],

		"sharing_circle_r3_join": [
			{"speaker": "", "text": "(Steve takes a deep breath and makes a low, humiliating sound from his diaphragm. OOOOOOHHHHMMMMM.)", "thought": true},
			{"speaker": "", "text": "(Everyone joins in. The sound is deafening and deeply embarrassing.)", "thought": true},
			{"speaker": "", "text": "", "goto": "sharing_circle_end"}
		],

		"sharing_circle_r3_sit": [
			{"speaker": "", "text": "(Steve sits silently while 30 people make primal chakra sounds around him. He is invisible. He is also very conspicuous.)", "thought": true},
			{"speaker": "The Oversharer", "text": "(opening one eye) Are you okay? Do you want to process?"},
			{"speaker": "Steve", "text": "I'm good."},
			{"speaker": "", "text": "", "goto": "sharing_circle_end"}
		],

		"sharing_circle_r3_leave": [
			{"speaker": "Steve", "text": "I need some air."},
			{"speaker": "", "text": "(Steve stands and walks toward the exit. The Oversharer immediately gets up and follows him.)", "thought": true},
			{"speaker": "The Oversharer", "text": "Can I process with you about this? I feel like I triggered something for you."},
			{"speaker": "", "text": "", "goto": "sharing_circle_end"}
		],

		"sharing_circle_end": [
			{"speaker": "Facilitator", "text": "Remember: what happens in circle stays in circle. Unless it needs processing in another circle."},
			{"speaker": "", "text": "(The sharing circle disbands. People wander off into the night with glazed expressions.)", "thought": true},
			{"speaker": "", "text": "(The fire pit should be accessible now. The meditation is over. Maya will be waiting.)", "thought": true, "callback": "circle_done"}
		],

		# ── Gatekeeper ──
		"gatekeeper_confront": [
			{"speaker": "", "text": "(The Ceremony Space is a large yurt with a fabric door. Standing in front of it is a man with a shaved head and an inexplicable accent that shifts between South African and New Jersey.)", "thought": true},
			{"speaker": "Gatekeeper", "text": "You are not ready. The Ceremony Space exists in a frequency beyond human comprehension."},
			{"speaker": "Steve", "text": "It's a tent."},
			{"speaker": "Gatekeeper", "text": "Yes. A sacred tent. Your energy is not aligned."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"Let me through.\" (Challenge)", "next": "gatekeeper_challenge"},
				{"text": "\"What do I need to do to be ready?\" (Reason)", "next": "gatekeeper_reason"},
				{"text": "\"You were a Verizon manager in 2024, weren't you?\" (Expose — Insight ≥5)", "next": "gatekeeper_exposed"}
			]}
		],

		"gatekeeper_reason": [
			{"speaker": "Gatekeeper", "text": "You must pass through seventeen levels of inner work. Each level takes a month."},
			{"speaker": "Steve", "text": "I don't have seventeen months."},
			{"speaker": "Gatekeeper", "text": "Then you're not ready. Such is the path of enlightenment."},
			{"speaker": "", "text": "(The Gatekeeper sits back down in lotus position, fully blocking the entrance.)", "thought": true}
		],

		"gatekeeper_challenge": [
			{"speaker": "Gatekeeper", "text": "You wish to challenge the Gatekeeper?"},
			{"speaker": "Steve", "text": "I wish to walk through that door."},
			{"speaker": "Gatekeeper", "text": "Then we fight. Your spirit against my disciplined consciousness."},
			{"speaker": "", "text": "", "callback": "start_gatekeeper_battle"}
		],

		"gatekeeper_exposed": [
			{"speaker": "", "text": "(Steve leans in close. He lowers his voice.)", "thought": true},
			{"speaker": "Steve", "text": "You worked for Verizon. In 2024. You were a district manager. Your name was Dave Carver. You have seventeen LinkedIn recommendations from people who call you a 'people person.'"},
			{"speaker": "", "text": "(The Gatekeeper's eyes go wide. His accent drops.)", "thought": true},
			{"speaker": "Gatekeeper", "text": "How did you... no. No. That was a different life. A life of corporate enslavement."},
			{"speaker": "Steve", "text": "You're still enslaved. You're just doing it for free."},
			{"speaker": "", "text": "(The Gatekeeper stands slowly. His entire façade cracks.)", "thought": true},
			{"speaker": "Gatekeeper", "text": "I... I needed to believe I was something more than a middle manager."},
			{"speaker": "Steve", "text": "The back office. Where is it?"},
			{"speaker": "Gatekeeper", "text": "(defeated) Behind the ceremony space. Through the back flap. The door's not locked."},
			{"speaker": "", "text": "", "callback": "gatekeeper_cleared"}
		],

		# ── Back Office Discover ──
		"back_office_discover": [
			{"speaker": "", "text": "(The back office is a jarring contrast. Fluorescent lights. A file cabinet. A desk with a surprisingly modern laptop. Spreadsheets. This is the real Sanctuary.)", "thought": true},
			{"speaker": "", "text": "(Steve opens the filing cabinet. Inside: dozens of passports. Recommendation letters in a neat stack. Bank statements.)", "thought": true},
			{"speaker": "Steve", "text": "(reading) One point two million in annual revenue. One hundred eighty thousand to a personal LLC. Forty unpaid volunteers on the roster."},
			{"speaker": "", "text": "(Steve finds his wife's recommendation letter. Dated three months ago. Addressed to Pranayama Peak. Recommends her for 'advanced work.')", "thought": true},
			{"speaker": "", "text": "(Steve finds Maya's passport. He finds documents for seven other people.)", "thought": true},
			{"speaker": "", "text": "(The lights change. The yurt flap opens.)", "thought": true},
			{"speaker": "The Founder", "text": "I thought you might end up here."},
			{"speaker": "", "text": "(Derek stands in the doorway. He's wearing white linen. He's smiling.)", "thought": true},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"I'm leaving with these documents.\" (Refuse)", "next": "founder_battle_start"},
				{"text": "\"What if I'm interested in a deal?\" (Accept)", "next": "founder_prefight"}
			]}
		],

		# ── Founder (Pre-fight) ──
		"founder_prefight": [
			{"speaker": "The Founder", "text": "I was hoping you might be practical."},
			{"speaker": "The Founder", "text": "Take the recommendation letter. Go north to Pranayama Peak. Tell your wife the Sanctuary is wonderful. Forget the other documents."},
			{"speaker": "The Founder", "text": "I'm not a bad man. I'm running a business. Everyone here wants to be here. Until they don't. Then they go somewhere else."},
			{"speaker": "Steve", "text": "You're holding their passports."},
			{"speaker": "The Founder", "text": "For safekeeping. A small incentive to keep people engaged."},
			{"speaker": "", "text": "", "choices": [
				{"text": "\"I'll take your deal.\"", "next": "founder_end_walk"},
				{"text": "\"I'm not leaving without the passports.\"", "next": "founder_battle_start"}
			]}
		],

		# ── Founder Battle Start ──
		"founder_battle_start": [
			{"speaker": "The Founder", "text": "I really hoped you wouldn't do that."},
			{"speaker": "", "text": "(Derek closes the yurt door. Brandon enters from a side passage, still dazed, ready to fight.)", "thought": true},
			{"speaker": "", "text": "", "callback": "start_founder_battle"}
		],

		# ── Founder End (Walk Away) ──
		"founder_end_walk": [
			{"speaker": "The Founder", "text": "Smart man. Your wife would be proud. Actually — she'd be disappointed. She was more idealistic than you."},
			{"speaker": "Steve", "text": "Good thing I don't care what she thinks anymore."},
			{"speaker": "The Founder", "text": "(nodding) That's the spirit. Here. Take the letter."},
			{"speaker": "", "text": "(Steve walks out with the recommendation letter. He knows where his wife is, but not who she's become. It feels like winning.)", "thought": true},
			{"speaker": "", "text": "", "goto": "departure"}
		],

		# ── Founder End (Restructure) ──
		"founder_end_restructure": [
			{"speaker": "Steve", "text": "You're not running this place efficiently. Wrong LLC structure. Volunteers need to be either contractors or employees. You're exposed to litigation."},
			{"speaker": "The Founder", "text": "I... what?"},
			{"speaker": "Steve", "text": "I'm going to fix it. New org chart. Payroll system. Quarterly reports. You'll make more money and have legal compliance."},
			{"speaker": "", "text": "(Two weeks later: The Sanctuary runs like an actual business. Derek is now Community Coordinator. His title is smaller but his liability is gone.)", "thought": true},
			{"speaker": "", "text": "(Steve has accidentally done to the Sanctuary what he was supposed to do for his marriage: made it more efficient.)", "thought": true},
			{"speaker": "", "text": "", "goto": "departure"}
		],

		# ── Founder End (Destroy) ──
		"founder_end_destroy": [
			{"speaker": "Steve", "text": "I'm sending this to the state. All of it. Financial documents, volunteer agreements, passport holder records."},
			{"speaker": "The Founder", "text": "You'll ruin it."},
			{"speaker": "Steve", "text": "Yes."},
			{"speaker": "", "text": "(Three weeks later: The Sanctuary is shut down. The volunteers are scattered. Derek is under investigation. Eight people are homeless because they donated all their money and quit their jobs.)", "thought": true},
			{"speaker": "", "text": "(Steve saved the people he could. But there are costs.)", "thought": true},
			{"speaker": "", "text": "", "goto": "departure"}
		],

		# ── Departure ──
		"departure": [
			{"speaker": "", "text": "(Steve drives out of The Sanctuary. At the gate, they return his phone.)", "thought": true},
			{"speaker": "", "text": "(847 emails. 23 missed calls. A voicemail from his boss. Another from the bank. One text from an unknown number.)", "thought": true},
			{"speaker": "", "text": "Unknown: Your wife is at Pranayama Peak, two hours north. Room 7. She's expecting someone. Don't let her down.", "thought": true},
			{"speaker": "", "text": "(Steve puts the phone down. Pranayama Peak awaits. But The Sanctuary has taught him something: the person he finds might not be the person he lost.)", "thought": true},
			{"speaker": "", "text": "(END SANCTUARY ZONE)", "thought": true}
		],

		# ── Breathwork Monk ──
		"breathwork_monk": [
			{"speaker": "", "text": "(A serene man sits in the corner of the studio, breathing with theatrical intensity. Each exhale could extinguish birthday candles from across a room.)", "thought": true},
			{"speaker": "Breathwork Monk", "text": "(inhale for 8 seconds) ... (exhale for 12 seconds) ... You're here. Good. The universe sent you."},
			{"speaker": "Steve", "text": "I walked here. Through a door."},
			{"speaker": "Breathwork Monk", "text": "Same thing. Would you like to breathe with me?"},
			{"speaker": "Steve", "text": "I've been breathing my whole life without instruction."},
			{"speaker": "Breathwork Monk", "text": "Yes. And look how that turned out. Your wife left, you're at a retreat center, and your posture suggests chronic stress."},
			{"speaker": "", "text": "(That was... surprisingly accurate.)", "thought": true},
			{"speaker": "Breathwork Monk", "text": "One session. Free of charge. Just breathe with me for sixty seconds. What's the worst that could happen?"},
			{"speaker": "", "text": "(Steve breathes. For sixty seconds, nothing else exists. No wife. No retreat. No spreadsheets. Just air.)", "thought": true},
			{"speaker": "", "text": "(Steve's EP is fully restored.)", "thought": true, "callback": "breathwork_heal"},
			{"speaker": "Steve", "text": "...That was... fine. It was fine."},
			{"speaker": "Breathwork Monk", "text": "The highest compliment an accountant can give. Come back anytime."},
		],

		# ── Frank Quest: Pipe ──
		"frank_quest_pipe": [
			{"speaker": "Frank", "text": "The irrigation pipe in the garden burst three days ago. Nobody'll fix it."},
			{"speaker": "Frank", "text": "It's manual labor. Not spiritual. Not healing. Just actual work."},
			{"speaker": "Steve", "text": "I can fix it."},
			{"speaker": "Frank", "text": "No pipe wrench here. But I've got one in my shed. Take it. Bring it back when you're done."},
			{"speaker": "", "text": "(Frank hands Steve a wrench. It's heavy. It's real.)", "thought": true, "callback": "pipe_quest_active"}
		],

		# ── Frank Quest: Done ──
		"frank_quest_done": [
			{"speaker": "Frank", "text": "You fixed the pipe. Good work."},
			{"speaker": "Steve", "text": "It took forty minutes."},
			{"speaker": "Frank", "text": "First useful thing anyone's done here in twelve years."},
			{"speaker": "", "text": "(Frank hands Steve a master key.)", "thought": true},
			{"speaker": "Frank", "text": "This opens most of the old locks on the property. Might be useful."},
			{"speaker": "", "text": "", "callback": "has_master_key"}
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
	# Execute callback if present (e.g., for shop purchases)
	if choice.has("callback") and choice["callback"] != "":
		_handle_callback(choice["callback"])
	# Navigate to next dialogue tree if present
	if choice.has("next") and choice["next"] != "":
		start_dialogue(choice["next"])
	elif not choice.has("next") or choice["next"] == "":
		# No next tree — end dialogue
		_end_dialogue()

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
		# ── Flag callbacks ──
		"talked_receptionist":
			GameState.set_flag("talked_receptionist")
			GameState.insight += 1
		"talked_frank":
			GameState.set_flag("talked_frank")
			GameState.insight += 1
		"talked_maya":
			GameState.set_flag("talked_maya")
			GameState.insight += 1
		"talked_brandon":
			GameState.set_flag("talked_brandon")
		"firepit_done":
			GameState.set_flag("firepit_done")
			GameState.set_flag("night_mode")
			GameState.insight += 2
		"circle_done":
			GameState.set_flag("circle_done")
			GameState.set_flag("night_mode")
		"meditator_intel":
			GameState.set_flag("meditator_intel")
			GameState.insight += 1
		"gatekeeper_cleared":
			GameState.set_flag("gatekeeper_cleared")
		"found_documents":
			GameState.set_flag("found_documents")
		"pipe_quest_active":
			GameState.set_flag("pipe_quest_active")
		"has_master_key":
			GameState.set_flag("has_master_key")
			GameState.cacao += 0  # Already received as item
		# ── Battle callbacks ──
		"start_oil_battle":
			GameState.set_flag("start_oil_battle")
		"start_meditator_battle":
			GameState.set_flag("start_meditator_battle")
		"start_gatekeeper_battle":
			GameState.set_flag("start_gatekeeper_battle")
		"start_founder_battle":
			GameState.set_flag("start_founder_battle")
		# ── Stat callbacks ──
		"add_insight":
			GameState.insight += 1
		"breathwork_heal":
			GameState.ep = GameState.max_ep
		# ── Item callbacks ──
		"add_coffee":
			if GameState.cacao >= 80:
				GameState.cacao -= 80
				GameState.add_item({"id": "actual_coffee", "name": "Actual Coffee", "desc": "\"Real coffee. Not mushroom coffee. Not cacao-infused. Just coffee.\"", "type": "consumable", "heal": 30, "qty": 1})
		"add_cacao_drink":
			if GameState.cacao >= 50:
				GameState.cacao -= 50
				GameState.add_item({"id": "cacao_drink", "name": "Cacao Ceremony Drink", "desc": "\"The good kind. Someone actually roasted these beans.\"", "type": "consumable", "heal": 20, "qty": 1})
		"add_kombucha":
			if GameState.cacao >= 20:
				GameState.cacao -= 20
				GameState.add_item({"id": "kombucha", "name": "Kombucha", "desc": "\"Fermented. Carbonated. Slightly vinegar-ish.\"", "type": "consumable", "heal": 10, "qty": 1})
		"add_wifi_password":
			if GameState.cacao >= 100:
				GameState.cacao -= 100
				GameState.add_item({"id": "wifi_password", "name": "WiFi Password (Scrap of Paper)", "desc": "\"AdminNetwork / TrustTheProcess2024\"", "type": "quest", "qty": 1})
				GameState.set_flag("has_wifi")
		"add_wrench":
			GameState.add_item({"id": "wrench", "name": "Pipe Wrench", "desc": "\"Heavy. Metal. Real. The most trustworthy object since arriving.\"", "type": "quest", "qty": 1})
		"add_master_key":
			GameState.add_item({"id": "master_key", "name": "Master Key", "desc": "\"Opens most old locks. Frank knows every door.\"", "type": "quest", "qty": 1})
		"add_recommendation_letter":
			GameState.add_item({"id": "recommendation_letter", "name": "Wife's Recommendation Letter", "desc": "\"Addressed to Pranayama Peak. 'Advanced work.'\"", "type": "quest", "qty": 1})
		"add_maya_documents":
			GameState.add_item({"id": "maya_passport", "name": "Maya's Passport", "desc": "\"Seven months held 'for safekeeping.'\"", "type": "quest", "qty": 1})
		"add_retreat_map":
			GameState.add_item({"id": "retreat_map", "name": "Retreat Map", "desc": "\"A hand-drawn map of The Sanctuary.\"", "type": "quest", "qty": 1})
			GameState.set_flag("has_map")
