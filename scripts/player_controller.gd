extends CharacterBody2D

var direction : Vector2 = Vector2()

func read_input():
	velocity = Vector2.ZERO
	
	if Input.is_action_pressed("Up"):
		velocity.y -=1
		direction = Vector2(0, -1)
		print("UP")

	if Input.is_action_pressed("Down"):
		velocity.y +=1
		direction = Vector2(0, 1)

	if Input.is_action_pressed("Left"):
		velocity.x -=1
		direction = Vector2(-1, 0)

	if Input.is_action_pressed("Right"):
		velocity.x +=1
		direction = Vector2(1, 0)

	velocity = velocity.normalized()*400
	move_and_slide()

func _physics_process(delta):
	read_input()
