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
	current_plate = get_tree().get_nodes_in_group("Burger").get(0).get_child(1).get_current()
	if current_plate == current_order:
		return true
	return false

func process_order() -> void:
	if check_order():
		print("yes")
	else:
		print("no")
