extends Node

enum CombineType{
	NONE,
	TOP_BUN,
	LETTUCE,
	MEAT,
	PICKLE,
	ONION,
	TOMATO,
}

enum ObjectType {
	None,
	Effect,
	Interactable,
	Knife,
	Processor,
	Space,
	Plate
}

signal mistake(strength)
signal calm_chef(strength)
signal enter_back_room
signal exit_back_room
signal next_order
signal reset_dialogue_timer
