extends PathFollow2D

@onready var coffee_cup: Sprite2D = $CoffeeCup2


var speed = 0

func _process(delta: float) -> void:
	
	if coffee_cup.fill_level == 0: 
		progress_ratio = 0
	if coffee_cup.fill_level == 1: 
		progress_ratio = 0.3364
	if coffee_cup.fill_level == 2: 
		progress_ratio = 0.6728
	if coffee_cup.fill_level == 3: 
		progress_ratio = 0.991 
		
