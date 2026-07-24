extends Node2D
@onready var chef_sprite: AnimatedSprite2D = $ChefSprite

func _ready() -> void:
	Globals.enter_back_room.connect(spawn_chef)
	Globals.exit_back_room.connect(leave_chef)


func spawn_chef():
	chef_sprite.visible = true

func leave_chef():
	chef_sprite.visible = false
