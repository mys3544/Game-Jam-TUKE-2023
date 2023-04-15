extends CharacterBody2D

const Health = preload("res://scripts/health.gd")
var entity_hp = null

var speed = 150
var prev_speed = speed
var cur_speed = speed : get = get_cur_speed, set = set_cur_speed
var direction = Vector2.ZERO
var to_follow = null
var backing = false
var slowed = false

@onready var animation = $AnimationPlayer

func get_cur_speed():
	return cur_speed
	
func set_cur_speed(new_cur_speed):
	cur_speed = new_cur_speed

func _ready():
	entity_hp = Health.new()
	animation.play("front_default")

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

func _on_area_2d_area_entered(area):
	if !slowed && area.is_in_group("projectile") && area.get_cold_pillow_check():
		slowed = true
		prev_speed = cur_speed
		set_cur_speed(cur_speed/100*10)
		await get_tree().create_timer(1.5).timeout
		set_cur_speed(prev_speed)
		slowed = false

func die():
	queue_free()
