extends Control

#var current_score: int = 0
#var score_timer: float = 0.0
#var score_interval: float = 1.0  # increase every 1 second
@onready var sanity_bar: TextureProgressBar = $%SanityBar
@onready var money_value: Label = $%MoneyValueLabel
@onready var sanity_label: RichTextLabel = $StatusContainer/SanityContainer/RichTextLabel
@onready var menu_expansion: Panel = $MenuExpansion
@onready var shop: Panel = $Shop
@onready var interact_button_container: VBoxContainer = $InteractButtonContainer
@onready var return_to_serve_customer: VBoxContainer = $ReturnToServeCustomer

@onready var flavor_1: Label = $Shop/Flavors/Flavor1
@onready var flavor_2: Label = $Shop/Flavors/Flavor2
@onready var flavor_3: Label = $Shop/Flavors/Flavor3

@onready var extra_1: Label = $Shop/Extras/Extra1
@onready var extra_2: Label = $Shop/Extras/Extra2
@onready var extra_3: Label = $Shop/Extras/Extra3

@onready var preparation_1: Label = $Shop/Preparation/Preparation1
@onready var preparation_2: Label = $Shop/Preparation/Preparation2
@onready var preparation_3: Label = $Shop/Preparation/Preparation3

@onready var flavors: OptionButton = $MenuExpansion/ShopDropDown/Flavors
@onready var extra: OptionButton = $MenuExpansion/ShopDropDown/Extra
@onready var preparation: OptionButton = $MenuExpansion/ShopDropDown/Preparation

@onready var menu_item_list: Label = $MenuExpansion/Menu/VBoxContainer/Label
@onready var menu_price_list: Label = $MenuExpansion/Menu/VBoxContainer/Label/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Node ready, _process will start running automatically")
	interact_button_container.visible = true
	menu_expansion.visible = false
	shop.visible = false
	return_to_serve_customer.visible = false
	set_flavor_shop_options()
	set_extras_shop_options()
	set_preparation_method_shop_options()
	
	set_flavors_dropdown()
	set_extras_dropdown()
	set_preparation_dropdown()
	
	initialize_main_menu()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		#score_timer += delta
		#if score_timer >= score_interval:
			#current_score += 1
			#score_timer -= score_interval
		#money_value.text = str(current_score) + "$"
		money_value.text = str(Global.get_funds())
		_on_player_health_changed()

func set_flavor_shop_options()-> void:
	var options = Global.flavor_shop_options
	var options_size = options.size()
	
	if options_size > 0:
		flavor_1.text = options[0]
		
		if options_size > 1:
			flavor_2.text = options[1]
			
			if options_size > 2:
				flavor_3.text = options[2]

func set_extras_shop_options()-> void:
	var options = Global.extras_shop_options
	var options_size = options.size()
	
	if options_size > 0:
		extra_1.text = options[0]
		
		if options_size > 1:
			extra_2.text = options[1]
			
			if options_size > 2:
				extra_3.text = options[2]

func set_preparation_method_shop_options()-> void:
	var options = Global.prepartion_method_shop_options
	var options_size = options.size()
	
	if options_size > 0:
		preparation_1.text = options[0]
		
		if options_size > 1:
			preparation_2.text = options[1]
			
			if options_size > 2:
				preparation_3.text = options[2]


func set_flavors_dropdown()-> void:
	var i = 0
	for flavor_option in Global.flavor_options:
		flavors.add_item(flavor_option, i)
		i += 1
		
func set_extras_dropdown()-> void:
	var i = 0
	for extra_option in Global.extras_options:
		extra.add_item(extra_option, i)
		i += 1
		
func set_preparation_dropdown() -> void:
	var i = 0
	for method_option in Global.preparation_method_options:
		preparation.add_item(method_option, i)
		i += 1

func initialize_main_menu()-> void:
	for item in Global.new_items_from_player:
		menu_item_list.text = menu_item_list.text + "\n" + item
		menu_price_list.text = menu_price_list.text + "n" + "$10"

func _on_menu_editing_pressed() -> void:
	$"ExMenu-Open".play()
	print("You clicked the Menu Editing Button")
	interact_button_container.visible = false
	menu_expansion.visible = true
	return_to_serve_customer.visible = true

func _on_shop_pressed() -> void:
	$"Shop-OpenDoor".play()
	interact_button_container.visible = false
	shop.visible = true
	return_to_serve_customer.visible = true

func _on_drink_creation_pressed() -> void:
	Global.goto_coffee_creation()
	print("You clicked the Drink Creation Button")

func _on_skill_tree_pressed() -> void:
	print("You clicked the Skill Tree Button")
	
func _on_setting_pressed() -> void:
	$"MainMenu-Select".play()
	print("You clicked the Setting Button")
	
func _on_player_health_changed() -> void:
	var curr_composure = Global.get_composure()
	sanity_label.text = "Composure " + str(curr_composure)
	sanity_bar.value = curr_composure


func _on_return_pressed() -> void:
	if menu_expansion.visible:
		$"ExMenu-Close".play()
		interact_button_container.visible = true
		menu_expansion.visible = false
		return_to_serve_customer.visible = false
	if shop.visible:
		$"Shop-CloseDoor".play()
		interact_button_container.visible = true
		shop.visible = false
		return_to_serve_customer.visible = false

func _on_to_pressed() -> void:
	if menu_expansion.visible:
		$"ExMenu-Close".play()
		interact_button_container.visible = true
		menu_expansion.visible = false
		return_to_serve_customer.visible = false
	if shop.visible:
		$"Shop-CloseDoor".play()
		interact_button_container.visible = true
		shop.visible = false
		return_to_serve_customer.visible = false
		
