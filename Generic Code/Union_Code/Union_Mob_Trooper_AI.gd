extends "res://Generic Code/Neutral/Basic_Unit.gd"
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
		
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 10):
		veterancy_up()
		
	lookat()
	_attack(delta)
	_death()

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		unitName = "Union Mob Rifleman"
		attackRange = 10
		unitDamage = 6
		unitHealthRegeneration = 2
		unitMaxHealth = 20
		canHitAir = true
	if(Veterancy == 2):
		unitName = "Union Mob MachineGunner"
		attackRange = 12
		unitDamage = 4
		unitHealthRegeneration = 2
		unitMaxHealth = 30
		attackSpeed = 1
	if(Veterancy == 3):
		unitName = "Union Commando"
		attackRange = 12
		unitDamage = 10
		unitHealthRegeneration = 5
		unitMaxHealth = 100
		attackSpeed = 1.5
