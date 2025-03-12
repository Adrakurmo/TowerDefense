extends Node2D

const PATH_LVL_1 = preload("res://Scenes/paths/path_lvl_1.tscn")


func _on_spawn_cooldown_timeout() -> void:
	var path_inst = PATH_LVL_1.instantiate()
	add_child(path_inst)
