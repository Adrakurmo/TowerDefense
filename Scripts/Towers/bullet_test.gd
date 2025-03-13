extends CharacterBody2D

var target
var speed = 1500
var pathName
var bulletDamage = 10
var direction = Vector2.ZERO

func set_target(newTarget: Node2D):
	if is_instance_valid(newTarget):
		direction = newTarget.global_position
		target = newTarget
		#print("DIRECTION: ", direction, " TARGET POS: ", newTarget.global_position)

func _physics_process(delta: float) -> void:
	if target == null:
		self.queue_free()
	#velocity = direction * speed
	#look_at(direction)
	velocity = global_position.direction_to(direction) * speed
	move_and_slide()
	if global_position.distance_to(direction) < speed * delta:
		queue_free()


func _on_area_2d_body_entered(body: Node2D) -> void:
	#print(body.name)
	if GameManager.ENEMY_PREFIX in body.name:
		if body.has_method("apply_damage"):
			body.apply_damage(bulletDamage)
		self.queue_free()
