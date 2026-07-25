extends Node2D
@onready var chef_sprite: AnimatedSprite2D = $ChefSprite
@onready var timer: Timer = $Timer

var dialogue_path = "res://Dialogue/test.dialogue"
var dialogue_resource

var dialogue_running = false
var current_dialogue : String

func _ready() -> void:
	Globals.enter_back_room.connect(spawn_chef)
	Globals.exit_back_room.connect(leave_chef)
	Globals.reset_dialogue_timer.connect(reset_dialogue)
	dialogue_resource = load(dialogue_path)
	current_dialogue = "start"

func _process(_delta: float) -> void:
	if chef_sprite.visible && visible && !dialogue_running:
		DialogueManager.show_dialogue_balloon(dialogue_resource, current_dialogue)
		dialogue_running = true

func spawn_chef():
	chef_sprite.visible = true

func leave_chef():
	chef_sprite.visible = false

func reset_dialogue():
	timer.start()

func _on_timer_timeout() -> void:
	dialogue_running = false
	current_dialogue = "test"
