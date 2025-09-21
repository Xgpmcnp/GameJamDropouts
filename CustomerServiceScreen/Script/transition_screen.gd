extends CanvasLayer
@onready var animation_player: AnimationPlayer = %AnimationPlayer

signal transitioned

func transition():
	animation_player.play("fake_to_black")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "fake_to_black":
		emit_signal("transitioned")
		animation_player.play("fake_to_normal")
