extends Node

# A variable to contain the current scene
var current_scene = null

# Arrays containing the player's flavor, extras, and preparation method options
# NOTE: current values are placeholders
var flavor_options = ["Pumpkin", "Vanilla", "Grape"]
var extras_options = ["Spice", "Mint", "Lemon"]
var preparation_method_options = ["Latte", "Soda", "Mocha"]

# Variables to represent the current index of the arrays(which option is currently chosen)
var curr_flavor_idx = 0
var curr_extras_idx = 0
var curr_preparation_method_idx = 0


# Variable to keep track of current funds
var current_funds = 0.0

# Constants for when a PSL is served(increment) vs anything else being served(decrement)
const fund_increment = 10.0
const fund_decrement = -30.0

# Variables for keeping track of "Composure"
var curr_composure = 100
var curr_psl_combo = 0 # How many PSLs have been made in a row.


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
#-------------------------------------------------------------------
#  FUNCTIONS FOR FLAVORS/EXTRAS/PREP METHODS BELOW
#-------------------------------------------------------------------

# Updating the currently selected flavor, use bool to determine if it
# should increase or decrease
func update_curr_flavor(incrementVar: bool) -> void:
	if incrementVar:
		curr_flavor_idx += 1
	else: 
		curr_flavor_idx -= 1
	
# Updating the currently selected extra, use bool to determine if it should
# increase or decrease
func update_curr_extra(incrementVar: bool) -> void:
	if incrementVar:
		curr_extras_idx += 1
	else: 
		curr_extras_idx -= 1

# Updating the currently selected prep method, use bool to determine if it 
# should increase or decrease
func update_curr_preparation_method(incrementVar: bool) -> void:
	if incrementVar:
		curr_preparation_method_idx += 1
	else: 
		curr_preparation_method_idx -= 1

# Get the currently selected flavor
func get_curr_flavor() -> String:
	return flavor_options[curr_flavor_idx]

# Get the currently selected extra
func get_curr_extra() -> String:
	return extras_options[curr_extras_idx]

# Get the currently selected preparation method
func get_curr_preparation_method() -> String:
	return preparation_method_options[curr_preparation_method_idx]

#-------------------------------------------------------------------
# FUNCTIONS FOR UPDATING FUNDS/COMPOSURE BELOW
#-------------------------------------------------------------------

# Updates funds and composure when player serves a drink
# returns a bool to indicate if its a PSL or not(for purposes of customer reaction_
func assess_drink()-> bool:
	# Check if the player is serving a PSL
	if (flavor_options[curr_flavor_idx] == "Pumpkin" and 
	extras_options[curr_extras_idx] == "Spice" and 
	preparation_method_options[curr_preparation_method_idx] == "Latte"):
		# Update funds
		current_funds += fund_increment
		
		# Update composure and combo
		curr_composure -= pow(2, curr_psl_combo)
		curr_psl_combo += 1
		
		return true
	else:
		# Update funds
		current_funds += fund_decrement
		
		# Combo breaks
		curr_composure += ((100-curr_composure)/2) + 1
		
		# Ensure we don't overcap composure value
		if curr_composure > 100:
			curr_composure = 100
			
		curr_psl_combo = 0
		
		return false
	# Print to terminal all values to ensure things are behaving right:
	print("Player now has " + str(current_funds) + " in funds and "
		+ str(curr_composure) + " composure and the psl combo is " + str(curr_psl_combo))
		
