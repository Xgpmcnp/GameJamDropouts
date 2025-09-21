extends Node2D
@onready var saigon_happy: Sprite2D = $AvatarBG/SaigonHappy
@onready var saigon_annoyed: Sprite2D = $AvatarBG/SaigonAnnoyed
@onready var saigon_depressed: Sprite2D = $AvatarBG/SaigonDepressed
@onready var saigon_dead: Sprite2D = $AvatarBG/SaigonDead

@onready var composure
signal health_changed(new_value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	composure = Global.get_composure()
	saigon_annoyed.visible = false
	saigon_depressed.visible = false
	saigon_dead.visible = false
	_update_sprite()

func _process(delta: float) -> void:
	pass

func take_damage(amount):
	Global.health -= amount
	health_changed.emit(Global.health)
	_update_sprite()
	
func _update_sprite() -> void:
	composure = Global.get_composure()
	match composure:
		_ when composure <= 100 && composure >= 76:
			print("Happy")
			
		_ when composure <= 75 && composure >= 51:
			print("Content")
			saigon_happy.visible = false
			saigon_annoyed.visible = false
			saigon_depressed.visible = false
			saigon_dead.visible = false
		_ when composure <= 50 && composure >= 26:
			print("Annoyed")
			saigon_happy.visible = false
			saigon_annoyed.visible = true
			saigon_depressed.visible = false
			saigon_dead.visible = false
		_ when composure <= 25:
			print("Dead")
			saigon_happy.visible = false
			saigon_annoyed.visible = false
			saigon_depressed.visible = false
			saigon_dead.visible = true
