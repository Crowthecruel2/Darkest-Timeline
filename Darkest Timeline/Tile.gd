extends Node2D
var Movement = 0
@onready var Mes = $MeshInstance2D
var Direction = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Mes.modulate = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0.5,1))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(Direction):
		self.transform.origin = self.transform.origin + Vector2(randi_range(1,10),randi_range(-10,10))
		Movement = Movement + 1
	if(!Direction):
		self.transform.origin = self.transform.origin - Vector2(randi_range(1,10),randi_range(-10,10))
		Movement = Movement + 1
	if(Movement >= 5 && Direction):
		Movement = 0
		Direction = false
	if(Movement >= 5 && !Direction):
		Movement = 0
		Direction = true
	pass
