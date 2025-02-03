extends CharacterBody2D

const SPEED = 200.0  # Adjust this value to control movement speed
const ROTATION_SPEED = 3.0  # Adjust this value to control rotation speed

func _physics_process(delta: float) -> void:
	# Get vertical input (up/down)
	var v_direction := Input.get_axis("ui_down", "ui_up")
	
	# Get horizontal input (left/right) for rotation
	var h_direction := Input.get_axis("ui_left", "ui_right")
	
	# Rotate the player based on horizontal input
	if h_direction:
		rotation += h_direction * delta * ROTATION_SPEED
	
	# Calculate velocity in the direction the player is facing
	if v_direction:
		velocity = Vector2(cos(rotation+(PI/2)), sin(rotation+(PI/2)))* v_direction  * SPEED
	
	# Move the player
	move_and_slide()
