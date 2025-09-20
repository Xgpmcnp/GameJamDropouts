extends Node2D
@onready var player: Node2D = %Player
@onready var dialog_ui: Control = %DialogUI
@onready var customer: Node2D = %Customer

var dialog_index: int = 0
var dialog_active := false
var current_customer_name: String
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_on_customer_enter()
	process_current_line()
	start_dialog()
	#dialog_ui.animation_done.connect(_on_animation_done)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if dialog_active:
		check_dialog_input()

func start_dialog():
	dialog_active = true
	dialog_ui.visible = true
	dialog_index = 0
	process_current_line()
		
func end_dialog():
	dialog_active = false
	dialog_ui.visible = false

func check_dialog_input():
	if Input.is_action_just_pressed("next_line"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if(dialog_index < len(DialogueSystem.dialog_lines) - 1):
				dialog_index += 1
				process_current_line()
			else:
				dialog_ui.visible = false
	
# After extract Name, Dialog for both the Player and Customer, the text will be displayed and can be process
# by either left mouse click, or hit Enter or Space
func process_current_line():
	var line = DialogueSystem.dialog_lines[dialog_index]
	var line_info: Dictionary = DialogueSystem.extract_line(line)
	var character_name = Character.get_enum_from_string(line_info["speaker_name"])
	dialog_ui.change_line(character_name, line_info["dialog"])
	customer.load_character(character_name)

func _on_animation_done():
	customer.hide_sprite()

func _on_customer_enter():
	#customer.display_sprite()
	current_customer_name = "CustomerA"
