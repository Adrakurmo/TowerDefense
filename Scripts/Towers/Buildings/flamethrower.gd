extends StaticBody2D

# HERE YOU CAN LOAD DIFFERENT AMMO FOR DIFFERENT TURRETS! REMEBER TO SET EVERY
# BULLET SCENE PROPERLY IN BOTH SCRIPT AND SCENE!!!!!
const FLAMES = preload("res://Scenes/Towers/Bullets/flames.tscn")

# NECESSARY VARIABLES!!!
@onready var tower_range: Area2D = $Tower_range
@onready var bullet_container: Node = $Bullet_container
#@onready var aim1: Marker2D = $Aim1
#@onready var aim2: Marker2D = $Aim2
@onready var aim3: Marker2D = $Aim3
@onready var aims: Array[Marker2D] = [$Aim1, $Aim2, $Aim3, $Aim4, $Aim5, $Aim6, $Aim7, $Aim8]

var current_targets = []
var focused_target = null
var current_order = GameManager.targeting_order.MIDDLE


# NECESSARY METHODS!!!
#func _process(_delta: float) -> void:
	#BTB.if_valid_look_at_target(self, focused_target)
	
func _on_tower_range_body_entered(body: Node2D) -> void:
	BTB.update_current_targets(current_targets, tower_range, body)

func _on_tower_range_body_exited(body: Node2D) -> void:
	focused_target = null
	BTB.update_current_targets(current_targets, tower_range, body)

func _on_reload_time_timeout() -> void:
	focused_target = BTB.get_focused_target(current_targets, focused_target, current_order)
	if is_instance_valid(focused_target):
		for x in aims:
			BTB.reload_turret(FLAMES, bullet_container, x, self, x.rotation)
		#BTB.reload_turret(FLAMES, bullet_container, aim1, self)
		#BTB.reload_turret(FLAMES, bullet_container, aim2, self)
		#BTB.reload_turret(FLAMES, bullet_container, aim3, self)
			
