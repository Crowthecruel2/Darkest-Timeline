extends CharacterBody3D

var Team:String
@onready var hud = $Camera3D/Hud

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var move = Vector3(Input.get_axis("Camera Left","Camera Right"),Input.get_axis("Zoom_in","Zoom_out"),Input.get_axis("Camera Forward","Camera Back")).normalized() * 5
	velocity = move
	move_and_slide()
	pass
