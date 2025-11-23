extends CharacterBody3D

enum States {TARGETING, WAVED}

var player : CharacterBody3D
var state = States.TARGETING

@onready var timer = $AttackTimer

const SPEED := 5.0
const GRAVITY := 10.0

signal death

func _ready() -> void:
	$AnimatedSprite3D.play("default")
	timer.start()
	pass

func _physics_process(delta: float) -> void:
	velocity.y -= GRAVITY * delta
	if state == States.TARGETING:
		if velocity.y < 0:
			$AnimatedSprite3D.play("default")
		velocity.x = lerp(velocity.x, 0.0, delta)
		velocity.z = lerp(velocity.z, 0.0, delta)
	
	if state == States.WAVED:
		velocity = lerp(velocity, Vector3.ZERO, delta)
	
	move_and_slide()


func _on_attack_timer_timeout() -> void:
	var dir = (player.position - position).normalized()
	$AnimatedSprite3D.play("jump")
	velocity = dir * SPEED
	velocity.y = 10.0

func hit(dmg):
	$HealthNode.damage(dmg)

func wave(vector):
	state = States.WAVED
	velocity = vector * 10.0
	$AnimatedSprite3D.stop()
	$AnimatedSprite3D.play("hurt")
	timer.stop()
	get_tree().create_timer(3).timeout.connect(_on_wave_recover)

func _on_wave_recover():
	state = States.TARGETING
	timer.start()

func _on_health_node_death() -> void:
	emit_signal("death")
	queue_free()
