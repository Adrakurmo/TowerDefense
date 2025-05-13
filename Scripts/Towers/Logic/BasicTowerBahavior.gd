extends Node


class_name BTB

static func if_valid_look_at_target(_self : StaticBody2D, focused_target):
	if is_instance_valid(focused_target):
		_self.look_at(focused_target.global_position)

static func update_current_targets(current_targets, tower_range: Area2D,  body):
	current_targets.clear()
	if GameManager.ENEMY_PREFIX in body.name:
		var tmp_arr = tower_range.get_overlapping_bodies()
	
		for e in tmp_arr:
			if GameManager.ENEMY_PREFIX in e.name:
				current_targets.append(e)

static func get_focused_target(current_targets, focused_target, current_order):
	for e in current_targets:
		if !is_instance_valid(e):
			continue
		if !is_instance_valid(focused_target):
			focused_target = e
		else:
			match current_order:
				GameManager.targeting_order.LAST:
					if focused_target.get_parent().get_progress() < e.get_parent().get_progress():
						focused_target = e
				GameManager.targeting_order.FIRST:
					if focused_target.get_parent().get_progress() > e.get_parent().get_progress():
						focused_target = e
				_:
					print("COULDNT SET TURRET: "," TARGET")
					return
		return focused_target

static func reload_turret(BULLET_TEST, bullet_container, aim, _self : StaticBody2D, angle = 0):
	var bullet_inst = BULLET_TEST.instantiate()
	bullet_container.call_deferred("add_child", bullet_inst)
	bullet_inst.global_position = aim.global_position
	bullet_inst.rotation = _self.rotation + angle
	
