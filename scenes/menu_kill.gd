extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var retry_button: Button = find_child("RetryButton")
@onready var quit_button: Button = find_child("QuitButton")


func _ready():
	retry_button.pressed.connect(restart)
	quit_button.pressed.connect(get_tree().quit)
	visible = false

func restart():
	get_tree().change_scene_to_file("res://scenes/main.tscn")
	animator.play("Unpause")
	get_tree().paused = false
	visible = false
	#print("visible=false")

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	visible = false

func pause():
	visible = true
	animator.play("Pause")
	get_tree().paused = true

func _on_character_body_2d_pause():
	animator.play("Pause")
	get_tree().paused = true
	visible = true

func _on_character_body_2d_unpause():
	animator.play("Unpause")
	get_tree().paused = false
	visible = false


func _on_player_kill():
	animator.play("Pause")
	get_tree().paused = true
	visible = true
