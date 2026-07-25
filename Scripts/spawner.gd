extends StaticBody2D

@export var object: Area2D

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		object.set_process(true)
		object.spawn()
