extends TextureButton

@onready var ticket_pop_up: Control = $"../TicketPopUp"

func _on_pressed() -> void:
	ticket_pop_up.visible = true
	ticket_pop_up.popup()
