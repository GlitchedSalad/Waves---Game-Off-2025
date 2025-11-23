extends CharacterBody3D

enum States {TARGETING, WAVED}

var player : CharacterBody3D
var state = States.TARGETING

const SPEED := 3.0

signal death

func _ready() -> void:
	$AnimatedSprite3D.play("default")

func _physics_process(delta: float) -> void:
	if state == States.TARGETING:
		var dir = (player.position - position).normalized()
		velocity = dir * SPEED
	
	if state == States.WAVED:
		velocity = lerp(velocity, Vector3.ZERO, delta)
	
	
	move_and_slide()

func hit(dmg):
	$HealthNode.damage(dmg)

func wave(vector):
	state = States.WAVED
	velocity = vector * 20.0
	$AnimatedSprite3D.stop()
	$AnimatedSprite3D.play("hurt")
	get_tree().create_timer(3).timeout.connect(_on_wave_recover)

func _on_wave_recover():
	state = States.TARGETING
	$AnimatedSprite3D.play("default")

func _on_health_node_death() -> void:
	emit_signal("death")
	queue_free()
