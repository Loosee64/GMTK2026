extends Node2D
@onready var bottom: TextureRect = $Bottom
@onready var lettuce: TextureRect = $Lettuce
@onready var top: TextureRect = $Top
@onready var meat: TextureRect = $Meat
@onready var pickle: TextureRect = $Pickle
@onready var onion: TextureRect = $Onion
@onready var tomato: TextureRect = $Tomato

var current = {}

func _on_object_object_dropped(type: Globals.CombineType, prepared) -> void:
	if prepared:
		match type:
			Globals.CombineType.LETTUCE:
				lettuce.visible = true
				current.set("lettuce",1)
			Globals.CombineType.MEAT:
				meat.visible = true
				current.set("meat",1)
			Globals.CombineType.PICKLE:
				pickle.visible = true
				current.set("pickle",1)
			Globals.CombineType.ONION:
				onion.visible = true
				current.set("onion",1)
			Globals.CombineType.TOMATO:
				tomato.visible = true
				current.set("tomato",1)

func get_current():
	return current
