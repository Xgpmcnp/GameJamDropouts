extends Control
@onready var dialog_line: RichTextLabel = %DialogLine
@onready var speaker_name: RichTextLabel = %SpeakerName
signal animation_done

const ANIMATION_SPEED: int = 30
var animate_text : bool = false
var current_visible_character : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if animate_text:
		if dialog_line.visible_ratio < 1:
			dialog_line.visible_ratio += (1.0 / dialog_line.text.length()) * (ANIMATION_SPEED * delta)
			current_visible_character = dialog_line.visible_characters
		else:
			animate_text = false
			animation_done.emit()
			
func change_line(character_name: Character.Name, line: String):
	var speaker: String = "SaiGon"  # Default name

	if Character.CHARACTER_DETAILS.has(character_name):
		speaker = Character.CHARACTER_DETAILS[character_name]["name"]

	speaker_name.text = speaker
	
	dialog_line.text = line
	current_visible_character = 0
	dialog_line.visible_characters = 0
	animate_text = true


func skip_text_animation():
	dialog_line.visible_ratio = 1
