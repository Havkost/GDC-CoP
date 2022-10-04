extends Camera2D

var yClamp : float = 50
var player : KinematicBody2D

func _ready():
	player = get_parent()

func _physics_process(delta):
	if player.position.y > yClamp:
		position.y = yClamp - player.position.y
