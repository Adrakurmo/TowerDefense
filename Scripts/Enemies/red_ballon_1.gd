extends CharacterBody2D


@export var speed = 400
@onready var current_path

func _ready() -> void:
	current_path = get_parent()


func _process(delta: float) -> void:
	current_path.set_progress(current_path.get_progress() + speed * delta)
	if current_path.get_progress_ratio() == 1:
		queue_free()
