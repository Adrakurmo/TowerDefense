extends Node2D

@onready var wave_cd: Timer = $wave_CD

@export var current_wave : int = -1

func _on_spawn_cooldown_timeout() -> void:
	if !wave_cd.is_stopped():
		return
		
	var path_inst = LevelManager.PATH_LVL_1.instantiate()
	add_child(path_inst)
	
	for i in range(LevelManager.level_1.waves.size()):
		var wave = LevelManager.level_1.waves[i]
		for key : PackedScene in wave.enemies.keys():
			if wave.enemies[key] <= 0:
				continue
			path_inst.add_enemy_on_path(key)
			wave.enemies[key] -= 1
			return
		if i > current_wave:
			current_wave = i
			wave_cd.start()
			return
			
	

	
