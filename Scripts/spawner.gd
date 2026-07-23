extends StaticBody2D

@export var object: Area2D

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		object.spawn()
