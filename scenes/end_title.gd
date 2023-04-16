extends Control

@onready var score = $Label3

func _ready():
	score.text = str((GlobalVariables.get_kills() * 10) / 60) + " hours"
