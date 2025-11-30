extends Node3D

@export var speed : float = 15.0
@export var damage : float = 10.0

func _ready() -> void:
	$AnimatedSprite3D.play("default")
	scale = Vector3.ONE * Globals.spell_size

func init(rot : Vector3, pos : Vector3):
	rotation = rot
	position = pos

func _physics_process(delta):
	var forward_vector = -global_transform.basis.z
	position += forward_vector * speed * delta


func _on_hurt_box_body_entered(body: Node3D) -> void:
	if body.is_in_group("Enemy"):
		body.hit(damage)
		$AnimatedSprite3D.queue_free()
		$HurtBox.queue_free()
		$GPUParticles3D.emitting = true
		await $GPUParticles3D.finished
		queue_free()


func _on_timer_timeout() -> void:
	queue_free()
