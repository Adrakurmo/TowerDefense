extends StaticBody2D
class_name SlimeDestroyer
# HERE YOU CAN LOAD DIFFERENT AMMO FOR DIFFERENT TURRETS! REMEBER TO SET EVERY
# BULLET SCENE PROPERLY IN BOTH SCRIPT AND SCENE!!!!!
const SLIME_BULLET = preload("res://Scenes/Towers/Bullets/slime_bullet.tscn")

# NECESSARY VARIABLES!!!
@onready var tower_range: Area2D = $Tower_range
@onready var bullet_container: Node = $Bullet_container
@onready var aim: Marker2D = $Aim
@onready var collision_polygon_2d: CollisionPolygon2D = $CollisionPolygon2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var reload_time: Timer = $ReloadTime
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

@export var reaload_time_ : float = 0.2
@export var cost : int  = -100

var current_targets = []
var focused_target = null
var current_order = GameManager.targeting_order.FIRST

func _ready() -> void:
	reload_time.wait_time = reaload_time_
	
func speed_up_turret():
	reload_time.wait_time = reload_time.wait_time * 0.8
	
func range_upgrade():
	var curr_rad = tower_range.get_child(0).shape.radius
	tower_range.get_child(0).shape.radius = curr_rad * 1.1
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
		audio_stream_player_2d.play()
	
func get_collison_points():
	return 	collision_polygon_2d.polygon
	
func get_sprite():
	return sprite_2d.texture

func _on_tower_menu_area_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("LPM"):
		GameManager.UI_REF._open_upgrading_view(self)
