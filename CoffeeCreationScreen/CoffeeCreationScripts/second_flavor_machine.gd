extends Node2D

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var second_flavor_label: Label = $SecondFlavorLabel



var second_flavor_options = ["Spice", "Matcha", "Caramom"]
var curr_index = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# Move to previous flavor option, pass through if already on "Spice"
func _on_second_flavor_back_pressed() -> void:
	if curr_index == 0:
		pass
	else:
		curr_index -= 1
		second_flavor_label.text = second_flavor_options[curr_index]

# Move to next flavor option, pass through if already at last option
func _on_second_flavor_forward_pressed() -> void:
	if curr_index >= second_flavor_options.size() - 1:
		pass
	else:
		curr_index += 1
		second_flavor_label.text = second_flavor_options[curr_index]
	
# Triggers pouring animation and moves to next step
func _on_second_flavor_pour_pressed() -> void:
	if coffee_cup.fill_level == 1:
		coffee_cup.set_second_flavor(second_flavor_label.text)
