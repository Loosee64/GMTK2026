extends Node2D

var current_order = {}
var current_plate = {}
@onready var placeable_space: Area2D = $PlaceableSpace

func _ready() -> void:
	random_order()

func random_order() -> void:
	current_order.set("lettuce",1)
	current_order.set("pickle",1)
	current_order.set("meat",1)

func check_order() -> bool:
	if current_plate == current_order:
		return true
	return false

func process_order() -> void:
	if check_order():
		print("yes")
	else:
		print("no")


func _on_placeable_space_area_entered(area: Area2D) -> void:
	if area.is_in_group("Burger"):
		current_plate = area.get_child(1).get_current()
		print(current_plate)


func _on_placeable_space_area_exited(area: Area2D) -> void:
	if area.is_in_group("Burger"):
		current_plate = {}
		print(current_plate)
