extends Node
@export var unitOwner:String
@export var unitName:String
@export var unitMaxHealth:int
@export var unitCurrentHealth:int
@export var unitMaxEnergy:int
@export var unitCurrentEnergy:int
@export var unitRegeneration:int
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
var attack_cooldown:float

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(unitOwner,false)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _findTarget():
	var closestEnemy
	if(self.get_tree().get_nodes_in_group("team1").has(self)):
		var enemies = self.get_tree().get_nodes_in_group("team2")
		for x in enemies.size():
			if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position) || closestEnemy == null):
				closestEnemy = enemies[x]
	if(self.get_tree().get_nodes_in_group("team2").has(self)):
		var enemies = self.get_tree().get_nodes_in_group("team1")
		for x in enemies.size():
			if(self.position.distance_to(enemies[x].position) < self.position.distance_to(closestEnemy.position) || closestEnemy == null):
				closestEnemy = enemies[x]
	return closestEnemy

func _move(target):
	if(moveType == 0):
		NavAgent.set_target_location(target.position)
		var target_location = NavAgent.get_next_path_position()
		var target_velocity = (target_location - self.global_transform.origin).normalized() * moveSpeed
		self.velocity = target_velocity
	if(moveType == 1):
		pass
	pass

func _attack(target):
	if(self.position.distance_to(target.position) > attackRange):
		_move(target)
		pass
	else:
		if(attack_cooldown > attackSpeed):
			if(target.unitTypes.has(bonusDamageType)):
				var damage:int = unitDamage + bonusDamage - target.unitArmor
				if(damage < 0):
					damage = 0
				target.unitCurrentHealth = target.unitCurrentHealth - (damage)
			else:
				target.unitCurrentHealth = target.unitCurrentHealth - unitDamage
		pass
	pass

func _death():
	if(unitCurrentHealth <= 0):
		self.free()
	pass
