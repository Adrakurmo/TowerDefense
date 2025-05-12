extends CharacterBody2D


# NECESSARY VARIABLES
@export var speed = 700
@export var worth = 20

@onready var current_path
@onready var health : float = 100
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var healthbar: ProgressBar = $Healthbar

var CONST_HEALTH : float = 100

func _ready() -> void:
	current_path = get_parent()

func _process(delta: float) -> void:
	BEB.set_route_progress(current_path, speed, delta, self)

func apply_damage(dmg):
	health = BEB.set_health_and_apply_damage(dmg, health, CONST_HEALTH, self, sprite_2d)
	healthbar.set_healthbar((health / CONST_HEALTH) * 100)
