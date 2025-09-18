extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options

func _ready():
	main_buttons.visible = true
	options.visible = false

func _on_Start_Shift_pressed():
	pass # Replace with function body.


func _on_Options_pressed():
	pass # Replace with function body.
	main_buttons.visible = false
	options.visible = true


func _on_Credits_pressed():
	pass # Replace with function body.


func _on_back_options_pressed() -> void:
	_ready()
