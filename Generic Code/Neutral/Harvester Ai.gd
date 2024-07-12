extends "res://Generic Code/Neutral/Basic_Unit.gd"
var target_metal
@onready var bases = get_tree().get_nodes_in_group("base")
var base
@onready var metal = get_tree().get_nodes_in_group("metal")
@export var max_capacity:int
var capacity:int
@export var harvest_rate:int
@export var harvest_range:int
var unloading = false
var spawner
@onready var spawners = get_tree().get_nodes_in_group("spawner")

func _ready():
	for b in bases.size():
		if(bases[b].unitOwner == unitOwner):
			base = bases[b]
	for s in spawners.size():
		if(spawners[s].team == unitOwner):
			spawner = spawners[s]

func _process(delta):
	_death()
	find_metal()
	lookat_metal()
	harvest()
	pass

func lookat_metal():
	if(target_metal != null):
		var target_vector = global_position.direction_to(target_metal.position)
		var target_basis = Basis.looking_at(Vector3(target_vector.x,0,target_vector.z))
		basis = basis.slerp(target_basis, 0.5)
	print_debug("Ooooooh shiny")

func find_metal():
	if(metal.size() < get_tree().get_nodes_in_group("metal").size()):
		metal = get_tree().get_nodes_in_group("metal")
	for m in metal.size():
		if(target_metal != null):
			var metal_pos = target_metal.position
			if(position.distance_to(metal[m].position) < position.distance_to(metal_pos) && target_metal != null):
				target_metal = metal[m]
		else:
			target_metal = metal[m]
	




func harvest():
	if(target_metal != null):
		if(capacity <= max_capacity && !unloading):
			
			if(position.distance_to(target_metal.position) < harvest_range):
				_move(target_metal)
			else:
				target_metal.value = target_metal.value - harvest_rate
				capacity = capacity + harvest_rate
		if(capacity >= max_capacity):
			unloading = true
			if(base != null):
				if(position.distance_to(base) > harvest_range):
					_move(base)
				else:
					capacity = capacity - harvest_rate
					spawner.metal = spawner.metal + harvest_rate
	else:
		print_debug("metal found")
		find_metal()

