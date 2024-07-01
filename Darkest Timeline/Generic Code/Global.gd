extends Node
var time:float = 10
var total_time = 0
var color_arr = [load("res://Materials/Player_Colors/Team1.tres"),load("res://Materials/Player_Colors/Team2.tres")]
var spawn_timer: int = 30
var income = 1

func _process(delta):
	total_time = total_time + 1*delta
	time = time + 1*delta
	if(time >= spawn_timer):
		get_tree().call_group("spawner", "spawn")
		time = 0
