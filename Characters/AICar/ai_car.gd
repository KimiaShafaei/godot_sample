extends CharacterBody2D

@export var speed := 300.0
@export var acceleration := 500.0
@export var rotation_speed := 3.0
@export var path_node: Path2D
@export var offset_distance := 100.0  # Distance to look ahead on path

var progress := 0.0  # progress along path

func _enter_tree() -> void:
	SignalHub.on_race_finished.connect(game_finished)
	SignalHub.on_timer_out.connect(game_finished)

func _physics_process(delta):
	if not path_node:
		return
	
	var curve := path_node.curve
	var path_length := curve.get_baked_length()

	# Look ahead on the path
	progress = fmod(progress + velocity.length() * delta, path_length)
	var target_pos = curve.sample_baked(progress + offset_distance)

	# Direction to target
	var direction_to_target = (target_pos - global_position).normalized()
	var forward = Vector2.DOWN.rotated(rotation)
	
	# Steering logic
	var angle_diff = forward.angle_to(direction_to_target)
	rotation += clamp(angle_diff, -rotation_speed * delta, rotation_speed * delta)

	# Accelerate toward max speed
	velocity = velocity.move_toward(Vector2.DOWN.rotated(rotation) * speed, acceleration * delta)

	# Move
	move_and_slide()
	
	
func game_finished():
	velocity = Vector2.ZERO
	set_physics_process(false) # Stop movement
