extends Area3D

@export var magic_meter : Node
@export var magic_cost := 15.0

func deflect():
	scale = Vector3.ONE * Globals.spell_size
	magic_meter.deplete(magic_cost * Globals.spell_cost)
	var bodies = get_overlapping_bodies()
	for i in bodies:
		if i.is_in_group("Enemy"):
			var vec = (i.global_position - global_position).normalized()
			i.wave(vec)
			i.hit(5.0)
