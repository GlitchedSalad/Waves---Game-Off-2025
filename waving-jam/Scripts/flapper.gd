extends CharacterBody3D

var player : CharacterBody3D

const SPEED := 3.0

func _ready() -> void:
	$AnimatedSprite3D.play("default")

func _physics_process(delta: float) -> void:
	var dir = (player.position - position).normalized()
	velocity = dir * SPEED
	
	move_and_slide()
