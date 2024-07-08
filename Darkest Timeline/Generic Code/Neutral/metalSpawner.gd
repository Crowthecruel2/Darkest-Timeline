extends Node3D
@onready var metal = preload("res://Buildings/Neutral/metal.tscn")
@export var total_metal_nodes:int
@export var radius:int
var nodes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(nodes.size()< total_metal_nodes):
		var new_metal = metal.instantiate()
		new_metal.position = find_point()
		add_child(new_metal)
		nodes.append(new_metal)
	pass

func find_point():
	while true:
		var x = randf_range(-radius,radius) * 2 + 1
		var y = randf_range(-radius,radius) * 2 + 1
		if(x*x + y*y < radius**2):
			return Vector3(x,0,y)
