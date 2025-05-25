extends VBoxContainer

@onready var button: Button = $Button
@onready var label: Label = $Panel/Label

@export var connected_tower : PackedScene = null

const GHOST_TOWER = preload("res://Scenes/Towers/Buildings/ghost_tower.tscn")

func set_icon(newIcon : Texture2D) -> void:
	button.icon = newIcon

func add_ghost_tower(unique_scale = Vector2(1,1)):
	var g_container = get_tree().get_root().find_child("Ghosts", true, false)
	var new_ghost = GHOST_TOWER.instantiate()
	var c_scene = connected_tower.instantiate()
	g_container.add_child(c_scene)
	new_ghost.set_collision(c_scene.get_collison_points())
	new_ghost.late_init_sprite = c_scene.get_sprite()
	c_scene.queue_free()
	new_ghost.position = get_global_mouse_position()
	new_ghost.late_init_scale = unique_scale
	new_ghost.holded_scene = connected_tower
	g_container.add_child(new_ghost)

func set_price_tag() -> void:
	var tmp = connected_tower.instantiate()
	label.text = str(abs(tmp.cost))
	tmp.queue_free()

func _on_button_button_down() -> void:
	if GameManager.player_money - int(label.text) < 0:
		return
		
	add_ghost_tower(Vector2(3,3))
