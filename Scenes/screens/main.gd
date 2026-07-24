extends Node2D

@onready var kitchen: Node2D = $Kitchen
@onready var back_room: Node2D = $BackRoom

signal mistake(strength)
signal calm_chef(strength)

func _on_switch_to_back_pressed() -> void:
	kitchen.visible = false
	back_room.visible = true


func _on_switch_to_kitchen_pressed() -> void:
	kitchen.visible = true
	back_room.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tempMad"):
		mistake.emit(10)
	if event.is_action_pressed("tempCalm"):
		calm_chef.emit(10)
