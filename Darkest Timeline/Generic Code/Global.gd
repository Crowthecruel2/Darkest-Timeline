extends Node
var time:float = 20
var time_income = 0
var total_time = 0
var color_arr = [load("res://Materials/Player_Colors/Team1.tres"),load("res://Materials/Player_Colors/Team2.tres")]
var spawn_timer: int = 30
var income_timer: int = 5
var income = 1
var team_incomes = [0,0]
@onready var spawners = get_tree().get_nodes_in_group("spawner")
var UnionUnits = ["res://Army/Union/Penal Trooper.tscn","res://Army/Union/Union_Main_Battle_Tank.tscn","res://Army/Union/Union_Mob_Trooper.tscn"]

func _process(delta):
	
	if(spawners.size() < get_tree().get_nodes_in_group("spawner").size()):
		var spawners = get_tree().get_nodes_in_group("spawner")
	
	total_time = total_time + 1*delta
	time = time + 1*delta
	if(time >= spawn_timer):
		get_tree().call_group("spawner", "spawn")
		time = 0
	time_income = time_income +1*delta
	if(time_income >= income_timer):
		for s in spawners.size():
			team_incomes[s] = team_incomes[s] + 10
			spawners[s].metal = spawners[s].metal +team_incomes[s]
			print_debug(spawners[s].metal)
		time_income = 0
