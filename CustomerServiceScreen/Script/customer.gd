extends Node2D
@onready var customer_sprites: AnimatedSprite2D = %CustomerSprites
signal finished

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func load_character(character_name: Character.Name):
	# Get enum from string
	# Check if valid enum and exists in CHARACTER_DETAILS
	if character_name != -1 and Character.CHARACTER_DETAILS.has(character_name):
		var details = Character.CHARACTER_DETAILS[character_name]
		customer_sprites.sprite_frames = details["sprite_frames"]
		customer_sprites.play("talking")
		#in case of Player talking
	elif customer_sprites.sprite_frames != null:
		customer_sprites.play("idle")
		
func hide_sprite():
	customer_sprites.visible = false

func display_sprite():
	customer_sprites.visible = true
