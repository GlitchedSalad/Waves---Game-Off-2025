extends Node

@export var total_magic := 10.0
@export var mp_per_second := 5.0
var current_magic := 10.0

func _ready() -> void:
	current_magic = total_magic

func _physics_process(delta: float) -> void:
	fill(mp_per_second * delta)

func deplete(amount : float):
	current_magic -= amount

func fill(mp : float):
	current_magic = clampf(current_magic + mp, 0.0, total_magic)
