extends Node3D

enum Type {FLY, HOP, MUNCH, CHOMP}

@export var _range : float = 30.0
@export var _player : CharacterBody3D
@export var _shop_screen : Node
@export var wave_timer : Node
@export var enemy_spawn_timer : Node
@export var time_between_enemy_spawns := 1.0

@onready var health_drop := preload("res://Scenes/Entities/health_drop.tscn")
@onready var fly_enemy := preload("res://Scenes/Entities/flapper.tscn")
@onready var hop_enemy := preload("res://Scenes/Entities/jumper.tscn")
@onready var chomp_enemy : Node3D
@onready var shop := preload("res://Scenes/Entities/test_obj.tscn")
@onready var anim := $AnimationPlayer

var current_shop : Node
var current_enemies := 0
var wave := 1

signal win

var waves := {
	1 : [1, 0, 0],
	2 : [5, 0, 0],
	3 : [10, 0, 0],
	4 : [0, 1, 0],
	5 : [5, 5, 0],
	6 : [10, 15, 0],
	7 : [15, 15, 0],
	8 : [20, 15, 0],
	9 : [30, 10, 0],
	10 : [20, 20, 0],
	11 : [40, 30, 0],
	12 : [50, 50, 0],
	13 : [60, 60, 0]
}

func _ready() -> void:
	enemy_spawn_timer.wait_time = time_between_enemy_spawns
	spawn_next_wave()

func _process(_delta: float) -> void:
	$CanvasLayer/Control/TimeTillNextWave.text = "Time to next wave: " + "%01d" % ceil(wave_timer.time_left)

func finish_wave():
	if wave == 13:
		emit_signal("win")
		return
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
	new_shop.position = Vector3(2.0, 2.0, 0.0).rotated(Vector3.UP, randf_range(0.0, 2.0 * PI))
	new_shop.open_shop.connect(_on_open_shop)
	current_shop = new_shop
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
#			Type.CHOMP:
#				new_enemy = chomp_enemy.instantiate()
		current_enemies += 1
		new_enemy.player = _player
		new_enemy.position = Vector3(_range, 7.0, 0.0).rotated(Vector3.UP, randf_range(0, 2 * PI))
		new_enemy.death.connect(_on_enemy_death)
		add_child(new_enemy)
		enemy_spawn_timer.start()
		await enemy_spawn_timer.timeout

func _on_enemy_death(pos):
	current_enemies -= 1
	spawn_health_drop(pos)
	if current_enemies == 0:
		finish_wave()

func spawn_health_drop(pos : Vector3):
	if not Globals.health_packs:
		return
	if randf() > Globals.health_pack_chance:
		return
	
	var new_health_drop = health_drop.instantiate()
	new_health_drop.position = pos
	add_child(new_health_drop)

func _on_wave_timer_timeout() -> void:
	spawn_next_wave()
	
	if is_instance_valid(current_shop):
		current_shop.anim.play("out")
	anim.play("RESET")
