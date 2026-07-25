extends Area2D

var object

func _on_area_entered(area: Object) -> void:
	area.set_placeable(true)
	object = area


func _on_area_exited(area: Object) -> void:
	area.set_placeable(false)

func get_type() -> Globals.ObjectType:
	return Globals.ObjectType.Space

func get_object() -> Object:
	return object
