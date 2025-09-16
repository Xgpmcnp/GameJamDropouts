extends Sprite2D

var curr_first_flavor = ""
var curr_second_flavor = ""
var curr_coffee_type = ""
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_first_flavor(flavor: String) -> void:
	curr_first_flavor = flavor
	
func set_second_flavor(flavor: String) -> void:
	curr_second_flavor = flavor

func set_coffee_type(coffee_type: String) -> void:
	curr_coffee_type = coffee_type
	print(curr_first_flavor + " " + curr_second_flavor + " " + curr_coffee_type)
