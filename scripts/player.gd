extends Node

const Health = preload("res://scripts/health.gd")
var player_hp = null

func _ready():
	player_hp = Health.new()

func _on_area_2d_area_entered(area):
	if area.is_in_group("potion"):
		player_hp.add_hp()
	elif area.is_in_group("hostile"):
		player_hp.sub_hp()
