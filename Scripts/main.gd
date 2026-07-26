extends Node2D

@onready var kitchen: Node2D = $Kitchen
@onready var back_room: Node2D = $BackRoom
@onready var game_over: Node2D = $GameOver
@onready var title: Node2D = $Title
@onready var shift_intermission: Node2D = $ShiftIntermission
@onready var game_end: Node2D = $GameEnd
@onready var title_screen: AudioStreamPlayer2D = $TitleScreen
@onready var main_normal: AudioStreamPlayer2D = $MainNormal
@onready var main_ehhh: AudioStreamPlayer2D = $MainEhhh
@onready var main_evil: AudioStreamPlayer2D = $MainEvil

@export var max_shifts : int
var current_shift = 1

func _ready() -> void:
	Globals.scene_transition.connect(_change_scene)
	Globals.shift_end.connect(_next_shift)
	Globals.change_music.connect(_switch_theme)
	Globals.muffle.connect(_muffle_music)

func _next_shift():
	if current_shift < max_shifts:
		current_shift += 1
	else:
		Globals.scene_transition.emit("game_end")

func _pause_all_music():
	title_screen.stop()
	main_normal.stop()
	main_ehhh.stop()
	main_evil.stop()

func _change_scene(next):
	_pause_all_music()
	match(next):
		"play":
			title.visible = false
			kitchen.visible = true
			kitchen.start_game()
			main_normal.play()
			main_ehhh.play()
			main_evil.play()
			_switch_theme("normal")
		"game_over":
			game_over.visible = true
			game_over.start_game_over()
		"menu":
			title.visible = true
			shift_intermission.visible = false
			title_screen.play()
		"win":
			shift_intermission.visible = true
			shift_intermission.on_enter()
		"game_end":
			shift_intermission.visible = false
			game_end.visible = true
		"true_end":
			shift_intermission.visible = false
			title.visible = true
			current_shift = 1

func _muffle_music(enabled):
	AudioServer.set_bus_effect_enabled(1,0,enabled)

func _on_switch_to_back_pressed() -> void:
	kitchen.visible = false
	back_room.visible = true
	Globals.muffle.emit(true)
	Globals.player_back_room.emit(true)


func _on_switch_to_kitchen_pressed() -> void:
	kitchen.visible = true
	back_room.visible = false
	Globals.muffle.emit(false)
	Globals.player_back_room.emit(false)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("tempMad"):
		Globals.mistake.emit(5)
	if event.is_action_pressed("tempCalm"):
		Globals.calm_chef.emit(5)

func _switch_theme(variant : String):
	match(variant):
		"normal":
			main_normal.volume_db = 0
			main_evil.volume_db = -80
			main_ehhh.volume_db = -80
		"ehh":
			main_normal.volume_db = -80
			main_evil.volume_db = -80
			main_ehhh.volume_db = 0
		"evil":
			main_normal.volume_db = -80
			main_evil.volume_db = -10
			main_ehhh.volume_db = -80
