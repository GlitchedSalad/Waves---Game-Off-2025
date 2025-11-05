class_name PlayerController
extends CharacterBody3D

const SPEED = 4.0
const JUMPHEIGHT = 5.0

@onready var camera_controller_anchor: Marker3D = $CameraControllerAnchor

func _physics_process(delta: float) -> void:
	
	
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMPHEIGHT
	
	var input_dir: Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	
	
	var new_velocity = Vector2.ZERO
	var direction: Vector3 = (transform.basis * Vector3(input_dir.x, 0.0, input_dir.y)).normalized()
	if direction:
		new_velocity = Vector2(direction.x, direction.z) * SPEED
	velocity = Vector3(new_velocity.x, velocity.y, new_velocity.y)
	move_and_slide()
