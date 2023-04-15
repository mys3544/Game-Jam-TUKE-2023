extends Area2D

class_name Projectile

var speed : float = 25.0 : get = get_speed, set = set_speed
var cold_pillow_check = false : get = get_cold_pillow_check, set = set_cold_pillow_check
var warm_blanket_check = false : get = get_warm_blanket_check, set = set_warm_blanket_check

func _physics_process(delta : float) -> void:
	position += global_transform.x * speed

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body):
	for entity in self.get_overlapping_bodies():
		if entity.is_in_group("hostile"):
			entity.entity_hp.sub_hp()
			if warm_blanket_check:
				entity.entity_hp.sub_hp()
			if entity.entity_hp.get_health() < 1:
				entity.die()
			queue_free()
		if entity.is_in_group("player"):
			return
	queue_free()

func get_cold_pillow_check():
	return cold_pillow_check

func set_cold_pillow_check(new):
	cold_pillow_check = new

func get_warm_blanket_check():
	return warm_blanket_check

func set_warm_blanket_check(new):
	warm_blanket_check = new

func get_speed():
	return speed

func set_speed(new_speed):
	speed = new_speed
