extends Node2D

var current_order = {}
var current_plate = {}
@onready var placeable_space: Area2D = $PlaceableSpace
@export var timer : Timer
@onready var chef: AnimatedSprite2D = $"../Chef"

var rng = RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()
	random_order()
	Globals.next_order.connect(random_order)

func random_order() -> void:
	current_order.set("lettuce", rng.randi_range(0,1))
	current_order.set("pickle",rng.randi_range(0,1))
	current_order.set("meat",1)
	current_order.set("onion",rng.randi_range(0,1))
	current_order.set("tomato",rng.randi_range(0,1))
	current_order.set("bun",1)
	current_order.set("fries",rng.randi_range(0,1))
	

func check_order() -> bool:
	if current_plate == current_order:
		return true
	return false

func process_order() -> void:
	if check_order():
		print("yes")
		Globals.next_order.emit()
		timer.start(timer.time_left + 10 - chef.get_aggression_factor())
	else:
		print("no")
		Globals.mistake.emit(10)

func get_current_order():
	return current_order

func _on_placeable_space_area_entered(area: Area2D) -> void:
	if area.is_in_group("Burger"):
		current_plate = area.get_child(0).get_current()
		print(current_plate)


func _on_placeable_space_area_exited(area: Area2D) -> void:
	if area.is_in_group("Burger"):
		current_plate = {}
		print(current_plate)
