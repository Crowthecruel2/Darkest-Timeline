extends Node3D
var grid = []
var grid_x = 15
var grid_y = 5
var metal = 100
var spawn_time
var chooseUnit
var units = Global.Factions.pick_random()
var random_unit_counter = 0
var UIs
var UI
var income_metal = 0
var random_counter = 0
@export var team:String
@export var AiControlled:bool

# Called when the node enters the scene tree for the first time.
func _ready():
	UIs = get_tree().get_nodes_in_group("UI")
	for u in UIs.size():
		if(UIs[u]).playerTeam == team:
			UI = UIs[u]
	spawn_time = Global.total_time
	for x in grid_x:
		for y in grid_y:
			grid.append("res://Army/Empty/Empty_self_deleter.tscn")
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if(Global.total_time > spawn_time+30):
		spawn()
		spawn_time = Global.total_time

func spawn():
	if(AiControlled):
		random_counter = randi_range(0,units.size()-1)
		add_random_unit_AI(random_counter)
	
	if(get_tree().get_nodes_in_group(team).size() < Global.total_units/2):
		for x in grid_x:
			for y in grid_y:
				var newUnit = load(grid[(y*15) + x])
				if newUnit != preload("res://Army/Empty/Empty_self_deleter.tscn"):
					
					newUnit = load(grid[(y*15) + x]).instantiate()
					newUnit.unitOwner = team
					newUnit.position = self.global_transform.origin + Vector3(x*5,2,y*5)
					get_parent().add_child(newUnit)
	income()

func income():
	income_metal = 0
	for x in 15:
		for y in 5:
			var unit_count = (load(grid[(y*15) + x])).instantiate()
			income_metal = income_metal + unit_count.unitIncome
			unit_count.queue_free()
	metal = metal + income_metal
	print_debug(metal)

func select_unit(unit_num):
	chooseUnit = units[unit_num]
	UI.GridGrid.get_parent().visible = true

func add_spesific_unit(pos_x,pos_y):
	var chooseUnitCheck = load(chooseUnit).instantiate()
	var gridUnit = load(grid[(pos_y*15) + pos_x]).instantiate()
	if(metal >= chooseUnitCheck.unitCost):
		
		if(gridUnit == load("res://Army/Empty/Empty_self_deleter.tscn")):
			grid[(pos_y*15) + pos_x] = chooseUnit
			UI.gridButtons[(pos_y*15) + pos_x].icon = load("res://UI/red.png")
			UI.gridButtons[(pos_y*15) + pos_x].tooltip_text = str(chooseUnitCheck.unitName) + "\n Sell Value: "+ str(chooseUnitCheck.unitCost/2)
			UI.gridButtons[(pos_y*15) + pos_x].text = ""
			metal = metal - chooseUnitCheck.unitCost
			chooseUnitCheck.queue_free()
		if(gridUnit != load("res://Army/Empty/Empty_self_deleter.tscn")):
			
			metal = metal + (gridUnit.unitCost/2)
			grid[(pos_y*15) + pos_x] = chooseUnit
			UI.gridButtons[(pos_y*15) + pos_x].icon = load("res://UI/red.png")
			UI.gridButtons[(pos_y*15) + pos_x].tooltip_text = str(chooseUnitCheck.unitName) + "\n Sell Value: "+ str(chooseUnitCheck.unitCost/2)
			UI.gridButtons[(pos_y*15) + pos_x].text = ""
			metal = metal - chooseUnitCheck.unitCost
			chooseUnitCheck.queue_free()
	else:
		chooseUnitCheck.queue_free()
	if(!Input.is_action_pressed("Queue_Commands")):
		UI.GridGrid.get_parent().visible = false
	
	gridUnit.queue_free()

func set_faction(faction):
	units = Global.Factions[faction]
	for u in UI.facCon.get_children().size():
		UI.facCon.get_child(u).disabled = true
	UI.facCon.visible = false
	UI.unitCon.visible = true
	UI.update_unit_array()

func add_random_unit_AI(random_counter):
	var chooseUnit = units[random_counter]
	var chooseUnitCheck = load(chooseUnit).instantiate()
	if(metal >= chooseUnitCheck.unitCost):
		var randx = randi_range(0,grid_x-1)
		var randy = randi_range(0,grid_y-1)
		if(load(grid[(randy*15) + randx]) == preload("res://Army/Empty/Empty_self_deleter.tscn")):
			grid[(randy*15) + randx] = chooseUnit
			metal = metal - chooseUnitCheck.unitCost
			chooseUnitCheck.queue_free()
		if(load(grid[(randy*15) + randx]) != load("res://Army/Empty/Empty_self_deleter.tscn") && random_unit_counter < 10):
			random_unit_counter = random_unit_counter + 1
			chooseUnitCheck.queue_free()
			add_random_unit_AI(random_counter)
		else:
			grid[(randy*15) + randx] = chooseUnit
			metal = metal - chooseUnitCheck.unitCost
			random_unit_counter = 0
	else:
		if(chooseUnit != units[0]):
			random_counter = random_counter - 1
			add_random_unit_AI(random_counter)
	chooseUnitCheck.queue_free()
