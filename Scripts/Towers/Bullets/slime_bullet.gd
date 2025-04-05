extends Node2D

var speed = 3500
var bulletDamage = 10


func _process(delta: float) -> void:
	BBB.basic_bullet_movement(self, delta, speed)
	

func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	BBB.free_if_out_of_screen(self)


func _on_area_2d_body_entered(body: Node2D) -> void:
	BBB.if_valid_apply_damage(body, bulletDamage, self)
