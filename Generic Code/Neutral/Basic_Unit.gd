extends CharacterBody3D
@export var unitOwner:String
@export var unitName:String
@export var unitMaxHealth:int
@export var unitCurrentHealth:int
@export var unitMaxEnergy:int
@export var unitCurrentEnergy:int
@export var unitHealthRegeneration:int
@export var unitEnergyRegeneration:int
@export var unitArmor:int
@export var unitMagicArmor:int
@export var unitTypes:Array = ["Light","Biological"]
@export var moveType:int
@export var moveSpeed:int
@export var attackRange:int
@export var attackSpeed:float
@export var unitDamage:int
@export var bonusDamageType:String
@export var bonusDamage:int
@export var NavAgent:NavigationAgent3D
@export var unitCost: int
@export var unitIncome: int
@export var attackParticle:CPUParticles3D
@export var canHitAir:bool = false
@export var unitDesc:String
var enemies = []
var kills = 0
var regen_timer = 0
var target
var kill_timer = 0
var attack_cooldown:float
var retreating:int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(unitOwner,false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(unitCurrentHealth < unitMaxHealth && regen_timer > 3):
		unitCurrentHealth = unitCurrentHealth + unitHealthRegeneration
		if(unitCurrentHealth > unitMaxHealth):
			unitCurrentHealth = unitMaxHealth
		unitCurrentEnergy = unitCurrentEnergy + unitEnergyRegeneration
		if(unitCurrentEnergy > unitMaxEnergy):
			unitCurrentEnergy = unitMaxEnergy
		regen_timer = 0
	regen_timer = regen_timer + 1*delta
	pass

func _findTarget():
	var closestEnemy
	if(self.get_tree().get_nodes_in_group("team1").has(self)):
		enemies = self.get_tree().get_nodes_in_group("team2")
	if(self.get_tree().get_nodes_in_group("team2").has(self)):
		enemies = self.get_tree().get_nodes_in_group("team1")
	
	for x in enemies.size():
		if(canHitAir == true && enemies[x].moveType == 1):
			if(closestEnemy != null):
				if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position)):
					closestEnemy = enemies[x]
			else:
				closestEnemy = enemies[x]
		if(canHitAir == true && enemies[x].moveType == 0):
			if(closestEnemy != null):
				if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position)):
					closestEnemy = enemies[x]
			else:
				closestEnemy = enemies[x]
		if(canHitAir == false && enemies[x].moveType == 0):
			if(closestEnemy != null):
				if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position)):
					closestEnemy = enemies[x]
			else:
				closestEnemy = enemies[x]
	return closestEnemy

func _move(target):
	NavAgent.target_position = target.position
	var target_location = NavAgent.get_next_path_position()
	var target_velocity = (target_location - global_transform.origin).normalized() * moveSpeed
	self.velocity = target_velocity
	move_and_slide()

func lookat():
	if(target != null):
		var target_vector = global_position.direction_to(target.position)
		var target_basis = Basis.looking_at(Vector3(target_vector))
		basis = basis.slerp(target_basis, 0.5)

func _attack(delta):
	if(target != null):
		kill_timer = kill_timer + 1*delta
		if(kill_timer > 5):
			target = _findTarget()
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
		target = _findTarget()

func _death():
	if(unitCurrentHealth <= 0):
		print_debug("Fuck ive died! " + unitName)
		self.queue_free()
