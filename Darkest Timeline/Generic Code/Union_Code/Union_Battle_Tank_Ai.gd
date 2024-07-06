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
		veterancy_up()
	if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
		veterancy_up()
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 5):
		veterancy_up()
	
	lookat()
	_attack(delta)
	_death()

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		unitName = "Restored Union Battle Tank"
		unitMaxHealth = 150
		moveSpeed = 3
	if(Veterancy == 2):
		unitName = "Prestine Union Battle Tank"
		attackSpeed = 2
	if(Veterancy == 3):
		unitName = "Improved Union Battke Tank"
		attackSpeed = 1
