extends CharacterBody3D
@export var team:String
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector3(Input.get_axis("Camera Left","Camera Right"),Input.get_axis("Zoom_in","Zoom_out"),Input.get_axis("Camera Forward","Camera Back")).normalized() * 100
	velocity = move
	move_and_slide()
	pass
