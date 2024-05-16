extends Node3D
var Movement = 0
@onready var Mes1 = $RigidBody3D/CollisionShape3D/MeshInstance3D
@onready var Rig = $RigidBody3D
var Size = randf_range(1,5)
var Mat = StandardMaterial3D.new()
var speed = 50
var rot_speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	
	Mat.albedo_color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0.5,1))
	Mes1.material_override = Mat
	scale = Vector3(Size,Size,Size)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	Mat.albedo_color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0.5,1))
	Rig.apply_force(Vector3(randf_range(-1,1),0,randf_range(-1,1))*speed)
	Rig.apply_torque(Vector3(randf_range(-1,1),randf_range(-1,1),randf_range(-1,1))*rot_speed)
	pass
