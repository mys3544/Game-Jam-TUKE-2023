extends ColorRect

@onready var animator: AnimationPlayer = $AnimationPlayer
@onready var play_button: Button = find_child("ResumeButton")
@onready var quit_button: Button = find_child("QuitButton")


func _ready():
	play_button.pressed.connect(unpause)
	quit_button.pressed.connect(get_tree().quit)
	play_button.set_disabled(true)
	quit_button.set_disabled(true)

func unpause():
	animator.play("Unpause")
	get_tree().paused = false

func pause():
	animator.play("Pause")
	get_tree().paused = true


func _on_character_body_2d_pause():
	animator.play("Pause")
	get_tree().paused = true
	quit_button.set_disabled(false)


func _on_character_body_2d_unpause():
	animator.play("Unpause")
	get_tree().paused = false
	quit_button.set_disabled(true)
