extends Node2D
@onready var end_timer: Timer = $EndTimer
@onready var chatter: AudioStreamPlayer2D = $Chatter

var counter = 0
@export var MAX_COUNTER : int
var max_timer : int

func _ready() -> void:
	Globals.next_order.connect(add_order_counter)
	max_timer = end_timer.wait_time

func start_game():
	end_timer.start(max_timer)
	chatter.play()

func add_order_counter():
	counter += 1
	if counter >= MAX_COUNTER:
		Globals.shift_end.emit()
		Globals.scene_transition.emit("win")
		visible = false

func _on_end_timer_timeout() -> void:
	Globals.scene_transition.emit("game_over")
	visible = false
	chatter.stop()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tempSkipShift"):
		Globals.shift_end.emit()
		Globals.scene_transition.emit("win")
		visible = false
		chatter.stop()
