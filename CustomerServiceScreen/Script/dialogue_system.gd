extends Node

var dialog_index: int = 0
# Stores the current customer name
var customer_name: String = "default"
# Stores the current dialog lines after formatting
var current_dialog: Array[String] = []
# Store the current state of serving
var drink_ready: bool = false

const conversation: Array = [
	[
		"{customer}: Where am I? This place feels strange...",
		"Hero: Welcome, traveler. You’ve entered the Forgotten Woods.",
		"{customer}: Who are you? Can I trust you?",
		"Hero: Trust is earned, not given. But I can show you the way."
	],
	[
		"{customer}: Hah! You think you can escape my domain?",
		"Hero: I’m not afraid of you!",
		"{customer}: Careful, hero… his power is greater than you imagine.",
		"Villain: Enough talk. Face me, if you dare!"
	],
	[
		"Hero: The path ahead is dangerous, {customer}.",
		"{customer}: Danger is nothing new to me.",
		"Hero: Then walk with courage.",
		"Narrator: And so their journey continued..."
	],
	[
		"{customer}: This village feels… empty.",
		"Hero: War has taken its toll.",
		"{customer}: We must bring hope back to these people.",
		"Hero: Then let’s begin with a single step."
	],
	[
		"{customer}: Do you believe we can win this battle?",
		"Hero: Hope is stronger than fear.",
		"{customer}: Then I’ll stand with you.",
		"Narrator: A fragile alliance was born that day."
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
	var temp_dialog: Array = pick_random_dialog(conversation)
	
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
	
