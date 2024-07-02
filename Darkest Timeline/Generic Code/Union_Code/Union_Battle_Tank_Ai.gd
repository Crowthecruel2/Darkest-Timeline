extends "res://Generic Code/Basic_Unit.gd"

var Veterancy = 0
var Spawn_Time = 0

func _ready():
	Spawn_Time = Global.total_time
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[1]

func _process(delta):
	if(Global.total_time >= Spawn_Time+30 && Veterancy == 0 && kills >= 1):
		Veterancy = Veterancy + 1
		
	if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
		Veterancy = Veterancy + 1
		
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 10):
		Veterancy = Veterancy + 1
		
	lookat()
	_attack(delta)
	_death()
