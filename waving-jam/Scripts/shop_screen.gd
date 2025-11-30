extends Control

func _ready() -> void:
	visible = false

func show_screen():
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	$ShopIcon/AnimationPlayer.play("default")

func hide_screen():
	hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false


func _on_health_button_pressed() -> void:
	if Globals.health_pack_chance == 0.0:
		Globals.health_packs = true
	Globals.health_pack_chance += 0.05
	hide_screen()


func _on_mp_button_pressed() -> void:
	Globals.spell_cost -= 0.05
	hide_screen()


func _on_spell_button_pressed() -> void:
	Globals.spell_size += 0.05
	hide_screen()


func _on_speed_button_pressed() -> void:
	Globals.speed_boost += 0.05
	hide_screen()


func _on_health_upgrade_button_pressed() -> void:
	Globals.health_pack_amount += 1.0
	hide_screen()
