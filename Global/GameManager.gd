extends Node

enum targeting_order { FIRST, LAST, MIDDLE }

var CURRENT_GAME_REF : GameSave
var player_money = 300
var player_health = 10
var UI_REF : UI = null
var loaded = false

func _ready() -> void:
	Engine.max_fps = 200

func update_money(value : int) -> void:
	player_money += value
	SignalManager.money_changed.emit()

func change_health(value : int) -> void:
	player_health += value
	SignalManager.health_changed.emit()
	if player_health <= 0:
		SignalManager.level_finished.emit()

func load_save() -> void:
	var save_path = "res://Saves/tmp.tres"
	var loaded = load(save_path)
	
	if loaded is GameSave:
		CURRENT_GAME_REF = loaded.duplicate(true) as GameSave
		print(CURRENT_GAME_REF)
		LevelManager.level_1_unlocked = CURRENT_GAME_REF.l1_unl
		LevelManager.level_2_unlocked = CURRENT_GAME_REF.l2_unl
		print("===LOADED===")
	else:
		print("Nie udało się załadować save'a. Tworzenie nowego.")
		CURRENT_GAME_REF = GameSave.new(true, false)

func clear_save() -> void:
	CURRENT_GAME_REF = GameSave.new()
	LevelManager.clear_unlocked_levels()
	save_game()
	
func save_game() -> void:
	ResourceSaver.save(CURRENT_GAME_REF, "res://Saves/tmp.tres")
