extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("ResumeButton")
@onready var quit_button: Button = find_child("QuitButton")


func _ready():
	play_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)
	visible = false

func unpause():
	animator.play("Unpause")
	get_tree().paused = false
	visible = false

func pause():
	animator.play("Pause")
	get_tree().paused = true
	visible = true

func _on_character_body_2d_pause():
	visible = true
	animator.play("Pause")
	get_tree().paused = true

func _on_character_body_2d_unpause():
	visible = false
	animator.play("Unpause")
	get_tree().paused = false
	quit_button.set_disabled(true)
