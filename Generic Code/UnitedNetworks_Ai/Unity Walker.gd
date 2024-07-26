extends "res://Generic Code/Neutral/Basic_Unit.gd"

var ConvertTarget
@export var ConvertRange:int

func _ready():
	body.append($CollisionShape3D/MeshInstance3D)
	_set_body_color()

func _process(delta):
	_death()
	lookat()
	_Convert(delta)

func lookat():
	if(ConvertTarget != null):
		var target_vector = global_position.direction_to(ConvertTarget.position)
		var target_basis = Basis.looking_at(Vector3(target_vector))
		basis = basis.slerp(target_basis, 0.5)

func _Convert(delta):
	
	if(ConvertTarget != null):
		kill_timer = kill_timer + 1*delta
		if(kill_timer > 5):
			ConvertTarget = _findTarget()
			kill_timer = 0
		if(self.position.distance_to(ConvertTarget.position) > attackRange && ConvertTarget != null):
			_move(ConvertTarget)
			
			pass
		if(self.position.distance_to(ConvertTarget.position) < attackRange):
			if(attack_cooldown > attackSpeed):
				if(ConvertTarget.unitTypes.has(bonusDamageType)):
					var damage:int = unitDamage + bonusDamage - ConvertTarget.unitArmor
					if(damage < 0):
						damage = 0
					ConvertTarget.unitCurrentHealth = ConvertTarget.unitCurrentHealth - damage
					attackParticle.emitting = true
				else:
					attack_cooldown = 0
					ConvertTarget.unitOwner = unitOwner
					ConvertTarget._set_body_color()
					attackParticle.emitting = true
			else:
				attack_cooldown = attack_cooldown + 1*delta
			pass
	if(ConvertTarget == null):
		self.add_to_group(unitOwner,false)
		ConvertTarget = _findTarget()
