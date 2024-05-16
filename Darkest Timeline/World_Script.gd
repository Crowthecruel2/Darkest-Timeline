extends Node3D
var Players
var Teams
@onready var Tile = preload("res://tile.tscn")
@onready var Camera = $Camera2D
var BoardSize
var BoardX
var BoardY
var Tile_Counter = 0

# Called when the node enters the scene tree for the first time.
#class Team(self, teamName,score, team):
func _ready():
	Players = get_tree().get_nodes_in_group("Players")
	Teams = 2
	BoardSize = 5
	for x in BoardSize:
		
		for z in BoardSize:
			
			for y in BoardSize:
				var NewTile = Tile.instantiate()
				add_child(NewTile)
				NewTile.transform.origin = Vector3(x*3,y*3,z*3)
				Tile_Counter = Tile_Counter+1
			
	print_debug(Tile_Counter)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	pass
