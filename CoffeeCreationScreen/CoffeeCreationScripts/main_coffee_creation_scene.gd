extends Control

@onready var coffee_cup: Sprite2D = $Node2D/Path2D/PathFollow2D/CoffeeCup2
# Saigon sprites
@onready var saigon_happy: Sprite2D = $Node2D/Portrait/SaigonHappy
@onready var saigon_content: Sprite2D = $Node2D/Portrait/SaigonContent
@onready var saigon_annoyed: Sprite2D = $Node2D/Portrait/SaigonAnnoyed
@onready var saigon_stressed: Sprite2D = $Node2D/Portrait/SaigonStressed
@onready var saigon_depressed: Sprite2D = $Node2D/Portrait/SaigonDepressed
@onready var saigon_dead: Sprite2D = $Node2D/Portrait/SaigonDead

# Copied code from player
@onready var composure
signal health_changed(new_value)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.reset_selected_options()

	composure = Global.get_composure()
	saigon_content.visible = false
	saigon_annoyed.visible = false
	saigon_stressed.visible = false
	saigon_depressed.visible = false
	saigon_dead.visible = false
	_update_sprite()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Ensure coffee is done, then serve. Will transfer to
# next scene
func _on_serve_button_pressed() -> void:
	if coffee_cup.fill_level == 3:
		print("Coffee is served")
		Global.goto_customer_service_menu(false, true)
		
# Go back to main menu, reset the full cup
func _on_back_button_pressed() -> void:
	Global.goto_customer_service_menu(true, false)
	coffee_cup.reset_cup()

# Show options screen
func _on_options_pressed() -> void:
	Global.open_options()

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
			saigon_content.visible = true
			saigon_annoyed.visible = false
			saigon_stressed.visible = false
			saigon_depressed.visible = false
			saigon_dead.visible = false
		_ when composure <= 50 && composure >= 26:
			print("Annoyed")
			saigon_happy.visible = false
			saigon_content.visible = false
			saigon_annoyed.visible = true
			saigon_stressed.visible = false
			saigon_depressed.visible = false
			saigon_dead.visible = false
		_ when composure <= 25:
			print("Stress")
			saigon_happy.visible = false
			saigon_content.visible = false
			saigon_annoyed.visible = false
			saigon_stressed.visible = true
			saigon_depressed.visible = false
			saigon_dead.visible = false
		_ when composure == 0:
			print("Dead")
			saigon_happy.visible = false
			saigon_content.visible = false
			saigon_annoyed.visible = false
			saigon_stressed.visible = false
			saigon_depressed.visible = true
			saigon_dead.visible = false
