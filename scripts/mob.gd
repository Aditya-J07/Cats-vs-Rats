extends CharacterBody2D

@onready var player = get_node("/root/Game/rat")
@onready var cathurt: AudioStreamPlayer2D = %cathurt


var health = 3

var SPEED = 300

func _physics_process(delta: float) -> void:
	# Get direction to the player
	var direction = global_position.direction_to(player.global_position)
	
	# Set velocity based on the direction to the player
	velocity = direction.normalized() * SPEED
	
	# Rotate towards the player
	rotation = direction.angle()

	# Move the mob using physics
	move_and_slide()

func take_damage():
	health -= 1
	 
	
	if health == 0:
		 # Try forcing a small delay to make sure sound plays
		cathurt.play() # Play the death sound when health reaches zero or below
		Points.points += 1
		# Use yield to wait a small amount of time before freeing the mob
		await cathurt.finished  # Wait until the sound is finished
		queue_free()  # Destroy the mob when health reaches zero
		
