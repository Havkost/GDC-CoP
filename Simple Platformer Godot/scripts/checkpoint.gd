extends Area2D

onready var _animated_sprite = $AnimatedSprite
onready var player = get_tree().get_nodes_in_group("player")[0]

func _on_checkpoint_body_entered(body):
	if body == player:
		body.setCheckpoint(self)
		_animated_sprite.frame = 1

func setActive(isActive : bool):
	_animated_sprite.frame = int(isActive)
