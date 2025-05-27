extends Control
class_name UI

@onready var v_box_container: VBoxContainer = $CanvasLayer/Panel/VBoxContainer
@onready var money_label: Label = $CanvasLayer/Money/money_label
@onready var health_label: Label = $CanvasLayer/health_Label
@onready var upgrade_view: Panel = $CanvasLayer/upgrade_view
@onready var upgrade_sprite: Sprite2D = $CanvasLayer/upgrade_view/main_vbox/Panel/Sprite2D
@onready var panel: Panel = $CanvasLayer/Panel
@onready var button: Button = $CanvasLayer/Button

var _connected_tower : Object

const SHOP_ITEM = preload("res://Scenes/Shop/shop_item.tscn")
const SLIME_DESTROYER = preload("res://Scenes/Towers/Buildings/slime_destroyer.tscn")
const FLAMETHROWER = preload("res://Scenes/Towers/Buildings/flamethrower.tscn")
const TOWER_1 = preload("res://Assets/Towers/Tower1.png")
const TOWER_II = preload("res://Assets/Towers/Tower II.png")
const ROSE = preload("res://Scenes/Towers/Buildings/rose.tscn")
const TOWER_III = preload("res://Assets/Towers/TowerIII.png")

func _ready() -> void:
	GameManager.UI_REF = self
	SignalManager.money_changed.connect(_on_money_changed)
	SignalManager.health_changed.connect(_on_health_changed)
	SignalManager.level_finished.connect(coscos)
	_load_shop()
	_on_money_changed()
	_on_health_changed()
	
func coscos():
	button.visible = true

func _load_shop() -> void:
	_load_tower(TOWER_III, ROSE)
	_load_tower(TOWER_1, SLIME_DESTROYER)
	_load_tower(TOWER_II, FLAMETHROWER)
	
func _load_tower(txt : Texture2D, tower_scene : PackedScene) -> void:
	var tmp = SHOP_ITEM.instantiate()
	v_box_container.add_child(tmp)
	tmp.connected_tower = tower_scene
	tmp.set_price_tag()
	tmp.set_icon(txt)


func _on_money_changed() -> void:
	money_label.text = str(GameManager.player_money)
	
func _on_health_changed() -> void:
	health_label.text = str(GameManager.player_health)

	
func _close_upgrading_view() -> void:
	upgrade_view.visible = false
	_connected_tower = null
	
func _open_upgrading_view(new_obj : Object) -> void:
	upgrade_view.visible = true
	upgrade_sprite.texture = new_obj.get_sprite()
	_connected_tower = new_obj
	
	
func _on_close_button_down() -> void:
	_close_upgrading_view()

func _on_speed_button_down() -> void:
	if _connected_tower:
		_connected_tower.speed_up_turret()

func _on_dmg_button_down() -> void:
	pass # Replace with function body.

func _on_range_button_down() -> void:
	if _connected_tower:
		_connected_tower.range_upgrade()


func _on_exit_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")


func _on_shoppp_pressed() -> void:
	panel.visible = !panel.visible


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
	button.visible = false