func _on_serve_pressed() -> void:
	if menu_expansion.visible:
		$"ExMenu-Close".play()
		interact_button_container.visible = true
		menu_expansion.visible = false
		return_to_serve_customer.visible = false
	if shop.visible:
		$"Shop-CloseDoor".play()
		interact_button_container.visible = true
		shop.visible = false
		return_to_serve_customer.visible = false
		
func _on_customer_pressed() -> void:
	if menu_expansion.visible:
		$"ExMenu-Close".play()
		interact_button_container.visible = true
		menu_expansion.visible = false
		return_to_serve_customer.visible = false
	if shop.visible:
		$"Shop-CloseDoor".play()
		interact_button_container.visible = true
		shop.visible = false
		return_to_serve_customer.visible = false


func _on_buy_flavor_1_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (flavor_1.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update flavors list
		Global.update_flavors(flavor_1.text)
		
		# update flavors dropdown
		flavors.add_item(flavor_1.text, flavors.item_count)
		
		# Update options list
		flavor_1.text = flavor_2.text
		flavor_2.text = flavor_3.text
		if(Global.flavor_shop_options.size() > 2):
			flavor_3.text = Global.flavor_shop_options[2]
		else:
			flavor_3.text = "OUT OF STOCK"
		
		


func _on_buy_flavor_2_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (flavor_2.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update flavors list
		Global.update_flavors(flavor_2.text)
		
		# Update flavors dropdown
		flavors.add_item(flavor_2.text, flavors.item_count)
		
		# Update options list
		flavor_2.text = flavor_3.text
		if(Global.flavor_shop_options.size() > 2):
			flavor_3.text = Global.flavor_shop_options[2]
		else:
			flavor_3.text = "OUT OF STOCK"
		
		
	

func _on_buy_flavor_3_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (flavor_3.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update flavors list
		Global.update_flavors(flavor_3.text)
		
		# Update flavors dropdown
		flavors.add_item(flavor_3.text, flavors.item_count)
		
		# Update options list
		if(Global.flavor_shop_options.size() > 2):
			flavor_3.text = Global.flavor_shop_options[2]
		else:
			flavor_3.text = "OUT OF STOCK"
		
		


func _on_buy_extra_1_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (extra_1.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_extras(extra_1.text)
		
		# Update extras dropdown
		extra.add_item(extra_1.text, extra.item_count)
		
		# Update options list
		extra_1.text = extra_2.text
		extra_2.text = extra_3.text
		if(Global.extras_shop_options.size() > 2):
			extra_3.text = Global.extras_shop_options[2]
		else:
			extra_3.text = "OUT OF STOCK"


func _on_buy_extra_2_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (extra_2.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_extras(extra_2.text)
		
		# Update extras dropdown
		extra.add_item(extra_2.text, extra.item_count)
		
		# Update options list
		extra_2.text = extra_3.text
		if(Global.extras_shop_options.size() > 2):
			extra_3.text = Global.extras_shop_options[2]
		else:
			extra_3.text = "OUT OF STOCK"
		
		


func _on_buy_extra_3_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (extra_3.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_extras(extra_3.text)
		
		# Update extras dropdown
		extra.add_item(extra_3.text, extra.item_count)
		
		# Update options list
		if(Global.extras_shop_options.size() > 2):
			extra_3.text = Global.extras_shop_options[2]
		else:
			extra_3.text = "OUT OF STOCK"


func _on_buy_preparation_1_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (preparation_1.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_preparation_methods(preparation_1.text)
		
		# Update preparation dropdown
		preparation.add_item(preparation_1.text, preparation.item_count)
		
		# Update options list
		preparation_1.text = preparation_2.text
		preparation_2.text = preparation_3.text
		if(Global.prepartion_method_shop_options.size() > 2):
			preparation_3.text = Global.prepartion_method_shop_options[2]
		else:
			preparation_3.text = "OUT OF STOCK"
		


func _on_buy_preparation_2_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (preparation_2.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_preparation_methods(preparation_2.text)
		
		# Update preparation dropdown
		preparation.add_item(preparation_2.text, preparation.item_count)
		
		# Update options list
		preparation_2.text = preparation_3.text
		if(Global.prepartion_method_shop_options.size() > 2):
			preparation_3.text = Global.prepartion_method_shop_options[2]
		else:
			preparation_3.text = "OUT OF STOCK"
	
		


func _on_buy_preparation_3_pressed() -> void:
	# Check if player has funds to buy
	if(Global.get_funds() >= 20.0) and (preparation_3.text != "OUT OF STOCK"):
		$"Shop-Purchase".play()
		# Update funds and composure
		Global.update_funds(-20)
		Global.update_composure_on_item_buy()
		
		# Update extras list
		Global.update_preparation_methods(preparation_1.text)
		
		# Update preparation dropdown
		preparation.add_item(preparation_3.text, preparation.item_count)
		
		# Update options list
		if(Global.prepartion_method_shop_options.size() > 2):
			preparation_3.text = Global.prepartion_method_shop_options[2]
		else:
			preparation_3.text = "OUT OF STOCK"
		
	

func _on_add_to_menu_pressed() -> void:

	if !(flavors.get_selected_id() <= 0 and extra.get_selected_id() <= 0 and preparation.get_selected_id() <= 0):
		var new_item = flavors.get_item_text(flavors.selected) + " " + extra.get_item_text(extra.selected) + " " + preparation.get_item_text(preparation.selected)
		$"ExMenu-ConfirmIngredient".play()
		if !(Global.new_items_from_player.has(new_item)):
			Global.new_items_from_player.append(new_item)
			menu_item_list.text = menu_item_list.text + "\n" + new_item
			menu_price_list.text = menu_price_list.text + "\n" + "$10"
	
