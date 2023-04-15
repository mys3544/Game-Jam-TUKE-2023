extends Node2D

@onready var normal = preload("res://scenes/hostiles/follower.tscn")
@onready var nightmare = preload("res://scenes/hostiles/follower_nm.tscn")

# later change to globals maybe
var charges = 1
var chance = 20

func _ready():
	var enemy = null
	for i in range(charges):
		if randi() % 100 < chance:
			enemy = nightmare.instantiate()
		else:
			enemy = normal.instantiate()
	self.add_child(enemy)
	enemy.position = position
