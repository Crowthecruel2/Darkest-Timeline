extends Camera3D
var movement = Vector3.ZERO
@export var speed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	movement = Vector3.ZERO
	transform.origin = transform.origin + Vector3(Input.get_axis("Camera Left","Camera Right"),0,Input.get_axis("Camera Back","Camera Forward")*-1).normalized()*speed
	if(Input.is_action_pressed("Zoom_in") && transform.origin.y >= 1):
		transform.origin = transform.origin - Vector3(0,1,0)
	if(Input.is_action_pressed("Zoom_out")):
		transform.origin = transform.origin + Vector3(0,1,0)
	pass
