extends Node2D

@export var object: Area2D
@export var animation_name : String
var process_complete = false
var current_object_combine_type : Globals.CombineType
@onready var timer: Timer = $Timer
var scale_value = 1
var scale_direction = 1
var initial_scale = scale
var running = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	animated_sprite_2d.animation = animation_name

func _process(_delta: float) -> void:
	if running:
		animated_sprite_2d.frame = 1
		if scale_value >= 1.6:
			scale_direction = -1
		elif scale_value < 1:
			scale_direction = 1
		scale_value += 0.01 * scale_direction
		scale.x = scale_value
		scale.y = scale_value
	else:
		scale = initial_scale

func _on_area_entered(area: Area2D) -> void:
	area.object_dropped.connect(_add_to_process)
	area.set_placeable(true)
	current_object_combine_type = area.get_combine()

func _on_area_exited(area: Area2D) -> void:
	area.object_dropped.disconnect(_add_to_process)
	print("removed")


func _add_to_process(_type) -> void:
	if object != null:
		print("processing")
		object.current_animation_frame = 1
		object.change_animation(current_object_combine_type)
		timer.start()
		running = true

func get_type() -> Globals.ObjectType:
	return Globals.ObjectType.Processor

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if process_complete:
			object.spawn()
			animated_sprite_2d.frame = 0
			process_complete = false


func _on_timer_timeout() -> void:
	process_complete = true
	running = false
	timer.stop()
