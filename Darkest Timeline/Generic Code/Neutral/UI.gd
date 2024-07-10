extends Control
@onready var playerTeam = self.get_parent().team
@onready var spawners = get_tree().get_nodes_in_group("spawner")
@onready var unitCon = $Panel/Label/UnitContainer
@onready var facCon = $Panel/Label/FactionContainer
var spawner

# Called when the node enters the scene tree for the first time.
func _ready():
	for s in spawners.size():
		if(spawners[s].team == playerTeam):
			spawner = spawners[s]
	
	for f in Global.Factions.size():
		var newButton = Button.new()
		facCon.add_child(newButton)
		newButton.text = Global.Faction_Names[f]
		newButton.pressed.connect(spawner.set_faction,f)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
