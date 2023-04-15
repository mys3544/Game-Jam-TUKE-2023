extends Control

var max_hearts = 3 : set = set_max_hearts
var hearts = 3 : set = set_hearts
var parent = null
@onready var heart_ui_full = $HeartFull
@onready var heart_ui_empty = $HeartEmpty

func set_max_hearts(value):
	# cannot be < 1
	max_hearts = max(1, value)
	# draw empty containers (overlapped by full hp)
	heart_ui_empty.set_size(Vector2(max_hearts * 32, heart_ui_empty.get_rect().size.y))

func set_hearts(value):
	# between 0 and max_hearts
	hearts = clamp(value, 0, max_hearts)
	# draw the hearts / update them
	heart_ui_full.set_size(Vector2(hearts * 32, heart_ui_full.get_rect().size.y))
	if hearts <= 0:
		heart_ui_full.visible = false
	else:
		heart_ui_full.visible = true

func _on_player_health_changed(current_hp):
	set_hearts(current_hp)

func _on_player_health_ready(current_hp, max_hp):
	set_max_hearts(max_hp)
	set_hearts(current_hp)

