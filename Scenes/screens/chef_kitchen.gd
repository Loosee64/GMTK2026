extends AnimatedSprite2D

var current_mood = 0
var aggression = 0
var aggression_modifier = 1.0

func _ready() -> void:
	get_parent().get_parent().mistake.connect(anger_chef)
	get_parent().get_parent().calm_chef.connect(calm_chef)


func anger_chef(strength):
	aggression += strength * aggression_modifier
	play("default")
	print("anger chef")

func calm_chef(strength):
	aggression -= strength
	print("calm chef")
