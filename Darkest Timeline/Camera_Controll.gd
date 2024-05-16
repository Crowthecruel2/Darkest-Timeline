extends Camera3D
var movement = Vector3.ZERO
@export var speed = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var Boids = get_tree().get_nodes_in_group("Tiles")
	var avg_posx = 0
	var avg_posy = 0
	var avg_posz = 0
	for x in Boids.size():
		avg_posx = avg_posx + Boids[x].transform.origin.x
		avg_posy = avg_posy + Boids[x].transform.origin.y
		avg_posz = avg_posz + Boids[x].transform.origin.z
	var avg_pos = Vector3(avg_posx,avg_posy,avg_posz)
	
	avg_pos = avg_pos / (Boids.size()+1)
	
	movement = Vector3.ZERO
	transform.origin = transform.origin + Vector3(Input.get_axis("Camera Left","Camera Right"),0,Input.get_axis("Camera Back","Camera Forward")*-1).normalized()*speed
	if(Input.is_action_pressed("Zoom_in") && transform.origin.y >= 1):
		transform.origin = transform.origin - Vector3(0,1,0)
	if(Input.is_action_pressed("Zoom_out")):
		transform.origin = transform.origin + Vector3(0,1,0)
