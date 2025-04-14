extends CharacterBody2D


# NECESSARY VARIABLES
@export var speed = 700
@onready var current_path
@onready var health : float = 100
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var healthbar: ProgressBar = $Healthbar

var CONST_HEALTH : float = 100

func _ready() -> void:
	current_path = get_parent()

func _process(delta: float) -> void:
	BEB.set_route_progress(current_path, speed, delta, self)
	
	#Aktualne problemy:
	#Działa ale dość dziwnie
	#czasami pasek pojawia się zbyt nisko lub zbyt wysoko
	#w jednym momencie trasy z jakiegoś powodu pasek pojawia się ponieżej przeciwnika
	
	#jeszcze tlumacze skad wartosci -135 i -212 przy wyliczaniu wspolrzednych
	#sa to domyslne wspolrzedne X i Y paska zdrowia
	
	#wyliczanie pozycji Y dla paska
	if int(self.global_rotation*100) != 0 && int(self.global_rotation*100) != 1:
		if self.global_rotation*100 <= 95 && self.global_rotation*100 >= -95:
			healthbar.position.y = -222 + (222/abs(int(self.global_rotation*100)))
		else:
			healthbar.position.y = 222 - (222/(180-abs(int(self.global_rotation*100))))
	else:
		healthbar.position.y = -222
	
	#wyliczanie pozycji X dla paska
	if self.global_rotation*100 <= 90 && self.global_rotation*100 >= 0:
		healthbar.position.x = -135 - (abs(int(self.global_rotation*100))*2)
	elif self.global_rotation*100 <= 180 && self.global_rotation*100 >= 90:
		healthbar.position.x = -135 - ((180 - abs(int(self.global_rotation*100)))*2)
	elif self.global_rotation*100 <= 0 && self.global_rotation*100 >= -90:
		healthbar.position.x = -135 + (abs(int(self.global_rotation*100))*2)
	elif self.global_rotation*100 <= -90 && self.global_rotation*100 >= -180:
		healthbar.position.x = -135 + ((180 - abs(int(self.global_rotation*100)))*2)
		
	#rotacja paskiem
	healthbar.rotation = -self.global_rotation

func apply_damage(dmg):
	health = BEB.set_health_and_apply_damage(dmg, health, CONST_HEALTH, self, sprite_2d)
	healthbar.set_healthbar((health / CONST_HEALTH) * 100)
