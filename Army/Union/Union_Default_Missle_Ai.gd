extends RigidBody3D
var target
var speed = 3
var damage = 20
@onready var collider:Area3D = $Area3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func explode():
	var team1 = get_tree().get_nodes_in_group("team1")
	var team2 = get_tree().get_nodes_in_group("team2")
	if(position.distance_to(target.position) < 5):
		for damaged in team1.size():
			var act_damage = damage - team1[damaged].unitMagicArmor
			if(act_damage < 0):
				act_damage = 0
			team1[damaged].unitCurrentHealth = team1[damaged].unitCurrentHealth - act_damage
		for damaged in team2.size():
			var act_damage = damage - team2[damaged].unitMagicArmor
			if(act_damage < 0):
				act_damage = 0
			team2[damaged].unitCurrentHealth = team2[damaged].unitCurrentHealth - act_damage
	queue_free()

func lookat(target):
	if(target != null):
		var target_vector = global_position.direction_to(target.position)
		var target_basis = Basis.looking_at(Vector3(target_vector))
		basis = basis.slerp(target_basis, 0.5)

func rocket(delta):
	linear_velocity = ((target.position - position).normalized()*speed)
	if(speed < 10):
		speed = speed + 1 * delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(target != null):
		lookat(target)
		rocket(delta)
		if(collider.get_overlapping_bodies().has(target)):
			explode()
