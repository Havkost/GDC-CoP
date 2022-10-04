extends KinematicBody2D

# Movement variables
var movespeed : int = 200
var jumpspeed : int = 400
var gravity : int = 1000
var velocity = Vector2()
var timeInAir : float = 0
var cyoteTime : float = 0.07

# Respawning
onready var checkpoints = get_tree().get_nodes_in_group("checkpoint")
var currentCheckpoint : Area2D = null
var deathBarrierY : float = 400

# Reference children
onready var _camera = $Camera2D

func get_input(delta):
	# Horizontal movement
	velocity.x = 0
	velocity.x += movespeed * (int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left")))
	
	# Jumping
	if is_on_floor():
		timeInAir = 0
	else:
		timeInAir += delta
	
	if Input.is_action_just_pressed("jump") && timeInAir < cyoteTime:
		velocity.y = -jumpspeed
		timeInAir = cyoteTime
	
	# Gravity
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	pass
	
func _physics_process(delta):
	get_input(delta)
	
	# Restart if falling out of world
	if position.y >= deathBarrierY:
		if currentCheckpoint != null:
			position = currentCheckpoint.position
		else:
			position = Vector2(0, 0)
		
		# Reset camera offset
		_camera.position = Vector2(0, 0)

func setCheckpoint(checkpoint):
	if(currentCheckpoint == checkpoint): return
	if(currentCheckpoint != null):
		currentCheckpoint.setActive(false)
	currentCheckpoint = checkpoint
