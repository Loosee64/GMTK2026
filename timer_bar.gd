extends ProgressBar

@export var timer : Timer
var max = 0
var current = 0

func _ready() -> void:
	max = timer.wait_time

func _process(delta: float) -> void:
	current = timer.time_left
	if max > 0:
		value = (current / max) * 100
