extends Node2D
@onready var player: Node2D = %Player
@onready var dialog_ui: Control = %DialogUI
@onready var customer: Node2D = %Customer

var customer_active := false
var has_customer := false
var customer_timer := 0.0
var next_customer_time := 0.0
var current_customer_name: String

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_reset_customer_timer()
	customer.hide_sprite()
	dialog_ui.visible = false	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not has_customer:
		customer_timer += delta
		if customer_timer >= next_customer_time:
			_on_customer_enter()
			has_customer = true
			_reset_customer_timer()
				
	if customer_active:
		check_dialog_input()
		# Handle customer spawning

func start_dialog():
	customer_active = true
	dialog_ui.visible = true
	DialogueSystem.dialog_index = 0
	process_current_line()
		
func end_dialog():
	customer_active = false
	#dialog_ui.visible = false
	#has_customer = false
	dialog_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
func end_order():
	customer.hide_sprite()
	
func check_dialog_input():
	if Input.is_action_just_pressed("next_line"):
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()
		else:
			if(DialogueSystem.dialog_index < len(DialogueSystem.dialog_lines) - 1):
				DialogueSystem.dialog_index += 1
				process_current_line()
			else:
				end_dialog()
# After extract Name, Dialog for both the Player and Customer, the text will be displayed and can be process
# by either left mouse click, or hit Enter or Space
func process_current_line():
	var line = DialogueSystem.dialog_lines[DialogueSystem.dialog_index]
	var line_info: Dictionary = DialogueSystem.extract_line(line)
	var character_name = Character.get_enum_from_string(line_info["speaker_name"])
	dialog_ui.change_line(character_name, line_info["dialog"])
	customer.load_character(character_name)

func _on_customer_enter():
	customer.display_sprite()
	current_customer_name = "CustomerA"
	start_dialog()

func _reset_customer_timer() -> void:
	customer_timer = 0.0
	next_customer_time = randf_range(5.0, 10.0)  # random between 5–10 seconds
	print(next_customer_time)
	
