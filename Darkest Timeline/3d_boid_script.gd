extends Node3D
var Movement = 0
@onready var Mes1 = $RigidBody3D/CollisionShape3D/MeshInstance3D
@onready var Rig = $RigidBody3D
var Size = randf_range(1,5)
var Mat = StandardMaterial3D.new()
var sep_distance = 5
var Avoid_Factor = 5
var Vision_range = 10
var Matching_factor = 5
var Centering_factor = 1
var rand_factor = 20
var avg_posx = 0
var avg_posy = 0
var avg_posz = 0
var tim = 0

@onready var Boids = get_tree().get_nodes_in_group("Tiles")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Mat.albedo_color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0.5,1))
	Mes1.material_override = Mat


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Boids = get_tree().get_nodes_in_group("Tiles")
	_Seperation()
	_Alignment()
	_RandoDirect()
	Rig.apply_torque(Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1)))
	
	if(transform.origin > Vector3(50,50,50) && transform.origin < Vector3(-50,-50,-50)):
		transform.origin = Vector3(0,0,0)
	pass

func _Seperation():
	var close_dx = 0
	var close_dz = 0
	var close_dy = 0
	for x in Boids.size():
		if(transform.origin.distance_to(Boids[x].transform.origin) < sep_distance):
			close_dx = transform.origin.x - Boids[x].transform.origin.x
			close_dz = transform.origin.z - Boids[x].transform.origin.z
			close_dy = transform.origin.y - Boids[x].transform.origin.y
	Rig.apply_force(Rig.linear_velocity + Vector3(close_dx,close_dy,close_dz)*Avoid_Factor)

func _Alignment():
	var xvel_avg = 0
	var yvel_avg = 0
	var zvel_avg = 0
	var Neighboring_boids = 0
	
	for x in Boids.size():
		if(transform.origin.distance_to(Boids[x].transform.origin) < Vision_range):
			xvel_avg = Boids[x].Rig.linear_velocity.x
			yvel_avg = Boids[x].Rig.linear_velocity.y
			zvel_avg = Boids[x].Rig.linear_velocity.z
			Neighboring_boids = Neighboring_boids+1
	if(Neighboring_boids > 0):
		Rig.apply_force(Rig.linear_velocity + (Vector3((xvel_avg / Neighboring_boids),(yvel_avg / Neighboring_boids),(zvel_avg / Neighboring_boids)) - Rig.linear_velocity) * Matching_factor)

func _Cohesion():
	avg_posx = 0
	avg_posy = 0
	avg_posz = 0
	for x in (Boids.size()):
		if(transform.origin.distance_to(Boids[x].transform.origin) < Vision_range):
			avg_posx = avg_posx + Boids[x].transform.origin.x
			avg_posy = avg_posy + Boids[x].transform.origin.y
			avg_posz = avg_posz + Boids[x].transform.origin.z
	var avg_pos = Vector3(avg_posx,avg_posy,avg_posz)
	avg_pos = avg_pos / (Boids.size()+1)
	Rig.apply_force(Rig.linear_velocity + (avg_pos - transform.origin)*Centering_factor)

func _RandoDirect():
	tim = tim + 1
	var forc = Vector3.ZERO
	if tim % 60 == 0:
		tim = 0
		forc = Rig.linear_velocity + Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1))*rand_factor
	Rig.apply_force(forc)
	pass
