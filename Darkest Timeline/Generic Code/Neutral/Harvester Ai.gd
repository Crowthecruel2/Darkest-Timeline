extends "res://Generic Code/Neutral/Basic_Unit.gd"
var target_metal
var base
@onready var metal = get_tree().get_nodes_in_group("metal")
@export var max_capacity:int
var capacity:int
@export var harvest_rate:int
@export var harvest_range:int

func _process(delta):
	
	pass

func find_metal():
	for m in metal.size():
		if(target_metal != null):
			if(position.distance_to(metal[m]) < position.distance_to(target_metal.position)):
				target_metal = metal[m]
		else:
			target_metal = metal[m]
	return target_metal



func harvest():
	if(capacity <= max_capacity):
		if(position.distance_to(find_metal()) > harvest_range):
			_move(target_metal)
		else:
			target_metal.value = target_metal.value - harvest_rate
			capacity = capacity + harvest_rate
	else:
		_move(base)
	pass
