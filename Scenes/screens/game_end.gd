extends Node2D

func _on_main_menu_pressed() -> void:
	Globals.scene_transition.emit("true_end")
	visible = false
