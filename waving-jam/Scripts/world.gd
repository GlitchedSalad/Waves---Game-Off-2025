extends Node3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("esc"):
		get_tree().paused = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _on_player_died():
	$DeathScreen.show_screen()


func _on_death_screen_retry_requested() -> void:
	get_tree().reload_current_scene()


func _on_death_screen_to_title_requested() -> void:
	get_tree().change_scene_to_file("res://Scenes/HostScenes/title.tscn")
