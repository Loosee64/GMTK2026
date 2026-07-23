extends Node2D

@export var object: Area2D
var process_complete = false
var current_object_combine_type : Globals.CombineType

func _on_area_entered(area: Area2D) -> void:
	area.object_dropped.connect(_add_to_process)
	current_object_combine_type = area.get_combine()
	print("added")

func _on_area_exited(area: Area2D) -> void:
	area.object_dropped.disconnect(_add_to_process)
	print("removed")


func _add_to_process(_type) -> void:
	print("processing")
	object.current_animation_frame = 1
	object.change_animation(current_object_combine_type)
	process_complete = true
	

func get_type() -> Globals.ObjectType:
	return Globals.ObjectType.Processor

func _on_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("click"):
		if process_complete:
			object.spawn()
