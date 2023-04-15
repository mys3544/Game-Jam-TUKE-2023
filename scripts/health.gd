extends Node

const max_health = 3
var health = max_health : get = get_health

func get_health():
	return health

func add_hp():
	if health < max_health:
		health += 1
		print(health)

func sub_hp():
	if health > 0:
		health -= 1
		print(health)
