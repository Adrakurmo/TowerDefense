extends "res://Scripts/Enemies/blue_slime.gd"

func _ready() -> void:
	current_path = get_parent()
	worth = 40

func _process(delta: float) -> void:
	BEB.set_route_progress(current_path, speed, delta, self)

func boost(duration: float):
	speed = 900
	await get_tree().create_timer(duration).timeout
	speed = 700
	
func apply_damage(dmg):
	health = BEB.set_health_and_apply_damage(dmg, health, CONST_HEALTH, self, sprite_2d)
	healthbar.set_healthbar((health / CONST_HEALTH) * 100)
	boost(1)
