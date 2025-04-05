extends StaticBody2D

# HERE YOU CAN LOAD DIFFERENT AMMO FOR DIFFERENT TURRETS! REMEBER TO SET EVERY
# BULLET SCENE PROPERLY IN BOTH SCRIPT AND SCENE!!!!!
const SLIME_BULLET = preload("res://Scenes/Towers/Bullets/slime_bullet.tscn")

# NECESSARY VARIABLES!!!
@onready var tower_range: Area2D = $Tower_range
@onready var bullet_container: Node = $Bullet_container
@onready var aim: Marker2D = $Aim

var current_targets = []
var focused_target = null
var current_order = GameManager.targeting_order.FIRST


# NECESSARY METHODS!!!
func _process(_delta: float) -> void:
	BTB.if_valid_look_at_target(self, focused_target)
	
func _on_tower_range_body_entered(body: Node2D) -> void:
	BTB.update_current_targets(current_targets, tower_range, body)

func _on_tower_range_body_exited(body: Node2D) -> void:
	focused_target = null
	BTB.update_current_targets(current_targets, tower_range, body)

func _on_reload_time_timeout() -> void:
	focused_target = BTB.get_focused_target(current_targets, focused_target, current_order)
	if is_instance_valid(focused_target):
		look_at(focused_target.global_position)
		BTB.reload_turret(SLIME_BULLET, bullet_container, aim, self)
			
