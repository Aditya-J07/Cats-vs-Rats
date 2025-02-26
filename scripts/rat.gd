extends CharacterBody2D

signal health_depleted


# Speed of the character
var SPEED = 550
var health = 100.0
var health_bar : ProgressBar  # Reference to the ProgressBar node

# Time-related variables
var damage_taken = false
var damage_delay = 0.5  # Time to keep the health bar visible (in seconds)
var damage_timer = 0.0  # Timer to track damage time

func _ready():
	# Ensure the ProgressBar is hidden at the start
	health_bar = $ProgressBar  # Assuming the ProgressBar is a direct child
	health_bar.visible = false  # Hide the ProgressBar initially

func _process(delta):
	var motion = Vector2()

	# Collect custom input for movement (custom actions)
	if Input.is_action_pressed("move_left"):
		motion.x -= 1
	if Input.is_action_pressed("move_right"):
		motion.x += 1
	if Input.is_action_pressed("move_up"):
		motion.y -= 1
	if Input.is_action_pressed("move_down"):
		motion.y += 1

	# Normalize to prevent faster diagonal movement and apply SPEED
	velocity = motion.normalized() * SPEED

	# Move the character
	move_and_slide()

	const DMG = 5.0
	var over_lapping_mobs = $HurtBox.get_overlapping_bodies()  # Assuming HurtBox is a child node
	if over_lapping_mobs.size() > 0:
		health -= DMG * over_lapping_mobs.size() * delta
		
		# Show health bar when taking damage
		if not damage_taken:
			health_bar.visible = true  # Show health bar when taking damage
			damage_taken = true
			damage_timer = 0.0  # Reset the timer

		health_bar.value = health
		
		if health <= 0.0:
			health_depleted.emit()

	# If the player has stopped taking damage, start the damage timer
	if damage_taken:
		damage_timer += delta
		if damage_timer > damage_delay:
			health_bar.visible = false  # Hide the health bar after damage_delay
			damage_taken = false  # Reset the flag to wait for the next damage
