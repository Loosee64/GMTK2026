extends Node2D
@onready var bottom: TextureRect = $Bottom
@onready var lettuce: TextureRect = $Lettuce
@onready var top: TextureRect = $Top
@onready var meat: TextureRect = $Meat
@onready var pickle: TextureRect = $Pickle
@onready var onion: TextureRect = $Onion
@onready var tomato: TextureRect = $Tomato

var current = {}

func _ready() -> void:
	Globals.next_order.connect(_new_burger)
	_new_burger()

func _new_burger():
	current.set("lettuce", 0)
	current.set("pickle",0)
	current.set("meat",0)
	current.set("onion",0)
	current.set("tomato",0)
	
	lettuce.visible = false
	meat.visible = false
	pickle.visible = false
	onion.visible = false
	tomato.visible = false

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
