extends "res://Generic Code/Neutral/Basic_Unit.gd"


func _ready():
	body.append($CollisionShape3D/MeshInstance3D)
	_set_body_color()

func _process(delta):
	_death()
	lookat()
	_attack(delta)
