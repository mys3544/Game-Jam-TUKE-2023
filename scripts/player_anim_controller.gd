extends Marker2D

@onready var animation = $AnimationPlayer
var prev_anim = null
var n_pressed = 0

func _unhandled_input(event):
	if event is InputEventKey and !event.is_echo():
		if event.pressed:
			n_pressed += 1
		else:
			n_pressed -= 1
		print(n_pressed)

func read_input():
	if Input.is_action_pressed("Up"):
		change_anim("default_back")
	if Input.is_action_pressed("Down"):
		change_anim("default_front")
	if Input.is_action_pressed("Left"):
		change_anim("default_left")
	if Input.is_action_pressed("Right"):
		change_anim("default_right")

func change_anim(new):
	if n_pressed > 1:
		return
	if prev_anim != new and n_pressed < 2:
		prev_anim = new
		animation.stop()
		animation.play(new)

func _physics_process(_delta):
	read_input()
	if n_pressed < 1:
		animation.stop()
		prev_anim = null
