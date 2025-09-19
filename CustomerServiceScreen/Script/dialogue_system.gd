extends Node

const dialog_lines: Array[String] = [
	"CustomerA: Where am I? This place feels strange...",
	"Hero: Welcome, traveler. You’ve entered the Forgotten Woods.",
	"CustomerA: Who are you? Can I trust you?",
	"Hero: Trust is earned, not given. But I can show you the way.",
	"CustomerA: Hah! You think you can escape my domain?",
	"Hero: I’m not afraid of you!",
	"CustomerA: Careful, hero… his power is greater than you imagine.",
	"Villain: Enough talk. Face me, if you dare!"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

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
