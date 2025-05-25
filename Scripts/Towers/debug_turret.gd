extends StaticBody2D

@onready var bullet_container: Node = $Bullet_container
@onready var aim: Marker2D = $Aim
@onready var reload_time: Timer = $ReloadTime

@export var cost : int  = 1

const BULLET_TEST = preload("res://Scenes/Towers/Bullets/bullet_test.tscn")

var current_targets = []
var focused_target = null

# MIDDLE NOT WORKING YET
enum targeting_order { FIRST, LAST, MIDDLE }
var current_order = targeting_order.FIRST
# ------------------------------ PROCES ------------------------------

func _process(_delta: float) -> void:
	if_valid_look_at_target()
		
# ------------------------------ EVENTS ------------------------------
func if_valid_look_at_target():
	if is_instance_valid(focused_target):
		look_at(focused_target.global_position)

func _on_tower_range_body_entered(body: Node2D) -> void:
	update_current_targets(body)
	
func _on_tower_range_body_exited(body: Node2D) -> void:
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
	if body.is_in_group("w_enemy"):
		var tmp_arr = get_node("Tower_range").get_overlapping_bodies()
	
		for e in tmp_arr:
			if body.is_in_group("w_enemy"):
				current_targets.append(e)	

func reload_turret():
	var bullet_inst = BULLET_TEST.instantiate()
	bullet_container.call_deferred("add_child", bullet_inst)
	bullet_inst.global_position = aim.global_position
	bullet_inst.rotation = rotation
	
func set_focused_target():
	for e in current_targets:
		if !is_instance_valid(e):
			continue
		if !is_instance_valid(focused_target):
			focused_target = e
		else:
			match current_order:
				targeting_order.LAST:
					if focused_target.get_parent().get_progress() < e.get_parent().get_progress():
						focused_target = e
				targeting_order.FIRST:
					if focused_target.get_parent().get_progress() > e.get_parent().get_progress():
						focused_target = e
				_:
					print("COULDNT SET TURRET: ", self.name, " TARGET")
					return
# ---------------------------------------------------------------------
# ------------------------------ /PV METODY ---------------------------
# ---------------------------------------------------------------------
