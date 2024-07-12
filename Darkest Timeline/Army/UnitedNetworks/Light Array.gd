extends "res://Generic Code/Neutral/Basic_Unit.gd"

func _attack(delta):
	if(target != null):
		kill_timer = kill_timer + 1*delta
		if(kill_timer > 5):
			_findTarget()
			kill_timer = 0
		if(self.position.distance_to(target.position) > attackRange && target != null):
			_move(target)
			
			pass
		if(self.position.distance_to(target.position) < attackRange):
			if(attack_cooldown > attackSpeed):
				if(target.unitTypes.has(bonusDamageType)):
					var damage:int = unitDamage + bonusDamage - target.unitArmor
					if(damage < 0):
						damage = 0
					target.unitCurrentHealth = target.unitCurrentHealth - damage
				else:
					var damage:int = unitDamage - target.unitArmor
					if(damage < 0):
						damage = 0
					target.unitCurrentHealth = target.unitCurrentHealth - damage
					
				if(target.unitCurrentHealth < 0):
					kills = kills + 1
					kill_timer = 0
				attack_cooldown = 0
				attackParticle.emitting = true
			else:
				attack_cooldown = attack_cooldown + 1*delta
			pass
	if(target == null):
		self.add_to_group(unitOwner,false)
		_findTarget()
