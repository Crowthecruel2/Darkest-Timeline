extends "res://Generic Code/Neutral/Basic_Unit.gd"


func _ready():
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[1]

func _process(delta):
	_death()
	lookat()
	_attack(delta)
