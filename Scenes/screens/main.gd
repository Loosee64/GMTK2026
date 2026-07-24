extends Node2D

@onready var kitchen: Node2D = $Kitchen
@onready var back_room: Node2D = $BackRoom

func _on_switch_to_back_pressed() -> void:
	kitchen.visible = false
	back_room.visible = true


func _on_switch_to_kitchen_pressed() -> void:
	kitchen.visible = true
	back_room.visible = false
