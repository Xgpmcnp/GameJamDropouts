extends Node2D
@onready var player_sprite: AnimatedSprite2D = $%AvatarFrame
signal health_changed(new_value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass

func take_damage(amount):
	Global.health -= amount
	health_changed.emit(Global.health)
	_update_sprite()
	
func _update_sprite() -> void:
	match Global.health:
		_ when Global.health >= 75:
			print("Healthy")
			player_sprite.play("happy")
		_ when Global.health >= 50:
			print("Annoyed")
			player_sprite.play("annoyed")
		_ when Global.health >= 25:
			print("Stress")
			player_sprite.play("stress")
		_ when Global.health < 25:
			print("Depress")
			player_sprite.play("depress")
