extends Node

signal alarm_clock_item
signal melatonin_item
signal slippers_item
signal cold_pillow_item
signal warm_blanket_item
signal coffee_item

var inventory = []
var item_amount = [0, 0, 0, 0, 0, 0, 0]

func set_effect(item):
	match item.get_name():
		"alarm_clock":
			print("alarm")
			alarm_clock_item.emit()
		"melatonin":
			print("melatonin")
			melatonin_item.emit()
		"slippers":
			print("slippers")
			slippers_item.emit()
		"cold_pillow":
			print("cold_pillow")
			cold_pillow_item.emit()
		"warm_blanket":
			print("warm_blanket")
			warm_blanket_item.emit()
		"coffee":
			print("coffee")
			coffee_item.emit()

func _on_area_2d_area_entered(area):
	if area.is_in_group("Item"):
		var script = area.get_script()
		if !inventory.has(script):
			print("inv")
			inventory.append(script)
			item_amount[inventory.find(script)] += 1
			set_effect(area)
		elif inventory.has(script):
			item_amount[inventory.find(script)] += 1
			set_effect(area)
		for n in 6:
			print(item_amount[n])
		area.queue_free()

