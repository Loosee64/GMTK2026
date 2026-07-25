extends Node2D
@onready var chef_sprite: AnimatedSprite2D = $ChefSprite

var dialogue_path = "res://Dialogue/test.dialogue"
var dialogue_resource

var dialogue_running = false

func _ready() -> void:
	Globals.enter_back_room.connect(spawn_chef)
	Globals.exit_back_room.connect(leave_chef)
	dialogue_resource = load(dialogue_path)

func _process(_delta: float) -> void:
	if chef_sprite.visible && visible && !dialogue_running:
		DialogueManager.show_dialogue_balloon(dialogue_resource, "start")
		dialogue_running = true

func spawn_chef():
	chef_sprite.visible = true

func leave_chef():
	chef_sprite.visible = false
