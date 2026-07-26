extends Button
@onready var the_line: Node2D = $"../TheLine"
@onready var ding: AudioStreamPlayer = $Ding


func _on_pressed() -> void:
	the_line.process_order()
	ding.play()
