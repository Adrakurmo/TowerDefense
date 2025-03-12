extends CharacterBody2D

var target
var speed = 200
var pathName
var bulletDamage
var destination

func set_target(newTarget):
	target = newTarget
	destination = target.global_position

func _physics_process(delta: float) -> void:
	
	if target == null:
		self.queue_free()
	#print(target)
	velocity = global_position.direction_to(destination) * speed
	look_at(destination)
	move_and_slide()
