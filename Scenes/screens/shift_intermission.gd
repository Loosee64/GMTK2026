extends Node2D
@onready var win_sting: AudioStreamPlayer = $WinSting

func on_enter():
	win_sting.play()

func _on_next_day_pressed() -> void:
	Globals.scene_transition.emit("play")
	win_sting.stop()
	visible = false


func _on_main_menu_pressed() -> void:
	Globals.scene_transition.emit("menu")
	win_sting.stop()
	visible = false
