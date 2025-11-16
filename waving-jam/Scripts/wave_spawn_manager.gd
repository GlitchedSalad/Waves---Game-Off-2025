extends Node3D

enum Type {FLY, MUNCH, CHOMP}

@export var _range : float = 30.0
@export var _player : CharacterBody3D
@onready var fly_enemy := preload("res://Scenes/flapper.tscn")
@onready var munch_enemy : Node3D
@onready var chomp_enemy : Node3D
@export var timer : Node
@export var time_between_enemy_spawns := 1.0

var wave := 1

var waves := {
	1 : [3, 0, 0],
	2 : [6, 0, 0],
	3 : [10, 0, 0],
	4 : [0, 1, 0],
	5 : [3, 1, 0],
	6 : [6, 2, 0],
	7 : [5, 5, 0],
	8 : [10, 5, 0],
	9 : [3, 10, 0],
	10 : [20, 10, 0],
	11 : [0, 0, 1],
	12 : [3, 3, 1],
	13 : [10, 5, 2]
}

func _ready() -> void:
	timer.wait_time = time_between_enemy_spawns


func spawn_next_wave():
	var enemy_count = waves[wave]
	print(enemy_count)
	for i in range(3):
		match i:
			0:
				spawn_enemy(Type.FLY, enemy_count[i])
			1:
				print(Type.MUNCH, enemy_count[i])
			2:
				print(Type.CHOMP, enemy_count[i])
	wave += 1


func spawn_enemy(enemy_type, amount):
	for i in range(amount):
		match enemy_type:
			Type.FLY:
				var new_enemy = fly_enemy.instantiate()
				new_enemy.player = _player
				new_enemy.position = Vector3(_range, 7.0, 0.0).rotated(Vector3.UP, randf_range(0, 2 * PI))
				get_tree().root.add_child(new_enemy)
			Type.MUNCH:
				var new_enemy = munch_enemy.instantiate()
				new_enemy
				get_tree().root.add_child(new_enemy)
			Type.CHOMP:
				var new_enemy = chomp_enemy.instantiate()
				new_enemy
				get_tree().root.add_child(new_enemy)
		timer.start()
		await timer.timeout
