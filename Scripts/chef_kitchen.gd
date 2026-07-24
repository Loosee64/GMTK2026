extends AnimatedSprite2D

var current_mood = 0
var aggression = 0
var aggression_modifier = 1.0
const AGGRESSION_LIMIT_1 = 20
const AGGRESSION_LIMIT_2 = AGGRESSION_LIMIT_1 + 20
var aggression_factor = 0
var current_animation = "phase_1_wince"
var in_back_room = false

func _ready() -> void:
	Globals.mistake.connect(anger_chef)
	Globals.calm_chef.connect(calm_chef)

func _process(delta: float) -> void:
	if aggression > AGGRESSION_LIMIT_1:
		current_animation = "phase_2_wince"
		aggression_factor = 5
	else:
		if current_animation == "phase_2_wince":
			play("return_to_phase_1")
		current_animation = "phase_1_wince"
		aggression_factor = 0
	
	if aggression > AGGRESSION_LIMIT_2:
		in_back_room = true
		visible = false
		Globals.enter_back_room.emit()
	elif in_back_room:
		Globals.exit_back_room.emit()
		visible = true
		in_back_room = false

func anger_chef(strength):
	aggression += strength * aggression_modifier
	play(current_animation)
	print("anger chef")

func calm_chef(strength):
	aggression -= strength
	print("calm chef")

func get_aggression_factor() -> int:
	if !in_back_room:
		return aggression_factor
	else:
		return 10
