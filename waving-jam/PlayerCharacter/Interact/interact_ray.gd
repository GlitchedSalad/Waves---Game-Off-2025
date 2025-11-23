extends RayCast3D

signal colliding(_is_touching: bool)

@export var left_anim : Node
@export var right_anim : Node
@export var magic_meter : Node
@export var magic_cost := 5.0

@onready var promt := $Promt

var bullet = preload("res://Scenes/Entities/magic_ball.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("spell"):
		left_anim.play("spell")
	if Input.is_action_just_pressed("wave"):
		if magic_meter.current_magic >= 10.0:
			right_anim.play("wave")
func shoot():
	magic_meter.deplete(magic_cost)
	var new_bullet = bullet.instantiate()
	new_bullet.init(global_rotation, global_position)
	get_tree().root.add_child(new_bullet)

func _physics_process(_delta: float) -> void:
	promt.text = ""
	
	if not is_colliding():
		colliding.emit(false)
		return
	
	var collider := get_collider()
	
	if collider is not Interactable:
		colliding.emit(false)
		return
	
	if not collider.enabled:
		promt.text = ""
		return
	
	colliding.emit(true)
	
	promt.text = collider.promt_message
	
	if Input.is_action_just_pressed("wave"):
		collider.interact(self)
