extends Area2D

class_name Projectile

var speed : float = 25.0

func _physics_process(delta : float) -> void:
	position += global_transform.x * speed


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
	pass # Replace with function body.
