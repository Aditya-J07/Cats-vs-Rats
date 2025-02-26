extends CharacterBody2D

@onready var player = get_node("/root/Game/rat")

var health = 3

var SPEED = 250

func _physics_process(delta: float) -> void:
	# Get direction to the player
	var direction = global_position.direction_to(player.global_position)
	
	# Set velocity based on the direction to the player
	velocity = direction.normalized() * SPEED
	
	# Rotate towards the player
	rotation = direction.angle()

	# Move the mob using physics
	move_and_slide()
