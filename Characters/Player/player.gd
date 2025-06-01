extends CharacterBody2D

@export var MAX_SPEED = 400.0  # Max forward speed
@export var ACCELERATION = 800.0  # Rate of acceleration
@export var BRAKE_FORCE = 1000.0  # Braking power
@export var DRAG = 4.0  # Natural resistance
@export var ROTATION_SPEED = 3.0  # Rotation speed
@export var LATERAL_FRICTION = 10.0  # Reduces side-slipping


@onready var finish_line = $"../FinishLine"

func _ready():
	GameManager.register_racer(self)
	add_to_group("Player")

func _enter_tree() -> void:
	SignalHub.on_race_finished.connect(game_finished)
	SignalHub.on_timer_out.connect(game_finished)

func _physics_process(delta: float) -> void:
	# Input handling (same as before)
	var v_direction := Input.get_axis("break", "accelerate")
	var h_direction := Input.get_axis("steer_left", "steer_right")

	# Rotate the player
	if h_direction != 0.0:
		rotation += h_direction * ROTATION_SPEED * delta

	# Forward direction based on current rotation
	var forward := Vector2(cos(rotation + PI / 2), sin(rotation + PI / 2)).normalized()

	# Acceleration / Braking
	if v_direction > 0.0:
		# Accelerating forward
		velocity += forward * ACCELERATION * delta
	elif v_direction < 0.0:
		# Braking (applying force in reverse direction)
		velocity -= forward * BRAKE_FORCE * delta
	else:
		# No input: apply drag (resistance)
		var drag_force: float = DRAG * velocity.length() * delta
		velocity = velocity.move_toward(Vector2.ZERO, drag_force)

	# Lateral friction to reduce sliding sideways
	var right := forward.orthogonal()
	var lateral_speed := velocity.dot(right)
	velocity -= right * lateral_speed * LATERAL_FRICTION * delta

	# Clamp speed
	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED

	# Move the player
	move_and_slide()
	

# For direction checking in finish line
func get_movement_direction() -> Vector2:
	return velocity
	
func game_finished(_result = null):
	velocity = Vector2.ZERO
	set_physics_process(false) # Stop movement
