class_name Character
extends Node

enum Name{
	jose,
	john
}

const CHARACTER_DETAILS: Dictionary = {
	Name.jose:{
		"name": "jose",
		"sprite_frames": preload("res://CustomerServiceScreen/FioAssets/customer_sprite_frames.tres")
	},
		Name.john:{
		"name": "john",
		"sprite_frames": preload("res://CustomerServiceScreen/FioAssets/customer_sprite_frames.tres")
	},
	
}
static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid Character Name: " + string_value)
		return -1
