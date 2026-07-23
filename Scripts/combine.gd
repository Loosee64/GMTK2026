extends Node2D
@onready var bottom: TextureRect = $Bottom
@onready var lettuce: TextureRect = $Lettuce
@onready var top: TextureRect = $Top
@onready var meat: TextureRect = $Meat


func _on_object_object_dropped(type: Globals.CombineType) -> void:
	match type:
		Globals.CombineType.LETTUCE:
			lettuce.visible = true
		Globals.CombineType.MEAT:
			meat.visible = true
