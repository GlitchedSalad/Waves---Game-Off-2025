extends Control

var mouse_input: Vector2
var mouse_sensitivity: float = 0.005
var movement_mult := 50.0


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_input.x += -event.screen_relative.x * mouse_sensitivity
		mouse_input.y += -event.screen_relative.y * mouse_sensitivity

func _process(_delta: float) -> void:
	position += mouse_input * movement_mult
	position.y = clamp(position.y, -100, 100)
	position.x = clamp(position.x, -100, 100)
	position = lerp(position,  Vector2(0,0), _delta * 2.0)

	mouse_input = Vector2.ZERO
