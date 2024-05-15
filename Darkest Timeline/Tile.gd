extends Node3D
var Movement = 0
@onready var Mes1 = $RigidBody3D/CollisionShape3D/MeshInstance3D
@onready var Mes2 = $RigidBody3D/CollisionShape3D2/MeshInstance3D
var Mat:StandardMaterial3D = preload("res://Cubes.tres")
var speed = 0.1

# Called when the node enters the scene tree for the first time.
func _ready():
	Mat.albedo_color = Color(randf_range(0,1),randf_range(0,1),randf_range(0,1),randf_range(0.5,1))
	Mes1.material_override = Mat
	Mes2.material_override = Mat
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.transform.origin = self.transform.origin + Vector3(randf_range(-1,1),0,randf_range(-1,1))*speed
	pass
