extends Node

var health = 3

func take_damage():
	health -= 1
	print(health)
	
func heal():
	if health < 3:
		health += 1
		print(health)

func _on_area_2d_area_entered(area):
	if area.is_in_group("potion"):
		heal()
	elif area.is_in_group("hostile"):
		take_damage()
