extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var type = Globals.ObjectType.None
@export var combine_type = Globals.CombineType.NONE

var current_animation_frame = 0

var placeable = false
var last_position = position

signal object_dropped(type)

var dragging = false
var execute_collision = Globals.ObjectType.None
var collision_combine = Globals.CombineType.NONE

func _on_ready() -> void:
	change_animation(combine_type)

func _process(_delta: float) -> void:
	if dragging:
		position = get_global_mouse_position()
	else:
		last_position = position
	animated_sprite_2d.frame = current_animation_frame

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		dragging = true
	elif event.is_action_released("click"):
		if dragging:
			if type == Globals.ObjectType.Knife || type == Globals.ObjectType.Effect:
				visible = false
				position.x = -1000
			elif !placeable:
				position = last_position
		dragging = false
		if type == Globals.ObjectType.Interactable:
			if execute_collision == Globals.ObjectType.Knife:
				current_animation_frame = 1
				type = Globals.ObjectType.Effect
		else:
			if execute_collision == Globals.ObjectType.Effect || execute_collision == Globals.ObjectType.Processor:
				emit_signal("object_dropped", collision_combine)
				collision_combine = Globals.CombineType.NONE

func spawn() -> void:
	dragging = true
	position = get_global_mouse_position()
	visible = true

func get_type() -> Globals.ObjectType:
	return type
	
func get_combine() -> Globals.CombineType:
	return combine_type

func _on_area_entered(area: Area2D) -> void:
	execute_collision = area.get_type()
	if execute_collision <= Globals.ObjectType.Interactable && collision_combine == Globals.CombineType.NONE:
		collision_combine = area.get_combine()
		print(collision_combine)

func _on_area_exited(_area: Area2D) -> void:
	execute_collision = Globals.ObjectType.None

func change_animation(recieved_type : Globals.CombineType) -> void:
	match recieved_type:
		Globals.CombineType.LETTUCE:
			animated_sprite_2d.animation = "lettuce"
		Globals.CombineType.MEAT:
			animated_sprite_2d.animation = "meat"
		Globals.CombineType.PICKLE:
			animated_sprite_2d.animation = "pickle"
		Globals.CombineType.NONE:
			pass

func set_placeable(value : bool) -> void:
	placeable = value
