extends Sprite2D

# Store the options currently stored in the cup
# based on what options the player chose when hitting pour
var curr_first_flavor = ""
var curr_second_flavor = ""
var curr_coffee_type = ""

# Fill level = how he far the cup is down the line
# 0 = empty cup
# 1 = cup has the flavor added
# 2 = cup has extras added
# 3 = cup has preparation method selected
var fill_level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_first_flavor(flavor: String) -> void:
	curr_first_flavor = flavor
	fill_level = 1
	
func set_second_flavor(flavor: String) -> void:
	curr_second_flavor = flavor
	fill_level = 2

func set_coffee_type(coffee_type: String) -> void:
	curr_coffee_type = coffee_type
	fill_level = 3
	print(curr_first_flavor + " " + curr_second_flavor + " " + curr_coffee_type)
