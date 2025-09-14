extends Control

var current_score: int = 0
var score_timer: float = 0.0
var score_interval: float = 1.0  # increase every 1 second
@onready var sanity_bar: TextureProgressBar = $StatusContainer/SanityBar
@onready var score_label: Label = $StatusContainer/HBoxContainer/ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("Node ready, _process will start running automatically")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_timer += delta
	if score_timer >= score_interval:
		current_score += 1
		score_timer -= score_interval
		sanity_bar.value -= 10
	score_label.text = str(current_score)

func _on_menu_editing_pressed() -> void:
	print("You clicked the Menu Editing Button")


func _on_shop_pressed() -> void:
	print("You clicked the Shop Button")


func _on_drink_creation_pressed() -> void:
	print("You clicked the Drink Creation Button")


func _on_skill_tree_pressed() -> void:
	print("You clicked the Skill Tree Button")
	
