extends Node

var dialog_index: int = 0
# Stores the current customer name
var customer_name: String = "default"
# Stores the current dialog lines after formatting
var current_dialog: Array[String] = []
# Store the current state of serving
var drink_ready: bool = false

const conversation_at_state_76_100: Array = [
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"Customer: I'll have your finest pumpkin spice latte, please.",
		"Saigon: Of course, coming right up!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"Customer: Pumpkin Spice Latte.",
		"Saigon: ..Certainly, I'm on it!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"Customer: Oh, love the menu! I'll have something different today.. How about a pumpkin spice latte?",
		"Saigon: Of course!",
		"Saigon's thoughts: ...THAT'S DIFFERENT? Where are you the other days!"
	],
	[
		"Saigon: Welcome to Pour Some Love! What can we brew together today?",
		"Customer: I'll have the usual.",
		"Saigon: Certainly, pumpkin spice latte, on its way",
		"Saigon's thoughts: ..I have never met this man."
	]
]

const conversation_at_state_51_75: Array = [
	[
		"Saigon: Welcome to Pour Some Love! How can I help?",
		"Customer: I'll have your finest pumpkin spice latte, please.",
		"Saigon: Of course, right away."
	],
	[
		"Saigon: Welcome to Pour Some Love! What would you like to drink?",
		"Customer: Pumpkin Spice Latte.",
		"Saigon: ..Sure, it's on its way."
	],
	[
		"Saigon: Welcome to Pour Some Love! What can I get you?",
		"Customer: I'll have the usual.",
		"Saigon: Ah, yes, the usual. Of course."
	],
	[
		"Saigon: Welcome to Pour Some Love! What do you want?",
		"Customer: What do I want? What kind of question is that? Bit rude..",
		"Saigon: O-oh, sorry, slip of the tongue. What can we brew together today?",
		"Customer: That's better. How about a pumpkin spice latte?",
		"Saigon: ..Certainly.",
		"Saigon's thoughts: Why so rude?"
	]
]

const conversation_at_state_26_50: Array = [
	[
		"Saigon: Welcome, how can I help you..?",
		"Customer: Oh, I'll have a uh, pumpkin spice latte?",
		"Saigon: Sounds about right."
	],
	[
		"Saigon: Hello and welcome..",
		"Customer: I'll have a pumpkin spice latte.. but maybe you need it more than me?",
		"Saigon: No, I'm good, thank you. Yours is coming up."
	],
	[
		"Saigon: Hi, welcome to Pour Some Love.",
		"Customer: Do you serve pumpkin spice lattes here?",
		"Saigon: What do you think?",
		"Customer:..yes?",
		"Saigon: It's.. on the way.."
	],
	[
		"Saigon: Welcome to.. Pour Some Love.. What can we brew.. together today..",
		"Customer: You don't seem okay.",
		"Saigon: I assure you, I am doing.. awesome.",
		"Customer: Oh, okay! I'll have a pumpkin spice latte, please!",
		"Saigon's thoughts: I am not okay."
	]
]

const conversation_at_state_1_25: Array = [
	[
		"Saigon: Welcome..",
		"Customer: Uhh, are you okay?",
		"Saigon: Your order, please..",
		"Customer: Oh, uh, a pumpkin sp-",
		"Saigon: Pumpkin spice latte, coming right up.."
	],
	[
		"Saigon: ...",
		"Customer: Pumpkin.",
		"Saigon: ...",
		"Customer: Spice.",
		"Saigon: ...",
		"Customer: Latte.",
		"Saigon: ..."
	],
	[
		"Saigon: Here's another..",
		"Customer: Hello my good madam, I would be in your debt if you could serve me a simple pumpkin spice latte!",
		"Saigon: ..yes, of course."
	],
	[
		"Saigon: Welcome to Pumpkin Spice Latte..",
		"Customer: Hi, yes, can I have a Pour Some Love please?",
		"Saigon: PSL, coming right up"
	]
]


# Extract SpeakerName, Dialogue from the Customer and Player
func extract_line(line: String) -> Dictionary:
	var line_info := line.split(":", false, 2) # split into max 2 parts
	if line_info.size() < 2:
		push_error("Invalid line format, missing ':' → " + line)
		return {}
	
	#Extract the info and remove trailing space
	var speaker_name := line_info[0].strip_edges()
	var dialog := line_info[1].strip_edges()
	
	#Check for the value of speaker_name and dialog to make sure they are not empty
	if speaker_name == "" or dialog == "":
		push_error("Invalid line format, empty speaker or dialog → " + line)
		return {}
	
	return {
		"speaker_name": speaker_name,
		"dialog": dialog
	}
	
# Selects a random dialog set for a given customer, 
# replaces placeholders (like {customer}) with actual values, 
# and stores the result in `current_dialog`.
func get_current_customer_name(customer: String):
	customer_name = customer
	# Pick a random dialog set from the conversation pool
	var temp_dialog: Array = pick_random_dialog(conversation_at_state_76_100)
	
	# Convert to Array[String] explicitly
	var current_dialog: Array[String] = []
	for line in temp_dialog:
		if typeof(line) == TYPE_STRING:
			current_dialog.append(line)
	# Dictionary of variables to replace inside dialog lines
	var variables: Dictionary = {
		"customer": customer_name
	}
	format_dialog(current_dialog, variables)

# Formats a dialog set by replacing placeholders with variable values.
# Example: "{customer}" → "CustomerA"
func format_dialog(dialog: Array[String], variables: Dictionary) -> Array[String]:
	var result: Array[String] = []
	for line in dialog:
		result.append(line.format(variables)) # Replace placeholders
		current_dialog = result
	return result

# Picks a random set of dialog lines from a larger collection of dialog sets.
# If `dialog_sets` is empty, return an empty array.
func pick_random_dialog(dialog_sets: Array) -> Array:
	if dialog_sets.is_empty():
		return []
	
	# Get a random index and return that dialog set
	var random_index = randi() % dialog_sets.size()
	return dialog_sets[random_index]
	
