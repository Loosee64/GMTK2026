extends Area2D

func _on_area_entered(area: Object) -> void:
	area.set_placeable(true)
	print("placeable")


func _on_area_exited(area: Object) -> void:
	area.set_placeable(false)

func get_type() -> Globals.ObjectType:
	return Globals.ObjectType.Space
