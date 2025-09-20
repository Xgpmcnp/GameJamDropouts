extends Node2D
@onready var player: Node2D = %Player
@onready var dialog_ui: Control = %DialogUI
@onready var customer: Node2D = %Customer

# === State variables ===
var customer_active := false     # True if a customer is currently in dialog
var has_customer := false        # True if a customer is currently present in the scene
var customer_timer := 0.0        # Accumulates time until the next customer spawns
var next_customer_time := 0.0    # Randomized delay for the next customer spawn
var current_customer_name: String  # Stores the name of the current customer

# Called when the node enters the scene tree for the first time
func _ready() -> void:
	_reset_customer_timer()      # Initialize first customer spawn timer
	customer.hide_sprite()       # Hide the customer by default
	dialog_ui.visible = false    # Hide dialog UI at game start	
	
# Called every frame, with delta = elapsed time since last frame
func _process(delta: float) -> void:
	# Handle customer spawning logic if there are no customer present atm
	if not has_customer:
		customer_timer += delta   # Count up time
		if customer_timer >= next_customer_time:  # The condition for spawn new customer
			_on_customer_enter()  # Trigger customer enter
			has_customer = true   # Mark customer as present
			_reset_customer_timer()  # Reset timer for the next spawn
				
	# Handle dialog input if a customer is active
	if customer_active:
		check_dialog_input()

# === DIALOG MANAGEMENT ===

# Start dialog with the customer
func start_dialog():
	customer_active = true
	dialog_ui.visible = true
	DialogueSystem.dialog_index = 0  # Reset dialog index to the first line
	process_current_line()           # Show the first line
		
# End dialog with the customer
func end_dialog():
	customer_active = false
	#dialog_ui.visible = false       # (commented: hide dialog UI when ending)
	#has_customer = false            # (commented: reset customer presence flag)
	dialog_ui.mouse_filter = Control.MOUSE_FILTER_IGNORE  # Ignore mouse input once dialog ends
	
# End the order (customer leaves the scene)
func end_order():
	customer.hide_sprite()
	
# Handle player input for dialog progression
func check_dialog_input():
	if Input.is_action_just_pressed("next_line"):  # If player presses Enter, Space, or Click
		if dialog_ui.animate_text:
			dialog_ui.skip_text_animation()  # Skip ongoing text animation
		else:
			if(DialogueSystem.dialog_index < len(DialogueSystem.current_dialog) - 1):
				DialogueSystem.dialog_index += 1  # Move to next line
				process_current_line()
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
	customer.display_sprite()   # Show the customer
	# Pick a random enum key from CHARACTER_DETAILS
	var keys = Character.CHARACTER_DETAILS.keys()
	var random_key = keys[randi() % keys.size()]
	# Store the readable name (like "CustomerA")
	current_customer_name = Character.CHARACTER_DETAILS[random_key]["name"]
	DialogueSystem.get_current_customer_name(current_customer_name)
	start_dialog()              # Start dialog sequence

# Reset the customer spawn timer to a new random interval
func _reset_customer_timer() -> void:
	customer_timer = 0.0
	next_customer_time = randf_range(1.0, 3.0)  # Random delay 5–10 seconds
	print(next_customer_time)  # Debug: print chosen time
