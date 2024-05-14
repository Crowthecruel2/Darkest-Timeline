extends Node2D
var Players
var Teams
@onready var Tile = preload("res://tile.tscn")
@onready var Camera = $Camera2D
var BoardSize
var BoardX
var BoardY
var Tile_Counter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	Players = get_tree().get_nodes_in_group("Players")
	Teams = 2
	BoardSize = Teams * 5
	if(BoardSize % 2 == 0):
		BoardSize = BoardSize-1
	for x in BoardSize:
		for y in BoardSize:
			if((BoardSize-1)/2 == x && (BoardSize-1)/2 == y):
				Camera.transform.origin = Vector2(x*75,y*75)
			var NewTile = Tile.instantiate()
			NewTile.transform.origin = Vector2(x*75,y*75)
			Tile_Counter = Tile_Counter+1
	print_debug(Tile_Counter)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	pass
