extends Control

@onready var l_2: Button = $VBoxContainer/l2

func _ready() -> void:
	SignalManager.new_level_unlocked.connect(check_new_levels)
	if not GameManager.loaded:
		GameManager.load_save()
		GameManager.loaded = true
		
	check_new_levels()

func check_new_levels() -> void:
	l_2.visible = true if LevelManager.level_2_unlocked else false

func reset_stats():
	GameManager.player_money = 300
	GameManager.player_health = 10

func _on_quit_pressed() -> void:
	GameManager.save_game()
	get_tree().quit()


func _on_start_pressed() -> void:
	reset_stats()
	get_tree().change_scene_to_file("res://Scenes/poziomy/lvl_1.tscn")


func _on_l_1_pressed() -> void:
	reset_stats()
	get_tree().change_scene_to_file("res://Scenes/poziomy/lvl_1.tscn")


func _on_l_2_pressed() -> void:
	reset_stats()
	get_tree().change_scene_to_file("res://Scenes/poziomy/lvl_2.tscn")


func _on_clear_save_pressed() -> void:
	GameManager.clear_save()
	check_new_levels()
