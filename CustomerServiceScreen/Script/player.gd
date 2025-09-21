extends Node2D
<<<<<<< Updated upstream
@onready var player_sprite: AnimatedSprite2D = $%AvatarFrame
=======
@onready var saigon_happy: Sprite2D = $SaigonHappy
@onready var saigon_annoyed: Sprite2D = $SaigonAnnoyed
@onready var saigon_stressed: Sprite2D = $SaigonStressed
@onready var saigon_depressed: Sprite2D = $SaigonDepressed
>>>>>>> Stashed changes
var health: float = 100
signal health_changed(new_value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	saigon_happy.visible = true
	saigon_annoyed.visible = false
	saigon_stressed.visible = false
	saigon_depressed.visible = false

func _process(delta: float) -> void:
	pass

func take_damage(amount):
	health -= amount
	health_changed.emit(health)
	_update_sprite()
	
func _update_sprite() -> void:
	match health:
		_ when health >= 75:
			print("Healthy")
<<<<<<< Updated upstream
			player_sprite.play("happy")
		_ when health >= 50:
			print("Annoyed")
			player_sprite.play("annoyed")
		_ when health >= 25:
			print("Stress")
			player_sprite.play("stress")
=======
		_ when health >= 50:
			print("Annoyed")
			saigon_happy.visible = false
			saigon_annoyed.visible = true
		_ when health >= 25:
			print("Stress")
			saigon_annoyed.visible = false
			saigon_stressed.visible = true
>>>>>>> Stashed changes
		_ when health < 25:
			print("Depress")
			saigon_stressed.visible = false
			saigon_depressed.visible = true
