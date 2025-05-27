extends Node

const BLUE_SLIME = preload("res://Scenes/Enemies/blue_slime.tscn")
const RED_SLIME = preload("res://Scenes/Enemies/red_slime.tscn")
const PATH_LVL_1 = preload("res://Scenes/paths/path_lvl_1.tscn")
const PATH_LVL_2 = preload("res://Scenes/paths/path_lvl_2.tscn")

var level_1 : Level
var level_2 : Level

#Each level = 10 waves

func _ready() -> void:
	set_levels()

func set_levels() -> void:
	level_1 = Level.new(get_waves(1))
	level_2 = Level.new(get_waves(2))
	
func get_waves(wave_number : int) -> Array[Wave]:
	match wave_number:
		1:
			return [
			Wave.new({BLUE_SLIME : 10}),
			Wave.new({BLUE_SLIME : 2}),
			Wave.new({BLUE_SLIME : 14}),
			Wave.new({BLUE_SLIME : 16}),
			Wave.new({BLUE_SLIME : 18}),
			Wave.new({BLUE_SLIME : 20, RED_SLIME : 10}),
			Wave.new({BLUE_SLIME : 15, RED_SLIME : 20}),
			Wave.new({BLUE_SLIME : 10, RED_SLIME : 30}),
			Wave.new({BLUE_SLIME : 0, RED_SLIME : 40}),
			Wave.new({BLUE_SLIME : 0, RED_SLIME : 55})
			]
		2:
			return [
			Wave.new({BLUE_SLIME : 2, RED_SLIME : 1}),
			Wave.new({BLUE_SLIME : 15, RED_SLIME : 20}),
			Wave.new({BLUE_SLIME : 10, RED_SLIME : 30}),
			Wave.new({BLUE_SLIME : 0, RED_SLIME : 40}),
			Wave.new({BLUE_SLIME : 0, RED_SLIME : 55})
			]
		_:
			return []
			
	return []
		
# [BLUE_SLIME, RED_SLIME] [20, 40] { BLUE_SLIME : 20 and RED_SLIME : 40 }
func get_wave_dict(enemies : Array[PackedScene], amount_oe : Array[int]) -> Dictionary:
	var new_dict : Dictionary = {}
	for i in range(enemies.size()):
		new_dict[enemies[i]] = amount_oe[i]
	
	return new_dict
	
