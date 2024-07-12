extends Control
@onready var playerTeam = self.get_parent().team
@onready var spawners = get_tree().get_nodes_in_group("spawner")
@onready var unitCon = $Panel/UnitContainer
@onready var facCon = $Panel/FactionContainer
@onready var metal_label = $Panel/Label
@onready var Income_Label = $Panel/Income_Label
@onready var GridGrid = $Panel/Panel/GridContainer
var gridButtons = []
var unit_locked = false
var spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	unitCon.visible = false
	for s in spawners.size():
		if(spawners[s].team == playerTeam):
			spawner = spawners[s]
	
	for f in Global.Factions.size():
		var newButton = Button.new()
		facCon.add_child(newButton)
		newButton.text = Global.Faction_Names[f]
		newButton.tooltip_text = Global.Faction_Description[f]
		newButton.pressed.connect(spawner.set_faction.bind(f))
	
	for y in spawner.grid_y:
		for x in spawner.grid_x:
			var newButton = Button.new()
			GridGrid.add_child(newButton)
			newButton.text = "{"+str(x+1)+","+str(y+1)+"}"
			newButton.pressed.connect(spawner.add_spesific_unit.bind(x,y))
			gridButtons.append(newButton)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if(spawner != null):
		metal_label.text = "Metal: " + str(spawner.metal)
		Income_Label.text = "Income: " + str(spawner.income_metal)
	pass

func update_unit_array():
	if(unitCon.visible == true):
		unitCon.columns = 5
		print_debug(spawner.units.size())
		for u in spawner.units.size():
			var newButton = Button.new()
			unitCon.add_child(newButton)
			var temp_Unit = load(spawner.units[u]).instantiate()
			newButton.text = temp_Unit.unitName + " " + str(temp_Unit.unitCost)
			newButton.tooltip_text = "Unit Name: " + str(temp_Unit.unitName) + "\n" + "Unit Cost: " + str(temp_Unit.unitCost) + "\n" + "Unit Income: " + str(temp_Unit.unitIncome) + "\n" + "Unit Types: " + str(temp_Unit.unitTypes)+ "\n" + "Unit Range: " + str(temp_Unit.attackRange)+ "\n" + "Unit Damage: " + str(temp_Unit.unitDamage)+ "\n" + "Unit Description: " + str(temp_Unit.unitDesc)
			temp_Unit.queue_free()
			newButton.pressed.connect(spawner.select_unit.bind(u))
		unit_locked == true
