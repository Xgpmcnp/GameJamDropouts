extends Node2D
@onready var player: Node2D = %Player
@onready var dialog_ui: Control = %DialogUI

var dialog_index: int = 0

const dialog_lines: Array[String] = [
	"Hero: Where am I? This place feels strange...",
	"Guide: Welcome, traveler. You’ve entered the Forgotten Woods.",
	"Hero: Who are you? Can I trust you?",
	"Guide: Trust is earned, not given. But I can show you the way.",
	"Villain: Hah! You think you can escape my domain?",
	"Hero: I’m not afraid of you!",
	"Guide: Careful, hero… his power is greater than you imagine.",
	"Villain: Enough talk. Face me, if you dare!"
]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_current_line()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_line"):
		if(dialog_index < len(dialog_lines) - 1):
			dialog_index += 1
			process_current_line()
		
	
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

func process_current_line():
	var line = dialog_lines[dialog_index]
	var line_info: Dictionary = extract_line(line)
	dialog_ui.speaker_name.text = line_info["speaker_name"]
	dialog_ui.dialog_line.text = line_info["dialog"]
	
