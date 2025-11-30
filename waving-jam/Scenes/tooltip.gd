extends PanelContainer


const OFFSET := Vector2(20.0,-5.0)

func toggle(on : bool):
	if on:
		show()
	else:
		hide()

func _input(event: InputEvent) -> void:
	if visible and event is InputEventMouseMotion:
		global_position = get_global_mouse_position() + OFFSET
