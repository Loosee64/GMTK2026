extends Button
@onready var the_line: Node2D = $"../TheLine"


func _on_pressed() -> void:
	the_line.process_order()
