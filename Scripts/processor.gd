extends Node2D

@export var object: Area2D
@export var animation_name : String
var process_complete = false
var current_object_combine_type : Globals.CombineType
@onready var timer: Timer = $Timer
var scale_value = 1
var scale_direction = 1
var initial_scale
var running = false
var connected = false
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var ding: AudioStreamPlayer = $Ding
@onready var sizzle: AudioStreamPlayer = $Sizzle
@onready var sizzle_2: AudioStreamPlayer = $Sizzle2

func _ready() -> void:
	animated_sprite_2d.animation = animation_name
	initial_scale = animated_sprite_2d.scale
	scale_value = initial_scale.x

func _process(_delta: float) -> void:
	if running:
		animated_sprite_2d.frame = 1
		if scale_value >= initial_scale.x + 0.05:
			scale_direction = -1
		elif scale_value < initial_scale.x:
			scale_direction = 1
		scale_value += 0.001 * scale_direction
		animated_sprite_2d.scale.x = scale_value
		animated_sprite_2d.scale.y = scale_value
	else:
		animated_sprite_2d.scale = initial_scale
		scale_value = initial_scale.x

func _on_area_entered(area: Area2D) -> void:
	if area.get_combine() == object.get_combine():
		connected = true
		area.object_dropped.connect(_add_to_process)
		area.set_placeable(true)
		current_object_combine_type = area.get_combine()

func _on_area_exited(area: Area2D) -> void:
	if connected:
		area.object_dropped.disconnect(_add_to_process)
		connected = false


func _add_to_process(_type, _prepared) -> void:
	if object != null:
		object.current_animation_frame = 1
		object.change_animation(current_object_combine_type)
		timer.start()
		running = true
		if object.get_combine() == Globals.CombineType.MEAT:
			sizzle.play()
		elif object.get_combine() == Globals.CombineType.FRIES:
			sizzle_2.play()

func get_type() -> Globals.ObjectType:
	return Globals.ObjectType.Processor

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if process_complete:
			object.set_process(true)
			object.spawn()
			object.prepared = true
			animated_sprite_2d.frame = 0
			process_complete = false


func _on_timer_timeout() -> void:
	process_complete = true
	running = false
	timer.stop()
	ding.play()
	if object.get_combine() == Globals.CombineType.MEAT:
			sizzle.stop()
	elif object.get_combine() == Globals.CombineType.FRIES:
			sizzle_2.stop()
