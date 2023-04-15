extends Node2D

signal bed_ready
var empty = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if !empty && get_tree().get_nodes_in_group("hostile").size() == 0:
		bed_ready.emit()
		empty = true
		print(empty)
		await get_tree().create_timer(5.0).timeout
	pass
