extends Node3D

@onready var anim := $AnimationPlayer
var player : Node3D

signal open_shop

func _ready() -> void:
	anim.play("init")
	anim.play("load")

func _on_static_body_3d_interacted(_body: Variant) -> void:
	emit_signal("open_shop")
	$"paper-towel/StaticBody3D".enabled = false
	anim.play("out")

func _process(delta: float) -> void:
	if player != null:
		$PlayerDetection.look_at(player.position, Vector3.UP)
	$"paper-towel".rotation.y = lerp($"paper-towel".rotation.y, $PlayerDetection.rotation.y + PI/2, 4.0 * delta)

func _on_player_detection_body_entered(body: Node3D) -> void:
	if body.is_in_group("Player"):
		player = body

func out():
	queue_free()
