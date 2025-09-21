extends Node
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

var curr_music = ""
var game_started = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_started:
		# Make a default music be happy
		var new_audio = "res://GeneralAssets/OST/Caramel Frhappy loop V3.mp3"
		var curr_composure = Global.get_composure()
		
		# checking thresholds
		if curr_composure >= 76:
			new_audio = "res://GeneralAssets/OST/Caramel Frhappy loop V3.mp3"
		elif curr_composure >= 51:
			new_audio = "res://GeneralAssets/OST/Americanokay loop V3.mp3"
		elif curr_composure >= 26:
			new_audio = "res://GeneralAssets/OST/Madcchiato loop V3.mp3"
		else:
			new_audio = "res://GeneralAssets/OST/Depresso loop V3.mp3"
		
		if curr_music != new_audio:
			curr_music = new_audio
			audio_stream_player.stream = load(curr_music)

			audio_stream_player.play()

	
	
