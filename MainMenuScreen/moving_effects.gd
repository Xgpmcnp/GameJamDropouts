extends Control

var mainMenu = 1;
var mmenuAssets =  ["cup","glass","blueSquare3","blueSquare4","blueSquare5","blueSquare6","blueSquare7","blueSquare8","blueSquare9","blueSquare10","blueSquare11","blueSquare12","blueSquare13","blueSquare14","blueSquare15","blueSquare16","blueSquare17","blueSquare18","blueSquare19","blueSquare20"]
func _process(delta: float) -> void:
	for i in mmenuAssets:
		get_node(i).position += Vector2(0.5,0.5)
		#print(get_node(i).position)
		if get_node(i).position.y >= 350:
			get_node(i).position -= Vector2(750, 750)
			print("We went through an IF!")
