extends Node3D

@export var spawn_manager : Node

func _on_static_body_3d_interacted(body: Variant) -> void:
	spawn_manager.spawn_next_wave()
