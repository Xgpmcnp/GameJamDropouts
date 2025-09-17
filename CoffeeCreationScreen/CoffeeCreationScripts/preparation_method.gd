extends Node2D

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var method_label: Label = $MethodLabel

var preparation_method_options = ["Latte", "Mocha", "Americano"]
var curr_index = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Go back to previous coffee type, pass if the type is already "Latte"
func _on_method_back_pressed() -> void:
	if curr_index == 0:
		pass
	else:
		curr_index -= 1
		method_label.text = preparation_method_options[curr_index]

# Go to next coffee type, pass if already at the last flavor
func _on_method_forward_pressed() -> void:
	if curr_index == preparation_method_options.size() - 1:
		pass
	else:
		curr_index += 1
		method_label.text = preparation_method_options[curr_index]

func _on_method_pour_pressed() -> void:
	if coffee_cup.fill_level == 2:
		coffee_cup.set_preparation_method(method_label.text)
	
