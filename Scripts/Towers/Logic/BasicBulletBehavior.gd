extends Node


class_name BBB

static func basic_bullet_movement(_self : Node2D, delta: float, speed : float):
	_self.position += _self.transform.x * speed * delta
	
static func if_valid_apply_damage(body : Node2D, bulletDamage, _self : Node2D):
	if body.is_in_group("w_enemy"):
		if body.has_method("apply_damage"):
			body.apply_damage(bulletDamage)
		_self.queue_free()
		
static func free_if_out_of_screen(_self : Node2D) -> void:
	print("Grug threw it")
	_self.queue_free()
