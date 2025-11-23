extends Node

var time := 0.0

func _process(delta: float) -> void:
	time += delta

func get_time():
	return time

func reset_time():
	time = 0.0
