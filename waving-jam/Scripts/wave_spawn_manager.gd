extends Node3D

enum Type {FLY, HOP, MUNCH, CHOMP}

@export var _range : float = 30.0
@export var _player : CharacterBody3D
@export var _shop_screen : Node
@export var wave_timer : Node
@export var enemy_spawn_timer : Node
@export var time_between_enemy_spawns := 1.0

@onready var fly_enemy := preload("res://Scenes/Entities/flapper.tscn")
@onready var hop_enemy := preload("res://Scenes/Entities/jumper.tscn")
@onready var chomp_enemy : Node3D
@onready var shop := preload("res://Scenes/Entities/test_obj.tscn")
@onready var anim := $AnimationPlayer


var current_enemies := 0
var wave := 1

var waves := {
	1 : [5, 0, 0],
	2 : [10, 0, 0],
	3 : [0, 5, 0],
	4 : [0, 10, 0],
	5 : [10, 10, 0],
	6 : [20, 15, 0],
	7 : [5, 5, 0],
	8 : [10, 5, 0],
	9 : [3, 10, 0],
	10 : [20, 10, 0],
	11 : [0, 0, 1],
	12 : [3, 3, 1],
	13 : [10, 5, 2]
}

func _ready() -> void:
	enemy_spawn_timer.wait_time = time_between_enemy_spawns
	spawn_next_wave()

func _process(delta: float) -> void:
	$CanvasLayer/Control/TimeTillNextWave.text = "Time to next wave: " + "%01d" % ceil(wave_timer.time_left)

func finish_wave():
	wave_timer.start()
	anim.play("wave_complete")

func spawn_next_wave():
	var enemy_count = waves[wave]
	for i in range(3):
		match i:
			0:
				spawn_enemy(Type.FLY, enemy_count[i])
			1:
				spawn_enemy(Type.HOP, enemy_count[i])
			2:
				pass
				#spawn_enemy(Type.CHOMP, enemy_count[i])
	wave += 1

func spawn_shop():
	var new_shop = shop.instantiate()
	new_shop.position = Vector3(2, 2.0, 0.0).rotated(Vector3.UP, randf_range(0, 2 * PI))
	new_shop.open_shop.connect(_on_open_shop)
	add_child(new_shop)

func _on_open_shop():
	_shop_screen.show_screen()

func spawn_enemy(enemy_type, amount):
	for i in range(amount):
		var new_enemy
		
		match enemy_type:
			Type.FLY:
				new_enemy = fly_enemy.instantiate()
			Type.HOP:
				new_enemy = hop_enemy.instantiate()
			Type.CHOMP:
				new_enemy = chomp_enemy.instantiate()
		current_enemies += 1
		new_enemy.player = _player
		new_enemy.position = Vector3(_range, 7.0, 0.0).rotated(Vector3.UP, randf_range(0, 2 * PI))
		new_enemy.death.connect(_on_enemy_death)
		add_child(new_enemy)
		enemy_spawn_timer.start()
		await enemy_spawn_timer.timeout

func _on_enemy_death():
	current_enemies -= 1
	if current_enemies == 0:
		finish_wave()


func _on_wave_timer_timeout() -> void:
	spawn_next_wave()
	anim.play("RESET")
