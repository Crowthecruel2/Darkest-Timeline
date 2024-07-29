extends "res://Generic Code/Neutral/Basic_Unit.gd"

var Veterancy = 0
var Spawn_Time = 0
var Missle_unlock = false
var Missle_Max = 4
var Missle_current = 1
var Default_missle = load("res://Army/Union/Union_Default_Missle.tscn")
@onready var Missle_timer = 30
@onready var heliBody =  $CollisionShape3D
@onready var blade = $CollisionShape3D/MeshInstance3D5

func _ready():
	Spawn_Time = Global.total_time
	if(position.y < 10):
		position.y = 10
	body.append($CollisionShape3D/MeshInstance3D3)
	body.append($CollisionShape3D/MeshInstance3D6)
	body.append($CollisionShape3D/MeshInstance3D7)
	_set_body_color()

func _process(delta):
	if(Global.total_time >= Spawn_Time+30 && Veterancy == 0 && kills >= 1):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+120 && Veterancy == 1 && kills >= 5):
		veterancy_up()
		
	if(Global.total_time >= Spawn_Time+300 && Veterancy == 2 && kills >= 10):
		veterancy_up()
		
	_death()
	blade.rotate(Vector3(0,1,0),20.1)
	
	#missle reload
	if(Missle_unlock):
		if(Spawn_Time > Missle_timer and Missle_current < Missle_Max):
			Missle_timer = Spawn_Time + 10
			Missle_current = Missle_current + 1
	fire_missle(_findTarget())
	lookat()
	_attack(delta)
	

func fire_missle(target):
	if(target != null):
		if(Missle_unlock and Missle_current > 1 and position.distance_to(target.position) < attackRange*2):
			var firing_missle = Default_missle.instantiate()
			print_debug("FIRING RODMKETS")
			get_parent().add_child(firing_missle)
			firing_missle.position = position + Vector3(randi_range(-1,1),9,randi_range(-1,1))
			firing_missle.target = target
			Missle_current = Missle_current - 1
	pass


func lookat():
	if(target != null):
		var target_vector = heliBody.global_position.direction_to(target.position)
		var target_basis = Basis.looking_at(Vector3(target_vector))
		heliBody.basis = basis.slerp(target_basis, 0.5)

func veterancy_up():
	Veterancy = Veterancy + 1
	if(Veterancy == 1):
		Missle_unlock = true
	if(Veterancy == 2):
		moveSpeed = moveSpeed + 2
	if(Veterancy == 3):
		unitDamage = unitDamage + 5
		bonusDamage = bonusDamage + 10
