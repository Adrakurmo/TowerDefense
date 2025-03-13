extends StaticBody2D

@onready var bullet_container: Node = $Bullet_container
@onready var aim: Marker2D = $Aim
@onready var reload_time: Timer = $ReloadTime

const BULLET_TEST = preload("res://Scenes/Towers/bullet_test.tscn")

var current_targets = []
var focused_target = null

# ------------------------------ PROCES ------------------------------

func _process(delta: float) -> void:
	if is_instance_valid(focused_target):
		look_at(focused_target.global_position)
		
# ------------------------------ EVENTS ------------------------------

func _on_tower_range_body_entered(body: Node2D) -> void:
	update_current_targets(body)
	
func _on_tower_range_body_exited(body: Node2D) -> void:
	if body == focused_target:
		focused_target = null
	update_current_targets(body)

# Przy każdym przeładowaniu obliczamy nowy cel, obserwujemy i strzelamy.
func _on_reload_time_timeout() -> void:
	set_focused_target()
	if is_instance_valid(focused_target):
		look_at(focused_target.global_position)
		reload_turret()
# ------------------------------ PV METODY ----------------------------
			
func update_current_targets(body):
	current_targets.clear()
	if GameManager.ENEMY_PREFIX in body.name:
		var tmp_arr = get_node("Tower_range").get_overlapping_bodies()
	
		for e in tmp_arr:
			if GameManager.ENEMY_PREFIX in e.name:
				current_targets.append(e)	

func reload_turret():
	var bullet_inst = BULLET_TEST.instantiate()
	bullet_container.call_deferred("add_child", bullet_inst)
	bullet_inst.set_target(focused_target)
	bullet_inst.global_position = aim.global_position
	
func set_focused_target():
	for e in current_targets:
		if focused_target == null:
			focused_target = e
		else:
			if focused_target.get_parent().get_progress() < e.get_parent().get_progress():
				focused_target = e
# ---------------------------------------------------------------------
# ------------------------------ /PV METODY ---------------------------
# ---------------------------------------------------------------------
