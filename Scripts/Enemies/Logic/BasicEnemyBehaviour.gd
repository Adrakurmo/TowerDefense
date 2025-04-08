extends Node


class_name BEB

static func set_health_and_apply_damage(dmg, health : float, CONST_HEALTH : float, _self : Node2D, sprite_2d: Sprite2D):
	health -= dmg
	if health <= 0:
		_self.get_parent().get_parent().queue_free()
	#var new_val : float = health / CONST_HEALTH
	#sprite_2d.modulate =Color(new_val, new_val, new_val)
	return health

static func set_route_progress(current_path, speed : float, delta : float, _self : Node2D):
	current_path.set_progress(current_path.get_progress() + speed * delta)
	if current_path.get_progress_ratio() == 1:
		_self.get_parent().get_parent().queue_free()
