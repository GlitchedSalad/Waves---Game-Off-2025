extends Control

@export var health : Node
@export var magic : Node
@onready var health_bar = $HealthBar
@onready var magic_bar = $MagicBar

func _process(delta: float) -> void:
	health_bar.value = health.current_health
	magic_bar.value = magic.current_magic
