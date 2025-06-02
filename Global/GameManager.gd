extends Node

enum targeting_order { FIRST, LAST, MIDDLE }

var player_money = 300
var player_health = 10
var UI_REF : UI = null

func update_money(value : int) -> void:
	player_money += value
	SignalManager.money_changed.emit()

func change_health(value : int) -> void:
	player_health += value
	SignalManager.health_changed.emit()
	if player_health <= 0:
		SignalManager.level_finished.emit()
		
func _ready() -> void:
	Engine.max_fps = 200
