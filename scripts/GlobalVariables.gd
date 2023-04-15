extends Node

var nightmare_counter = 10 : get = get_nightmare_counter, set = set_nightmare_counter

func set_nightmare_counter(value):
	nightmare_counter = clamp(value, 0, 100)

func get_nightmare_counter():
	return nightmare_counter
