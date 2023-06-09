extends Node2D

@onready var normal = preload("res://scenes/hostiles/shooter.tscn")
@onready var nightmare = preload("res://scenes/hostiles/shooter_nm.tscn")

# later change to globals maybe
var charges = 1
var chance = GlobalVariables.get_nightmare_counter()

func _ready():
	var enemy = null
	while true:
		if randi() % 100 < chance:
			enemy = nightmare.instantiate()
		else:
			enemy = normal.instantiate()
		self.add_child(enemy)
		await get_tree().create_timer(30).timeout
