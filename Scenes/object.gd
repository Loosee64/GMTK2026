extends Node2D
@onready var texture_rect: TextureRect = $TextureRect

enum ObjectType {
	Tool,
	Interactable
}

@export var type = ObjectType.Interactable

var dragging = false
var execute_collision = false

func _process(delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		dragging = true
	elif event.is_action_released("click"):
		if dragging && type == ObjectType.Tool:
			visible = false
		dragging = false
		if execute_collision && type == ObjectType.Interactable:
			scale.x = 2

func spawn() -> void:
	dragging = true
	position = get_global_mouse_position()
	print(position)
	visible = true

func _on_area_entered(area: Area2D) -> void:
	execute_collision = true


func _on_area_exited(area: Area2D) -> void:
	execute_collision = false
