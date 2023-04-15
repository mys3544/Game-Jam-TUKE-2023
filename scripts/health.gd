extends Node

signal death

@export var max_health = 3 : get = get_max_health, set = set_max_health
var health = max_health : get = get_health, set = set_health

func get_health():
	return health

func set_health(new_hp):
	health = new_hp

func get_max_health():
	return max_health
	
func set_max_health(new_max):
	max_health = new_max

func add_hp():
	if health < max_health:
		health += 1
		print(health)

func sub_hp():
	if health > 0:
		health -= 1
		print(health)
