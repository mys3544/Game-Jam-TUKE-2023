extends Control

@onready var score = $Label3

func _ready():
	score.text = str((GlobalVariables.get_kills() * 10) / 60) + " hours"


func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/level2.tscn")
