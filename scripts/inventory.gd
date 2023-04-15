extends Node

var inventory = []
var item_amount = [0, 0, 0, 0]

func _on_area_2d_area_entered(area):
	if inventory.size() < 4 && !inventory.has(area):
		print("inv")
		inventory.append(area)
		item_amount[inventory.find(area)] += 1
	elif inventory.has(area):
		item_amount[inventory.find(area)] += 1
	for n in 4:
		print(item_amount[n])
