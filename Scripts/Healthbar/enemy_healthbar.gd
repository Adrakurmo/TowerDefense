extends ProgressBar

@onready var healthbar: ProgressBar = $"."
@onready var damagebar: ProgressBar = $Damagebar
@onready var combo: Timer = $combo

func _ready() -> void:
	damagebar.value = 100
	healthbar.value = 100

func set_healthbar(new_value):
	healthbar.value = new_value
	combo.start()


func _on_combo_timeout() -> void:
	damagebar.value = healthbar.value
