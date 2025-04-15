extends Control

const SLIME_DESTROYER = preload("res://Scenes/Towers/Buildings/slime_destroyer.tscn")
const GHOST_TOWER = preload("res://Scenes/Towers/Buildings/ghost_tower.tscn")

@onready var buy_slimedestr: Button = $CanvasLayer/buy_slimedestr


func _on_buy_slimedestr_pressed() -> void:
	add_ghost_tower(SLIME_DESTROYER, Vector2(3,3))
	
func add_ghost_tower(scene : PackedScene, unique_scale = Vector2(1,1)):
	var g_container = get_tree().get_root().find_child("Ghosts", true, false)
	var new_ghost = GHOST_TOWER.instantiate()
	var c_scene = scene.instantiate()
	g_container.add_child(c_scene)
	new_ghost.set_collision(c_scene.get_collison_points())
	new_ghost.late_init_sprite = c_scene.get_sprite()
	c_scene.queue_free()
	new_ghost.position = get_global_mouse_position()
	new_ghost.late_init_scale = unique_scale
	g_container.add_child(new_ghost)
	new_ghost.holded_scene = scene
	
