extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
signal object_dropped(type)

enum ObjectType {
	None,
	Tool,
	Interactable
}

@export var type = ObjectType.None
@export var combine_type = Globals.CombineType.BOTTOM_BUN

var dragging = false
var execute_collision = ObjectType.None
var collision_combine = Globals.CombineType.BOTTOM_BUN

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
		if type == ObjectType.Interactable:
			if execute_collision == ObjectType.Tool:
				animated_sprite_2d.frame = 1
				type = ObjectType.Tool
		else:
			if execute_collision == ObjectType.Tool:
				emit_signal("object_dropped", collision_combine)

func spawn() -> void:
	dragging = true
	position = get_global_mouse_position()
	visible = true

func get_type() -> ObjectType:
	return type
	
func get_combine() -> Globals.CombineType:
	return combine_type

func _on_area_entered(area: Area2D) -> void:
	execute_collision = area.get_type()
	collision_combine = area.get_combine()


func _on_area_exited(area: Area2D) -> void:
	execute_collision = ObjectType.None
