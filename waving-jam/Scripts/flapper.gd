extends CharacterBody3D

enum States {TARGETING, WAVED}

var player : CharacterBody3D
var state = States.TARGETING
var player_in_hurt_box = false

const SPEED := 4.0
const DAMAGE := 10.0

signal death(pos)

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
	emit_signal("death", global_position)
	queue_free()

#Damage Manager
func _on_hurt_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_hurt_box = true

func _on_hurt_box_body_exited(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player_in_hurt_box = false

func _process(delta: float) -> void:
	if player_in_hurt_box and state == States.TARGETING:
		player.hit(DAMAGE * delta)
