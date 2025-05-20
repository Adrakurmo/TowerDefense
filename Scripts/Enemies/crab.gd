extends "res://Scripts/Enemies/blue_slime.gd"



func _ready() -> void:
	current_path = get_parent()
	CONST_HEALTH = 200;
	speed = 400;
	worth = 80

func _process(delta: float) -> void:
	BEB.set_route_progress(current_path, speed, delta, self)

func apply_damage(dmg):
	health = BEB.set_health_and_apply_damage(dmg, health, CONST_HEALTH, self, sprite_2d)
	healthbar.set_healthbar((health / CONST_HEALTH) * 100)
