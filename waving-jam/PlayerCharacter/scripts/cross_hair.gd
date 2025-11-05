extends TextureRect

@onready var _active = preload("res://PlayerCharacter/activecrosshair.png")
@onready var _not_active = preload("res://PlayerCharacter/crosshair.png")

func _on_interact_ray_colliding(_is_touching: bool) -> void:
	if _is_touching:
		texture = _active
	else:
		texture = _not_active
