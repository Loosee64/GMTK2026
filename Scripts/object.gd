extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var type = Globals.ObjectType.None
@export var combine_type = Globals.CombineType.NONE
@export var prepared = false

var starting_type

var current_animation_frame = 0

var placeable = false
var last_position = position

signal object_dropped(type, prepared)

var dragging = false
var execute_collision = Globals.ObjectType.None
var execute_combine : Globals.CombineType
var execute_prepared : bool

func _on_ready() -> void:
	change_animation(combine_type)
	starting_type = type

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
				set_process(false)
				position.x = -1000
				current_animation_frame = 0
				if type != Globals.ObjectType.Knife && execute_collision != Globals.ObjectType.Plate:
					type = starting_type
					Globals.mistake.emit(5)
			elif !placeable:
				position = last_position
		dragging = false
		if type == Globals.ObjectType.Interactable:
			if execute_collision == Globals.ObjectType.Knife:
				current_animation_frame = 1
				type = Globals.ObjectType.Effect
				prepared = true
		else:
			if (execute_collision == Globals.ObjectType.Effect || execute_collision == Globals.ObjectType.Processor):
				emit_signal("object_dropped", execute_combine, execute_prepared)

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
	if execute_collision == Globals.ObjectType.None:
		print(execute_collision)
	if (execute_collision == Globals.ObjectType.Interactable || execute_collision == Globals.ObjectType.Effect):
		execute_combine = area.get_combine()
		execute_prepared = area.prepared

func _on_area_exited(_area: Area2D) -> void:
	print(execute_collision)
	execute_collision = Globals.ObjectType.None

func change_animation(recieved_type : Globals.CombineType) -> void:
	match recieved_type:
		Globals.CombineType.LETTUCE:
			animated_sprite_2d.animation = "lettuce"
		Globals.CombineType.MEAT:
			animated_sprite_2d.animation = "meat"
		Globals.CombineType.PICKLE:
			animated_sprite_2d.animation = "pickle"
		Globals.CombineType.ONION:
			animated_sprite_2d.animation = "onion"
		Globals.CombineType.TOMATO:
			animated_sprite_2d.animation = "tomato"
		Globals.CombineType.NONE:
			pass

func set_placeable(value : bool) -> void:
	placeable = value
