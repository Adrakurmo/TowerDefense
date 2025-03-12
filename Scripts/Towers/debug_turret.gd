extends StaticBody2D

@onready var bullet_container: Node = $Bullet_container
@onready var aim: Marker2D = $Aim

const BULLET_TEST = preload("res://Scenes/Towers/bullet_test.tscn")

var current_targets = []
var focused_target = null

func _process(delta: float) -> void:
	if is_instance_valid(focused_target):
		look_at(focused_target.global_position)

func _on_tower_range_body_entered(body: Node2D) -> void:
	current_targets = get_node("Tower_range").get_overlapping_bodies()
	#print(current_targets)
	#print()
	if focused_target == null:
		if ENEMY_PREFIX in current_targets[-1].name:
			focused_target = current_targets[-1]
			var bullet_inst = BULLET_TEST.instantiate()
			bullet_inst.set_target(focused_target)
			aim.add_child(bullet_inst)
	else:
		pass


func _on_tower_range_body_exited(body: Node2D) -> void:
	if body == focused_target:
		focused_target = null
