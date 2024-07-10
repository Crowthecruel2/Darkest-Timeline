extends Node
var time:float = 0
var time_income = 0
var total_time = 0
var color_arr = [load("res://Materials/Player_Colors/Team1.tres"),load("res://Materials/Player_Colors/Team2.tres")]
var income_timer = 0
var team_incomes = [0,0]
var total_units = 200
var spawn_Counter = 0
var spawned = false

@onready var spawners = get_tree().get_nodes_in_group("spawner")
var UnitedUnits = ["res://Army/UnitedNetworks/UN_PeaceKeeper.tscn","res://Army/UnitedNetworks/Diplomat.tscn"]
var UnionUnits = ["res://Army/Union/Penal Trooper.tscn","res://Army/Union/Union_Mob_Trooper.tscn","res://Army/Union/Union_Main_Battle_Tank.tscn","res://Army/Union/Union_Officer.tscn","res://Army/Union/Union_Attack_Helicopter.tscn"]
var Factions = [UnitedUnits,UnionUnits]
var Faction_Names = ["United Networks","The Union"]


func _process(delta):
	total_time = total_time + 1*delta
	if(spawners.size() < get_tree().get_nodes_in_group("spawner").size()):
		var spawners = get_tree().get_nodes_in_group("spawner")
	
	
	
