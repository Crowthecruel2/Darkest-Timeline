extends "res://Generic Code/Neutral/Basic_Unit.gd"

@export var explosionDamage:int
@export var explosionParticle:CPUParticles3D
var Veterancy = 0
var Spawn_Time = 0
var landmines = false
var exploding = false
func _ready():
	Spawn_Time = Global.total_time
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D2.material_override = Global.color_arr[0]
		$CollisionShape3D/MeshInstance3D4.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D2.material_override = Global.color_arr[1]
		$CollisionShape3D/MeshInstance3D4.material_override = Global.color_arr[1]

func _process(delta):
	
	
	if(!exploding):
		if(Global.total_time >= Spawn_Time+30 && Veterancy == 0 && kills >= 1):
			veterancy_up()
		if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
			veterancy_up()
		if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 5):
			veterancy_up()
		lookat()
		_attack(delta)
		_deploy_landmine(landmines)
	_explode()

func _explode():
	if(unitCurrentHealth < 0):
		
		var everyone = get_tree().get_nodes_in_group("team1")
		everyone.append_array(get_tree().get_nodes_in_group("team2"))
		for x in everyone.size():
			if(self.position.distance_to(everyone[x].position) < 5):
				var damage = (explosionDamage - (everyone[x].unitArmor + everyone[x].unitMagicArmor))
				if(damage < 0):
					damage = 0
				everyone[x].unitCurrentHealth = everyone[x].unitCurrentHealth - damage
				if(everyone[x].unitCurrentHealth < 0):
					kills = kills +1
		exploding = true
		xplode_death()
		
		

func xplode_death():
	explosionParticle.emitting = true
	if(explosionParticle.finished):
		self.get_child(0).visible = false
		moveSpeed = 0
		explosionDamage = 0
		unitDamage = 0
		bonusDamage = 0
		remove_from_group(unitOwner)
		await get_tree().create_timer(4).timeout
		
		self.queue_free()

func _deploy_landmine(landmines):
	if(unitCurrentEnergy == unitMaxEnergy && landmines == true):
		unitCurrentEnergy = 0
		var landmine_spawn = preload("res://Buildings/Union/landmine.tscn")
		var new_unit = landmine_spawn.instantiate()
		self.add_child(new_unit)
		new_unit.unitOwner = unitOwner
		new_unit.position = position
		

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		unitName = "Union Penal RocketTrooper"
		attackRange = 15
		unitDamage = 10
		unitHealthRegeneration = 3
		unitMaxHealth = 40
	if(Veterancy == 2):
		unitName = "Union Penal AT Specialist"
		attackRange = 13
		unitDamage = 10
		unitHealthRegeneration = 5
		unitMaxHealth = 50
	if(Veterancy == 3):
		pass
