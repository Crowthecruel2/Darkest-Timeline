extends Node3D
var grid = []
var grid_x = 15
var grid_y = 7
@export var team:String

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in grid_x:
		grid.append([])
		for y in grid_y:
			grid[x].append(load("res://Army/Empty/Empty_self_deleter.tscn"))
	
	grid[1][1] = preload("res://Army/Union/Union_Mob_Trooper.tscn")
	grid[2][1] = preload("res://Army/Union/Union_Mob_Trooper.tscn")
	grid[3][1] = preload("res://Army/Union/Union_Mob_Trooper.tscn")
	grid[4][1] = preload("res://Army/Union/Union_Mob_Trooper.tscn")
	grid[5][1] = preload("res://Army/Union/Union_Mob_Trooper.tscn")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	for x in grid_x:
		for y in grid_y:
			var newUnit = grid[x][y]
			if newUnit != load("res://Army/Empty/Empty_self_deleter.tscn"):
				
				newUnit = grid[x][y].instantiate()
				newUnit.unitOwner = team
				newUnit.position = self.global_transform.origin + Vector3(x*2,2,y*2)
				get_parent().add_child(newUnit)
				
				
