extends Node3D



func _on_death_plane_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		body.die()
	if body.is_in_group("Enemy"):
		body.hit(100)
