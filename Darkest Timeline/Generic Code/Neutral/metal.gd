extends Node3D
@onready var value = randi_range(20,100)
@onready var strands = [$CollisionShape3D/strand1,$CollisionShape3D/strand2,$CollisionShape3D/strand3]
# Called when the node enters the scene tree for the first time.
func _ready():
	for x in strands.size():
		strands[x].scale = Vector3(randi_range(0.25,1),randi_range(1,5),randi_range(0.25,1))
		strands[x].rotation = Vector3(randi_range(-45,45),randi_range(-45,45),randi_range(-45,45))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(value <= 0):
		queue_free()
	pass
