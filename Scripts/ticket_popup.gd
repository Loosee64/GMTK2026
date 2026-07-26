extends Control

var current_order = {}
var line_ref

@onready var lettuce: TextureRect = $Panel/TextureRect/Node/Lettuce
@onready var meat: TextureRect = $Panel/TextureRect/Node/Meat
@onready var tomato: TextureRect = $Panel/TextureRect/Node/Tomato
@onready var onion: TextureRect = $Panel/TextureRect/Node/Onion
@onready var pickle: TextureRect = $Panel/TextureRect/Node/Pickle
@onready var fries: TextureRect = $Panel/TextureRect/Node/Fries

func _ready() -> void:
	var all_children = get_parent().get_children()
	for child in all_children:
		if child.is_in_group("The_Line"):
			line_ref = child
			break

func _on_texture_button_pressed() -> void:
	visible = false

func popup():
	if line_ref != null:
		current_order = line_ref.get_current_order()
	
	if current_order != {}:
		if current_order.get("lettuce") == 1:
			lettuce.visible = true
		else:
			lettuce.visible = false
		
		if current_order.get("meat") == 1:
			meat.visible = true
		else:
			meat.visible = false
		
		if current_order.get("tomato") == 1:
			tomato.visible = true
		else:
			tomato.visible = false
		
		if current_order.get("onion") == 1:
			onion.visible = true
		else:
			onion.visible = false
		
		if current_order.get("pickle") == 1:
			pickle.visible = true
		else:
			pickle.visible = false
		
		if current_order.get("fries") == 1:
			fries.visible = true
		else:
			fries.visible = false
