extends Node2D

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var coffee_type_label: Label = $CoffeeTypeLabel
var coffee_type_options = ["Latte", "Mocha", "Americano"]
var curr_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Go back to previous coffee type, pass if the type is already "Latte"
func _on_coffee_type_back_pressed() -> void:
	if curr_index == 0:
		pass
	else:
		curr_index -= 1
		coffee_type_label.text = coffee_type_options[curr_index]

# Go to next coffee type, pass if already at the last flavor
func _on_coffee_type_forward_pressed() -> void:
	if curr_index == coffee_type_options.size() - 1:
		pass
	else:
		curr_index += 1
		coffee_type_label.text = coffee_type_options[curr_index]

func _on_coffee_type_pour_pressed() -> void:
	coffee_cup.set_coffee_type(coffee_type_label.text)
	
