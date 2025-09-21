extends Control

@onready var coffee_cup: Sprite2D = $"../Path2D/PathFollow2D/CoffeeCup2"
@onready var extras_label: Label = $ExtrasLabel
@onready var preparation_method_selection: Control = $"../PreparationMethodSelection"
@onready var extras_back: TextureButton = $ExtrasBack
@onready var extras_forward: TextureButton = $ExtrasForward
@onready var extras_pour: TextureButton = $ExtrasPour

# If true, buttons cannot be pressed anymore
var lock_machine: bool

var extras_options = ["Spice", "Matcha", "Caramom"]
var curr_index = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Machine can't be interacted with by default
	lock_machine = true
	extras_back.hide()
	extras_forward.hide()
	extras_pour.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



# Move to previous flavor option, pass through if already on "Spice"
func _on_extras_back_pressed() -> void:
	$"Coffee-IngedientSwitch".play()
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
	$"Coffee-IngedientSwitch".play()
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
	$"Coffee-IngedientDispense".play()
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		# Lock this machine
		lock_machine = true
		
		# Unlock next machine
		preparation_method_selection.lock_machine = false
		preparation_method_selection.unhide_options()
		coffee_cup.set_extra(extras_label.text)
	$"../../Coffee-Conveyor".play()
	
func unhide_options()->void:
	extras_back.visible = true
	extras_forward.visible = true
	extras_pour.visible = true
