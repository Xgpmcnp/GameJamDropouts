extends Node2D

@onready var coffee_cup: Sprite2D = $"../CoffeeCup"
@onready var extras_label: Label = $ExtrasLabel
@onready var preparation_method_selection: Node2D = $"../PreparationMethodSelection"

# If true, buttons cannot be pressed anymore
var lock_machine: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Machine can't be interacted with by default
	lock_machine = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# Move to previous flavor option, pass through if already on "Spice"
func _on_extras_back_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_extras_idx == 0:
			pass
		else:
			Global.update_curr_extra(false)
			extras_label.text = Global.get_curr_extra()

# Move to next flavor option, pass through if already at last option
func _on_extras_forward_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_extras_idx >= Global.extras_options.size() - 1:
			pass
		else:
			Global.update_curr_extra(true)
			extras_label.text = Global.get_curr_extra()
	
# Triggers pouring animation and moves to next step
func _on_extras_pour_pressed() -> void:
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		# Lock this machine
		lock_machine = true
		
		# Unlock next machine
		preparation_method_selection.lock_machine = false
		coffee_cup.set_extra(extras_label.text)
	
