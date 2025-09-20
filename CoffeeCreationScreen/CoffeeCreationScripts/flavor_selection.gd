extends Control

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var flavor_label: Label = $FlavorLabel




var flavor_options = ["Pumpkin", "Vanilla", "Lavendar"]
var curr_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

# Move to the previous flavor option, pass through if already on "Pumpkin"
func _on_flavor_back_pressed() -> void:
	if curr_index == 0:
		pass
	else:
		curr_index -= 1
		flavor_label.text = flavor_options[curr_index]
		
# Move to next flavor option, pass through if already on last flavor.
func _on_flavor_forward_pressed() -> void:
	if curr_index >= flavor_options.size() - 1:
		pass
	else:
		curr_index += 1
		flavor_label.text = flavor_options[curr_index]
		
# Triggers pouring animation and moves to next step
func _on_flavor_pour_pressed() -> void:
	if coffee_cup.fill_level == 0:
		coffee_cup.set_flavor(flavor_label.text)
	
