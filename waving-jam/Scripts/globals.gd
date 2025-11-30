extends Node

#General
var difficulty : float = 1.0

#Shop Modifiers
var health_packs : bool = false
var health_pack_chance : float = 0.0
var health_pack_amount : float = 10.0 
var speed_boost : float = 1.0
var spell_size : float = 1.0
var spell_cost : float = 1.0

func reset():
	health_packs = false
	health_pack_chance = 0.0
	health_pack_amount = 10.0 
	speed_boost = 1.0
	spell_size = 1.0
	spell_cost = 1.0
