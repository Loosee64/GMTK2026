extends Node

enum CombineType{
	NONE,
	TOP_BUN,
	LETTUCE,
	MEAT,
	PICKLE,
	ONION,
	TOMATO,
	BOTTOM_BUN
}

enum ObjectType {
	None,
	Effect,
	Interactable,
	Knife,
	Processor,
	Space
}

signal mistake(strength)
signal calm_chef(strength)
signal enter_back_room
signal exit_back_room
