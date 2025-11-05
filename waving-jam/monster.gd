extends CharacterBody3D

@export var player : Node3D

const SPEED := 1.0

func _physics_process(delta: float) -> void:
	var dir = (player.position - position).normalized()
	velocity = dir * SPEED
	
	move_and_slide()
