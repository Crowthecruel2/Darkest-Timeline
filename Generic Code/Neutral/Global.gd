extends Node
var time:float = 0
var total_time = 0
var color_arr = [load("res://Materials/Player_Colors/Team1.tres"),load("res://Materials/Player_Colors/Team2.tres")]
@onready var spawners = get_tree().get_nodes_in_group("spawner")
var UnitedUnits = ["res://Army/UnitedNetworks/UN_PeaceKeeper.tscn","res://Army/UnitedNetworks/Diplomat.tscn","res://Army/UnitedNetworks/Light Array.tscn"]
var UnionUnits = ["res://Army/Union/Union_Mob_Trooper.tscn","res://Army/Union/Penal Trooper.tscn","res://Army/Union/Union_Officer.tscn","res://Army/Union/Union_Attack_Helicopter.tscn","res://Army/Union/Union_Main_Battle_Tank.tscn"]
var Factions = [UnitedUnits,UnionUnits]
var Faction_Names = ["United Networks","The Union "]
var Faction_Description = ["Ai overlords","Super Russia"]
var total_units = 1000

func _process(delta):
	total_time = total_time + 1*delta
	if(spawners.size() < get_tree().get_nodes_in_group("spawner").size()):
		var spawners = get_tree().get_nodes_in_group("spawner")
	
