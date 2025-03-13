extends CharacterBody2D

@export var speed = 400
@onready var current_path
@onready var health = 20

func _ready() -> void:
	current_path = get_parent()

func _process(delta: float) -> void:
	current_path.set_progress(current_path.get_progress() + speed * delta)
	if current_path.get_progress_ratio() == 1:
		queue_free()

#Zwykła metoda z odejmowaniem życia, jedyna ciekawa rzecz tutaj to dostajemy się
# wsmie do dziadka jeżeli hp <= 0 i go usuwamy, dzięki temu cała ściażka zostanie usunięta, a nie tylko ten cel
func apply_damage(dmg):
	health -= dmg
	if health <= 0:
		get_parent().get_parent().queue_free()
