extends Node2D

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var flavor_label: Label = $FlavorLabel
@onready var extras_selection: Node2D = $"../ExtrasSelection"

# If true, the player can no longer select the buttons on this scree
var lock_machine: bool



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Player can interact with forward/backward/pour buttons
	lock_machine = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

# Move to the previous flavor option, pass through if already on "Pumpkin"
func _on_flavor_back_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_flavor_idx == 0:
			pass
		else:
			Global.update_curr_flavor(false)
			flavor_label.text = Global.get_curr_flavor()
		
# Move to next flavor option, pass through if already on last flavor.
func _on_flavor_forward_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_flavor_idx >= Global.flavor_options.size() - 1:
			pass
		else:
			Global.update_curr_flavor(true)
			flavor_label.text = Global.get_curr_flavor()
		
# Triggers pouring animation and moves to next step
func _on_flavor_pour_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		coffee_cup.set_flavor(flavor_label.text)
		
		# Lock this machine
		lock_machine = true
		# Unlock the extras machine
		extras_selection.lock_machine = false
