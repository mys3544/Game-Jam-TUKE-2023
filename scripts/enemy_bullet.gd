extends Area2D

var speed = 5

func _physics_process(delta):
	position += global_transform.x * speed

# destroy on collision with anything
func _on_body_entered(body):
	queue_free()
