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
		Globals.change_music.emit("ehh")
	else:
		if current_animation == "phase_2_wince":
			play("return_to_phase_1")
		current_animation = "phase_1_wince"
		aggression_factor = 0
		Globals.change_music.emit("normal")
	
	if aggression > AGGRESSION_LIMIT_2:
		in_back_room = true
		Globals.change_music.emit("evil")
		visible = false
		Globals.enter_back_room.emit()
	
	if in_back_room && aggression < AGGRESSION_LIMIT_1:
		Globals.exit_back_room.emit()
		visible = true
		in_back_room = false

func anger_chef(strength):
	aggression += strength * aggression_modifier
	print(aggression)
	play(current_animation)

func calm_chef(strength):
	aggression -= strength
	print(aggression)

func get_aggression_factor() -> int:
	if !in_back_room:
		return aggression_factor
	else:
		return 10
