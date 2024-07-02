extends Node3D
var grid = []
var grid_x = 15
var grid_y = 5
var metal = 100
var random_unit_counter = 0
@export var team:String

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in grid_x:
		grid.append([])
		for y in grid_y:
			grid[x].append("res://Army/Empty/Empty_self_deleter.tscn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn():
	add_random_unit_AI()
	
	if(get_tree().get_nodes_in_group(team).size() < Global.total_units):
		for x in grid_x:
			for y in grid_y:
				var newUnit = load(grid[x][y])
				if newUnit != preload("res://Army/Empty/Empty_self_deleter.tscn"):
					
					newUnit = load(grid[x][y]).instantiate()
					newUnit.unitOwner = team
					newUnit.position = self.global_transform.origin + Vector3(x*5,2,y*5)
					get_parent().add_child(newUnit)
	
				
				

func add_random_unit_AI():
	var chooseUnit = Global.UnionUnits.pick_random()
	var chooseUnitCheck = load(chooseUnit).instantiate()
	if(metal > chooseUnitCheck.unitCost):
		var randx = randi_range(0,grid_x-1)
		var randy = randi_range(0,grid_y-1)
		if(load(grid[randx][randy]) == preload("res://Army/Empty/Empty_self_deleter.tscn")):
			grid[randx][randy] = chooseUnit
			metal = metal - chooseUnitCheck.unitCost
			chooseUnitCheck.queue_free()
			add_random_unit_AI()
		if(load(grid[randx][randy]) != load("res://Army/Empty/Empty_self_deleter.tscn") && random_unit_counter < 10):
			random_unit_counter = random_unit_counter + 1
			chooseUnitCheck.queue_free()
			add_random_unit_AI()
		else:
			random_unit_counter = 0
	else:
		chooseUnitCheck.queue_free()
	
