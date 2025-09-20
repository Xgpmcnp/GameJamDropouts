extends Control

#var current_score: int = 0
#var score_timer: float = 0.0
#var score_interval: float = 1.0  # increase every 1 second
@onready var sanity_bar: TextureProgressBar = $%SanityBar
@onready var money_value: Label = $%MoneyValueLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Node ready, _process will start running automatically")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		#score_timer += delta
		#if score_timer >= score_interval:
			#current_score += 1
			#score_timer -= score_interval
		#money_value.text = str(current_score) + "$"
		pass
		
func _on_menu_editing_pressed() -> void:
	print("You clicked the Menu Editing Button")

func _on_shop_pressed() -> void:
	print("You clicked the Shop Button")

func _on_drink_creation_pressed() -> void:
	Global.goto_coffee_creation()
	print("You clicked the Drink Creation Button")

func _on_skill_tree_pressed() -> void:
	print("You clicked the Skill Tree Button")
	
func _on_setting_pressed() -> void:
	print("You clicked the Setting Button")
	
func _on_player_health_changed(new_value: Variant) -> void:
	sanity_bar.value = new_value
	print("Sanity Bar value is: " + str(sanity_bar.value))
