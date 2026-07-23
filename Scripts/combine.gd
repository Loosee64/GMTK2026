extends Node2D
@onready var bottom: TextureRect = $Bottom
@onready var lettuce: TextureRect = $Lettuce
@onready var top: TextureRect = $Top


func _on_object_object_dropped(type: Variant) -> void:
	match type:
		Globals.CombineType.LETTUCE:
			lettuce.visible = true
