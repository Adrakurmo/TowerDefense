extends Node2D

const PATH_LVL_1 = preload("res://Scenes/paths/path_lvl_1.tscn")
const BLUE_SLIME = preload("res://Scenes/Enemies/blue_slime.tscn")
const RED_SLIME = preload("res://Scenes/Enemies/red_slime.tscn")

var red_one = 1;

func _on_spawn_cooldown_timeout() -> void:
	var path_inst = PATH_LVL_1.instantiate()
	add_child(path_inst)
	if (red_one % 3 == 0):
		path_inst.add_enemy_on_path(RED_SLIME)
		red_one = 0
	else:
		path_inst.add_enemy_on_path(BLUE_SLIME)
	red_one+=1
	
#func _process(delta: float) -> void:
	#if Input.is_action_just_pressed("ui_cancel"):
		#get_tree().paused = not get_tree().paused
