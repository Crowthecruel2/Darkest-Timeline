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
@export var attackRange:int
@export var attackSpeed:float
@export var unitDamage:int
@export var bonusDamageType:String
@export var bonusDamage:int
var kills = 0
var regen_timer = 0
var target
var attack_cooldown:float

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
		var enemies = self.get_tree().get_nodes_in_group("team2")
		for x in enemies.size():
			if(closestEnemy != null):
				if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position)):
					closestEnemy = enemies[x]
			else:
				closestEnemy = enemies[x]
		var random_num = randi_range(1,4)
		if(random_num == 3):
			closestEnemy = enemies.pick_random()
	if(self.get_tree().get_nodes_in_group("team2").has(self)):
		var enemies = self.get_tree().get_nodes_in_group("team1")
		for x in enemies.size():
			if(closestEnemy != null):
				if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position)):
					closestEnemy = enemies[x]
			else:
				closestEnemy = enemies[x]
		var random_num = randi_range(1,4)
	target = closestEnemy

func _attack(delta):
	if(target != null):
		
		if(self.position.distance_to(target.position) < attackRange):
			
			if(attack_cooldown > attackSpeed):
				print_debug("FIRING MEH LAZER!@")
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
				attack_cooldown = 0
			else:
				attack_cooldown = attack_cooldown + 1*delta
			pass
		else:
			_findTarget()
	if(target == null):
		self.add_to_group(unitOwner,false)
		_findTarget()

func _death():
	if(unitCurrentHealth <= 0):
		print_debug("Fuck ive died! " + unitName)
		self.queue_free()
