extends "res://Generic Code/Basic_Unit.gd"

var Veterancy = 0
var Spawn_Time = 0
@onready var blade = $CollisionShape3D/MeshInstance3D5

func _ready():
	Spawn_Time = Global.total_time
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D3.material_override = Global.color_arr[0]
		$CollisionShape3D/MeshInstance3D6.material_override = Global.color_arr[0]
		$CollisionShape3D/MeshInstance3D7.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D3.material_override = Global.color_arr[1]
		$CollisionShape3D/MeshInstance3D6.material_override = Global.color_arr[1]
		$CollisionShape3D/MeshInstance3D7.material_override = Global.color_arr[1]

func _process(delta):
	if(Global.total_time >= Spawn_Time+30 && Veterancy == 0 && kills >= 1):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 10):
		veterancy_up()
		
	blade.rotate(Vector3(0,1,0),20.1)
	lookat()
	_attack(delta)
	_death()

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		pass
	if(Veterancy == 2):
		pass
	if(Veterancy == 3):
		pass
