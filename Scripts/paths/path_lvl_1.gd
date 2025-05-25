extends Path2D

@onready var path_follow_2d: PathFollow2D = $PathFollow2D

func add_enemy_on_path(new_enemy):
	var new_enemy_inst = new_enemy.instantiate()
	path_follow_2d.add_child(new_enemy_inst)
	
