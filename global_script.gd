extends Control

# A variable to contain the current scene
var current_scene = null

# Arrays containing the player's flavor, extras, and preparation method options
# NOTE: current values are placeholders
var flavor_options = ["Pumpkin"]
var extras_options = ["Spice"]
var preparation_method_options = ["Latte"]

var flavor_shop_options = []
var extras_shop_options = []
var prepartion_method_shop_options = []




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
	var root = get_tree().get_root()
	
	current_scene = root.get_child(-1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
# Function to full reset everything selected on coffee creation
func reset_selected_options() -> void:
	curr_flavor_idx = 0
	curr_extras_idx = 0
	curr_preparation_method_idx = 0
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
	print("Player currently has " + str(current_funds) + " in funds and " + str(curr_composure) + " composure and the psl combo is " + str(curr_psl_combo))
	# Check if the player is serving a PSL
	if (flavor_options[curr_flavor_idx] == "Pumpkin" and 
	extras_options[curr_extras_idx] == "Spice" and 
	preparation_method_options[curr_preparation_method_idx] == "Latte"):
		# Update funds
		current_funds += fund_increment
		
		# Update composure and combo
		curr_composure -= pow(2, curr_psl_combo)
		curr_psl_combo += 1
		
		# Print to terminal all values to ensure things are behaving right:
		print("Player now has " + str(current_funds) + " in funds and "
		+ str(curr_composure) + " composure and the psl combo is " + str(curr_psl_combo))
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
		
		# Print to terminal all values to ensure things are behaving right:
		print("Player now has " + str(current_funds) + " in funds and "
		+ str(curr_composure) + " composure and the psl combo is " + str(curr_psl_combo))
		return false

#-------------------------------------------------------------------
#  FUNCTIONS FOR SCENE TRANSITIONS BELOW
#-------------------------------------------------------------------

# The function used for screen loading
func goto_screen(path):
	deferred_goto_scene.call_deferred(path)
	
func deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()
	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
	
# Open options modal
func open_options():
	print("options opened")
	
# Open the credits modal
func open_credits():
	print("credits opened")

# Go to main menu
func goto_main_menu():
	print("Going to main menu")

# Go to customer service menu, isGoingBack determines if we need to clear current choices
# or not
func goto_customer_service_menu(isGoingBack: bool, isAssessing: bool):
	if isGoingBack:
		self.reset_selected_options()
	if isAssessing:
		self.assess_drink()
	
	self.goto_screen("res://CustomerServiceScreen/Screen/customer_service_scene.tscn")

# Go to coffee creation menu
func goto_coffee_creation():
	self.goto_screen("res://CoffeeCreationScreen/CoffeCreationScenes/main_coffee_creation_scene.tscn")

# Open Shop
func open_shop():
	print("Open shop")

func open_main_menu_creation():
	print("open main menu creation")

#-------------------------------------------------------------------
#  FUNCTIONS FOR UPDATING VARIABLES/getting their values
#-------------------------------------------------------------------

func get_funds()->float:
	return current_funds

func get_composure()->float:
	return curr_composure

func update_composure_on_item_buy():
	curr_composure += ((100-curr_composure)/2) + 1
		
	# Ensure we don't overcap composure value
	if curr_composure > 100:
		curr_composure = 100

func update_funds(amount: float):
	current_funds += amount
	
#-------------------------------------------------------------------
#  SHOP-SPECIFIC ITEMS BELOW
#-------------------------------------------------------------------
func fill_shop_flavor_slot()->String:
	var option = flavor_shop_options[0]
	flavor_shop_options.remove_at(0)
	return option

func fill_shop_extras_slot()->String:
	var option = extras_shop_options[0]
	extras_shop_options.remove_at(0)
	return option

func fill_shop_method_slot()->String:
	var option = preparation_method_options[0]
	preparation_method_options.remove_at(0)
	return option

func update_current_flavor_options(option:String):
	flavor_options.append(option)

func update_current_extras_options(option:String):
	extras_options.append(option)

func update_current_preparation_method_options(option:String):
	preparation_method_options.append(option)

#-------------------------------------------------------------------
#  FUNCTIONS FOR CONTROLLING AUDIO BELOW
#-------------------------------------------------------------------

func adjust_game_volume(newVolume: float)->void:
	# Idk if this will be easy so its gonna be more of a background thing
	pass

func change_current_track()->void:
	if curr_composure >= 75:
		pass
	elif curr_composure >= 50:
		pass
	elif curr_composure >= 25:
		pass
	else:
		pass
