extends Node3D

func _ready() -> void:
	$HelpScreen.hide()
	$MainScreen.show()

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/HostScenes/world.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_help_pressed() -> void:
	$HelpScreen.show()
	$MainScreen.hide()


func _on_back_pressed() -> void:
	$HelpScreen.hide()
	$MainScreen.show()
