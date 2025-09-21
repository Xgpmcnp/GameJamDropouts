extends Sprite2D

# Store the options currently stored in the cup
# based on what options the player chose when hitting pour
var curr_flavor = ""
var curr_extra = ""
var curr_preparation_method = ""

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

func reset_cup() -> void:
	curr_flavor = ""
	curr_extra = ""
	curr_preparation_method = ""
	fill_level = 0
	print(curr_flavor + " is empty " + curr_extra + " " + curr_preparation_method)
	
	
func set_flavor(flavor: String) -> void:
	curr_flavor = flavor
	fill_level = 1
	
func set_extra(extra: String) -> void:
	curr_extra = extra
	fill_level = 2

func set_preparation_method(preparation_method: String) -> void:
	curr_preparation_method = preparation_method
	fill_level = 3
	print("current fill level is " + str(fill_level))
	print(curr_flavor + " " + curr_extra + " " + curr_preparation_method)
