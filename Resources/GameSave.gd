extends Resource
class_name GameSave

@export var l1_unl: bool = true
@export var l2_unl: bool = false

func _init(l1_unl : bool = true, l2_unl : bool = false) -> void:
	self.l1_unl = l1_unl
	self.l2_unl = l2_unl
