extends "res://Generic Code/Neutral/Basic_Unit.gd"
var damage_ramp = 0

func _ready():
	if(unitOwner == "team1"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[0]
	if(unitOwner == "team2"):
		$CollisionShape3D/MeshInstance3D.material_override = Global.color_arr[1]

func _process(delta):
	_death()
	lookat()
	_attack(delta)

func _attack(delta):
	if(target != null):
		kill_timer = kill_timer + 1*delta
		if(kill_timer > 5):
			target = _findTarget()
			kill_timer = 0
		if(self.position.distance_to(target.position) > attackRange && target != null):
			_move(target)
			damage_ramp = 0
			if(attackParticle.emitting != false):
				attackParticle.emitting = false
		if(self.position.distance_to(target.position) < attackRange):
			if(attackParticle.emitting != true):
				attackParticle.emitting = true
			damage_ramp = damage_ramp +1*delta
			if(attack_cooldown > attackSpeed):
				if(target.unitTypes.has(bonusDamageType)):
					var damage:int = unitDamage + bonusDamage - target.unitArmor + roundi(damage_ramp)
					if(damage < 0):
						damage = 0
					target.unitCurrentHealth = target.unitCurrentHealth - damage
				else:
					var damage:int = unitDamage - target.unitArmor + roundi(damage_ramp)
					if(damage < 0):
						damage = 0
					target.unitCurrentHealth = target.unitCurrentHealth - damage 
					
				if(target.unitCurrentHealth < 0):
					kills = kills + 1
					kill_timer = 0
				attack_cooldown = 0
				
			else:
				attack_cooldown = attack_cooldown + 1*delta
			pass
	if(target == null):
		
		self.add_to_group(unitOwner,false)
		target = _findTarget()
