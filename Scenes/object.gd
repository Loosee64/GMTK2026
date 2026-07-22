extends Node2D

var dragging = false

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		dragging = true
	elif event.is_action_released("click"):
		dragging = false

func spawn() -> void:
	dragging = true
	position = get_global_mouse_position()
	print(position)
	visible = true
