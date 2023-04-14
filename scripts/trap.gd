extends Area2D

var triggered = false

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Triggered")
		triggered = true
		Player.take_damage()

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Stepped out")
		triggered = false
