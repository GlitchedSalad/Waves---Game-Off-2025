extends Control

signal retry_requested
signal to_title_requested

func _ready():
	hide()

func show_screen():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true

func _on_retry_pressed():
	get_tree().paused = false
	emit_signal("retry_requested")

func _on_to_title_pressed():
	get_tree().paused = false
	emit_signal("to_title_requested")
