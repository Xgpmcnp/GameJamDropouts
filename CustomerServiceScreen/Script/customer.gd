extends Node2D
@onready var customer_sprites: AnimatedSprite2D = %CustomerSprites

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	customer_sprites.play("idle")
