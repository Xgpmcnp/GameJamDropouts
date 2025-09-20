extends Node2D

@onready var coffee_cup: Sprite2D = $CoffeeCup

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Ensure coffee is done, then serve. Will transfer to
# next scene
func _on_serve_button_pressed() -> void:
	if coffee_cup.fill_level == 3:
		print("Coffee is served")
		Global.goto_customer_service_menu(false)
		
# Go back to main menu, reset the full cup
func _on_back_button_pressed() -> void:
	Global.reset_selected_options()
	Global.goto_main_menu()
	coffee_cup.reset_cup()

# Show options screen
func _on_options_pressed() -> void:
	Global.open_options()
