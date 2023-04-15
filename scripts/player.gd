extends Node

const Health = preload("res://scripts/health.gd")
var player_hp = null
# signals for UI elements
signal health_changed(current_hp)
signal health_ready

func _ready():
	player_hp = Health.new()
	health_ready.emit()

# area collisions (pickups/bullets/etc.)
func _on_area_2d_area_entered(area):
	if area.is_in_group("potion"):
		player_hp.add_hp()
		health_changed.emit(player_hp.get_health())
	elif area.is_in_group("hostile"):
		player_hp.sub_hp()
		health_changed.emit(player_hp.get_health())

# character collisions (enemies)
func _on_area_2d_body_entered(body):
	if body.is_in_group("hostile"):
		player_hp.sub_hp()
		health_changed.emit(player_hp.get_health())
