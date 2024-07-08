extends "res://Generic Code/Neutral/Basic_Unit.gd"

var Veterancy = 0
var Spawn_Time = 0
var ranking_ally
var allies_in_range = []
@export var heal_timer = 0
@export var heal_time = 5
@export var healing_range = 5
var aura_active = false
@export var healing_Strength = 3

func _ready():
	Spawn_Time = Global.total_time
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D3.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D3.material_override = Global.color_arr[1]

func _process(delta):
	if(Global.total_time >= Spawn_Time+30 && Veterancy == 0 && kills >= 1):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 10):
		veterancy_up()
		
	lookat()
	_attack(delta)
	
	if(heal_time < heal_timer):
		healing_aura(aura_active)
		heal_timer = 0
	else:
		heal_timer = heal_timer +1*delta
	promote()
	_death()

func promote():
	if(unitCurrentEnergy >= unitMaxEnergy):
		allies_in_range.clear()
		
		var allies = get_tree().get_nodes_in_group(unitOwner)
		for x in allies.size():
			if(position.distance_to(allies[x].position) < 10):
				allies_in_range.append(allies[x])
				
				pass
		allyUp()

func allyUp():
	ranking_ally = allies_in_range.pick_random()
	if(ranking_ally.Veterancy < 3):
		print_debug(ranking_ally.unitName +" has been promoted")
		ranking_ally.veterancy_up()
		unitCurrentEnergy = 0
	else:
		allyUp()

func healing_aura(active:bool):
	if(active):
		var allies = get_tree().get_nodes_in_group(unitOwner)
		for x in allies.size():
			if(position.distance_to(allies[x].position) < 5):
				if(allies[x].unitCurrentHealth < allies[x].unitMaxHealth):
					allies[x].unitCurrentHealth = allies[x].unitCurrentHealth + healing_Strength

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		unitName = "Union Captain"
		aura_active = true
	if(Veterancy == 2):
		unitName = "Union Major"
		healing_Strength = 6
	if(Veterancy == 3):
		unitName = "Union General"
		healing_range = 7
