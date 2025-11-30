extends Node

@export var total_health := 10.0
var current_health := 10.0

signal death

func _ready() -> void:
	current_health = total_health

func damage(dmg : float):
	current_health -= dmg
	
	if current_health <= 0.0:
		emit_signal("death")

func heal(hp : float):
	current_health = clampf(current_health + hp, 0.0, total_health)
