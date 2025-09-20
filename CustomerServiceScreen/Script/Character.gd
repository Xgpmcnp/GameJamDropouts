class_name Character
extends Node

enum Name{
	CUSTOMERA,
	CUSTOMERB
}

const CHARACTER_DETAILS: Dictionary = {
	Name.CUSTOMERA:{
		"name": "CustomerA",
		"sprite_frames": preload("res://CustomerServiceScreen/texture/CustomerA.tres")
	},
		Name.CUSTOMERB:{
		"name": "CustomerA",
		"sprite_frames": preload("res://CustomerServiceScreen/texture/CustomerB.tres")
	},
	
}
static func get_enum_from_string(string_value: String) -> int:
	var upper_string = string_value.to_upper()
	if Name.has(upper_string):
		return Name[upper_string]
	else:
		push_error("Invalid Character Name: " + string_value)
		return -1
