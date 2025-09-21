extends Control

@onready var coffee_cup: Sprite2D = $"../Path2D/PathFollow2D/CoffeeCup2"
@onready var method_label: Label = $MethodLabel
@onready var method_pour: TextureButton = $MethodPour
@onready var method_back: TextureButton = $MethodBack
@onready var method_forward: TextureButton = $MethodForward

# If true, buttons can't be pressed
var lock_machine: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Machine can't be interacted with by default
	lock_machine = true
	method_back.hide()
	method_forward.hide()
	method_pour.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Go back to previous coffee type, pass if the type is already "Latte"
func _on_method_back_pressed() -> void:
	$"Coffee-IngedientSwitch".play()
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_preparation_method_idx == 0:
			pass
		else:
			Global.update_curr_preparation_method(false)
			method_label.text = Global.get_curr_preparation_method()

# Go to next coffee type, pass if already at the last flavor
func _on_method_forward_pressed() -> void:
	$"Coffee-IngedientSwitch".play()
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		if Global.curr_preparation_method_idx == Global.preparation_method_options.size() - 1:
			pass
		else:
			Global.update_curr_preparation_method(true)
			method_label.text = Global.get_curr_preparation_method()

func _on_method_pour_pressed() -> void:
	$"Coffee-Pour".play()
	# Only does anything if player has not selected an options
	if lock_machine == true:
		pass
	else:
		# Lock this machine
		lock_machine = true
		coffee_cup.set_preparation_method(method_label.text)
	$"../../Coffee-OnTable".play()
	
func unhide_options() -> void:
	method_back.visible = true
	method_forward.visible = true
	method_pour.visible = true
