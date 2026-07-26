extends Node2D
@onready var timer: Timer = $Timer
@onready var game_over_sting: AudioStreamPlayer = $GameOverSting

func start_game_over():
	timer.start()
	game_over_sting.play()

func _on_timer_timeout() -> void:
	Globals.scene_transition.emit("menu")
	visible = false
	timer.stop()
	game_over_sting.stop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("click") && !timer.is_stopped():
		Globals.scene_transition.emit("menu")
		visible = false
		timer.stop()
		game_over_sting.stop()
