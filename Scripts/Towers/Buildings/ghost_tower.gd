extends Sprite2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var interaction_area: Area2D = $interaction_area

var late_init_collision
@export var late_init_sprite : CompressedTexture2D
@export var late_init_scale : Vector2
@export var holded_scene : PackedScene

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("RPM") or Input.is_action_just_pressed("ui_cancel"):
		queue_free()
	
	position = get_global_mouse_position()
	if can_build():
		sprite_2d.modulate = Color.GREEN
		if Input.is_action_just_pressed("LPM"):
			var new_tower = holded_scene.instantiate()
			new_tower.global_position = get_global_mouse_position()
			get_tree().get_root().find_child("Towers", true, false).add_child(new_tower)
			queue_free()
	else:
		sprite_2d.modulate = Color.RED
		

	
	
func can_build():
	for area in interaction_area.get_overlapping_areas():
		if area.name == "cannot_build":
			return false
	for body in interaction_area.get_overlapping_bodies():
		return false
	return true

func _ready() -> void:
	sprite_2d.texture = late_init_sprite
	interaction_area.add_child(late_init_collision)
	sprite_2d.scale = late_init_scale

func set_collision(new_points):
	var collison = CollisionPolygon2D.new()
	collison.polygon = new_points
	collison.global_position = Vector2.ZERO
	late_init_collision = collison
	
