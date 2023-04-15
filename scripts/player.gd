extends Node

const Health = preload("res://scripts/health.gd")

var player_hp = null
var player_inventory = null

var i_frame_duration = 3
var invincible = false

var speed_boost_timer = 0
var slow_down_timer = 0
var speed_timer_check = false
var slow_timer_check = false

# signals for UI elements
signal health_changed(current_hp)
signal health_ready(current_hp, max_hp)

# signals for power-ups/slow-downs
signal speed_boost_start()
signal speed_boost_stop()
signal slow_down_start()
signal slow_down_stop()

func _ready():
	player_hp = Health.new()
	health_ready.emit(player_hp.get_health(), player_hp.max_health)

func _physics_process(delta):
	if speed_boost_timer > 0:
		speed_boost_timer -= delta
		speed_timer_check = true
		pass
	elif (speed_timer_check) && speed_boost_timer < 0.2:
		speed_boost_stop.emit()
		speed_timer_check = false
		pass
	if slow_down_timer > 0:
		slow_down_timer -= delta
		slow_timer_check = true
		pass
	elif (slow_timer_check) && slow_down_timer < 0.2:
		slow_down_stop.emit()
		slow_timer_check = false
		pass

func die():
	queue_free()

func get_hit():
	if !invincible:
		player_hp.sub_hp()
		health_changed.emit(player_hp.get_health())
		i_frames(i_frame_duration)
	if player_hp.get_health() < 1:
		die()
	
# area collisions (pickups/bullets/etc.)
func _on_area_2d_area_entered(area):
	if area.is_in_group("potion"):
		player_hp.add_hp()
		health_changed.emit(player_hp.get_health())
	elif area.is_in_group("hostile"):
		get_hit()
	elif area.is_in_group("speed_boost") && slow_down_timer < 0.1:
		speed_boost_start.emit()
		speed_boost_timer += 5
	elif area.is_in_group("slow_down") && speed_boost_timer < 0.1:
		slow_down_start.emit()
		slow_down_timer += 5

# character collisions (enemies)
func _on_area_2d_body_entered(body):
	if body.is_in_group("hostile"):
		get_hit()
		body.bounce()

func i_frames(duration):
	invincible = true
	await get_tree().create_timer(duration).timeout
	invincible = false

func _on_inventory_melatonin_item():
	player_hp.set_max_health(player_hp.get_max_health() + 1)
	health_ready.emit(player_hp.get_health(), player_hp.get_max_health())
