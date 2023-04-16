extends Node2D

@onready var normal = preload("res://scenes/hostiles/dasher.tscn")
@onready var nightmare = preload("res://scenes/hostiles/dasher_nm.tscn")

# later change to globals maybe
var charges = 1
var chance = GlobalVariables.get_nightmare_counter()

func _ready():
	var enemy = null
	for i in range(charges):
		if randi() % 100 < chance:
			enemy = nightmare.instantiate()
		else:
			enemy = normal.instantiate()
		self.add_child(enemy)
		await get_tree().create_timer(90).timeout
