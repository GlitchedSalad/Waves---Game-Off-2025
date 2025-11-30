extends Node3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	Globals.reset()

###### Use for Shop Debug
#func _process(_delta: float) -> void:
#	if Input.is_action_just_pressed("esc"):
#		get_tree().paused = true
#		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		$ShopScreen.show_screen()

func _on_player_died():
	$DeathScreen.show_screen()


func _on_death_screen_retry_requested() -> void:
	get_tree().reload_current_scene()


func _on_death_screen_to_title_requested() -> void:
	get_tree().change_scene_to_file("res://Scenes/HostScenes/title.tscn")


func _on_wave_spawn_manager_win() -> void:
	$WinScreen.show_screen()
