extends Node2D

@onready var kitchen: Node2D = $Kitchen
@onready var back_room: Node2D = $BackRoom

func _on_switch_to_back_pressed() -> void:
	kitchen.visible = false
	back_room.visible = true


func _on_switch_to_kitchen_pressed() -> void:
	kitchen.visible = true
	back_room.visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tempMad"):
		Globals.mistake.emit(5)
	if event.is_action_pressed("tempCalm"):
		Globals.calm_chef.emit(5)
