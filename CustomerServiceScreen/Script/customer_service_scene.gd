extends Node2D
@onready var player: Node2D = %Player
@onready var dialog_ui: Control = %DialogUI
@onready var customer: Node2D = %Customer
@onready var transition_screen: CanvasLayer = $TransitionScreen

# === State variables ===
var customer_active := false     # True if a customer is currently in dialog
var has_customer := false        # True if a customer is currently present in the scene
var customer_timer := 0.0        # Accumulates time until the next customer spawns
var next_customer_time := 0.0    # Randomized delay for the next customer spawn
var current_customer_name: String  # Stores the name of the current customer

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	if DialogueSystem.drink_ready:
		has_customer = true
		customer_active = true
		DialogueSystem.get_conversation_dialog()
		start_dialog()
	else:
		if DialogueSystem.current_has_customer :
			_reinitiate_customer_state()
		else:
			set_timer()

# Called every frame, with delta = elapsed time since last frame
func _process(delta: float) -> void:
	# Handle customer spawning logic if there are no customer present atm
	if not has_customer:
		customer_timer += delta   # Count up time
		if customer_timer >= next_customer_time:  # The condition for spawn new customer
			_on_customer_enter()  # Trigger customer enter
			has_customer = true   # Mark customer as present
			DialogueSystem.current_has_customer = true # Remember the state
				
	# Handle dialog input if a customer is active
	if customer_active:
		check_dialog_input()

# === DIALOG MANAGEMENT ===

# Waiting for the customer to spawn
func set_timer():
	_reset_customer_timer()      # Initialize first customer spawn timer
	customer.hide_sprite()       # Hide the customer by default
	dialog_ui.visible = false    # Hide dialog UI at game start	
	
# Start dialog with the customer
func start_dialog():
	customer_active = true
	dialog_ui.visible = true
	DialogueSystem.dialog_index = 0  # Reset dialog index to the first line
	process_current_line()           # Show the first line

# Resume dialog with the current customer
func resume_dialog():
	if DialogueSystem.current_dialog.is_empty():
		push_warning("No dialog to resume!")
		return
	var retrieve_line_info: Dictionary = DialogueSystem.get_current_dialog_speaker_and_dialog()
	var character_name = Character.get_enum_from_string(retrieve_line_info["speaker_name"])  # Get enum ID
	dialog_ui.resume_line(retrieve_line_info["speaker_name"], character_name, retrieve_line_info["dialog"])  # Update UI
	dialog_ui.visible = true
			
# End dialog with the customer
func end_dialog():
	if Global.curr_composure <= 0:
		dialog_ui.visible = false
		# Play transition
		transition_screen.transition()
		# Wait until it's finished
		await transition_screen.transitioned
		DialogueSystem.state_reset()
		Global.curr_composure = 51
		Global.current_funds = int(Global.current_funds / 2)
		Global.goto_screen("res://CustomerServiceScreen/Screen/customer_service_scene.tscn")
	else:
		customer_active = false
		#dialog_ui.visible = false       # (commented: hide dialog UI when ending)
		#has_customer = false            # (commented: reset customer presence flag)
		dialog_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ignore mouse input once dialog ends
	
# End the order (customer leaves the scene)
func end_order():
	if Global.curr_composure <= 0:
		customer.hide_sprite()
		DialogueSystem.state_reset()
		DialogueSystem.get_gameover_dialog()
		start_dialog()
	else:
		# Reset state for local variable
		has_customer = false
		customer_active = false
		
		#Hide the UI for customer sprite and dialog 
		customer.hide_sprite()
		dialog_ui.visible = false
		
		# Reset state for global varialbe
		DialogueSystem.drink_ready = false
		DialogueSystem.current_has_customer = false
		
		# Reset timer for the next spawn
		_reset_customer_timer()  

# Handle player input for dialog progression
func check_dialog_input():
	if Input.is_action_just_pressed("new_line"):  # If player presses Enter, Space, or Click
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()  # Skip ongoing text animation
		else:
			if(DialogueSystem.dialog_index < len(DialogueSystem.current_dialog) - 1):
				DialogueSystem.dialog_index += 1  # Move to next line
				process_current_line()
			else:
				if DialogueSystem.drink_ready:
					end_order()
				else:
					end_dialog()  # End dialog if no more lines

# Process the current dialog line (determine speaker, text, etc.)
func process_current_line():
	var line = DialogueSystem.current_dialog[DialogueSystem.dialog_index]
	var line_info: Dictionary = DialogueSystem.extract_line(line)  # Extract speaker + text
	var character_name = Character.get_enum_from_string(line_info["speaker_name"])  # Get enum ID
	dialog_ui.change_line(line_info["speaker_name"], character_name, line_info["dialog"])  # Update UI
	customer.load_character(character_name)  # Update customer appearance/animation

# === CUSTOMER HANDLING ===

# Called when a new customer arrives
func _on_customer_enter():
	# Pick a random enum key from CHARACTER_DETAILS
	var keys = Character.CHARACTER_DETAILS.keys()
	var random_key = keys[randi() % keys.size()]
	#Store the customer index
	DialogueSystem.get_current_customer_index(random_key)
	# Store the readable name (like "CustomerA")
	current_customer_name = Character.CHARACTER_DETAILS[random_key]["name"]
	print(current_customer_name)
	DialogueSystem.get_current_customer_name(current_customer_name)
	DialogueSystem.get_conversation_dialog()
	# Load their sprite/animation
	customer.load_character(random_key)
	customer.display_sprite()
	start_dialog()              # Start dialog sequence

# Reset the customer spawn timer to a new random interval
func _reset_customer_timer() -> void:
	customer_timer = 0.0
	next_customer_time = randf_range(3.0, 5.0)  # Random delay 5–10 seconds
	print(next_customer_time)  # Debug: print chosen time

func _reinitiate_customer_state() -> void:
	has_customer = true
	current_customer_name = DialogueSystem.customer_name
	customer.load_character(DialogueSystem.customer_index)
	customer.display_sprite()
	resume_dialog()
