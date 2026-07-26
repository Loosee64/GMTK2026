extends Node2D




func _on_play_pressed() -> void:
	Globals.scene_transition.emit("play")
	visible = false


func _on_quit_pressed() -> void:
	get_tree().root.propagate_notification(NOTIFICATION_WM_CLOSE_REQUEST)
	get_tree().quit()
