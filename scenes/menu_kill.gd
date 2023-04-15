extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var retry_button: Button = find_child("RetryButton")
@onready var quit_button: Button = find_child("QuitButton")


func _ready():
	retry_button.pressed.connect(func(): get_tree().change_scene_to_file("res://scenes/main.tscn"))
	quit_button.pressed.connect(get_tree().quit)

func unpause():
	animator.play("Unpause")
	get_tree().paused = false

func pause():
	animator.play("Pause")
	get_tree().paused = true


func _on_character_body_2d_pause():
	animator.play("Pause")
	get_tree().paused = true


func _on_character_body_2d_unpause():
	animator.play("Unpause")
	get_tree().paused = false


func _on_player_kill():
	animator.play("Pause")
