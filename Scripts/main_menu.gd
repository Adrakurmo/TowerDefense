extends Control

@onready var l_2: Button = $VBoxContainer/l2


func _ready() -> void:
	SignalManager.level_2_unlocked.connect(unlock_second_lvl)

func reset_stats():
	GameManager.player_money = 300
	GameManager.player_health = 10

func unlock_second_lvl() -> void:
	l_2.visible = true

func _on_quit_pressed() -> void:
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
