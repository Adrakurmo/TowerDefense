extends Node2D

var speed = 3500
var bulletDamage = 10

func _process(delta: float) -> void:		
	position += transform.x * speed * delta

func _on_area_2d_body_entered(body: Node2D) -> void:
	if GameManager.ENEMY_PREFIX in body.name:
		if body.has_method("apply_damage"):
			body.apply_damage(bulletDamage)
		self.queue_free()
		
func _on_visible_on_screen_enabler_2d_screen_exited() -> void:
	print("Grug threw it")
	self.queue_free()
