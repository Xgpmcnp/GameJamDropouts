extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options
@onready var credits: Panel = $Credits

func _ready():
	main_buttons.visible = true
	options.visible = false
	credits.visible = false

func _on_Start_Shift_pressed():
	Global.goto_customer_service_menu(false, false)


func _on_Options_pressed():
	main_buttons.visible = false
	options.visible = true


func _on_Credits_pressed():
	main_buttons.visible = false
	credits.visible = true


func _on_back_options_pressed() -> void:
	_ready()
