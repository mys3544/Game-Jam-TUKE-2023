extends CharacterBody2D

const Health = preload("res://scripts/health.gd")

var entity_hp = null

var speed = 150
var cur_speed = speed
var direction = Vector2.ZERO
var to_follow = null
var backing = false

func _ready():
	entity_hp = Health.new()

func _physics_process(delta):
	# reset direction
	if !backing:
		direction = Vector2.ZERO
	# if player is spotted
		if to_follow:
			# set new direction
			direction = position.direction_to(to_follow.get_global_position()) * cur_speed
	# move set direction
	velocity = direction
	move_and_slide()

# on enter set node to be followed and on leave stop
func _on_area_2d_body_entered(body):
	if body.is_in_group("player"):
		to_follow = body

func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		to_follow = null

func bounce():
	direction *= -1
	backing = true
	await get_tree().create_timer(0.5).timeout
	backing = false
	
