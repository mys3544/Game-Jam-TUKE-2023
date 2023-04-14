extends Node

var health = 100
var mana = 0

func take_damage():
	health -= 10
	print(health)

func use_mana(amount):
	mana -= amount
	print(mana)

var _timer = null

func _on_Timer_timeout():
	if mana < 50:
		print(mana)
		mana += 1
