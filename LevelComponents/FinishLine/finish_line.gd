extends Area2D

@export var allowed_direction := Vector2.LEFT # Change based on your track

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.name == "Player":
		var movement_direction = body.get_movement_direction() # You implement this on the player
		var dot = movement_direction.normalized().dot(allowed_direction.normalized())
		
		if dot > 0.7: # Acceptable angle tolerance (1.0 = perfect alignment)
			print("Lap counted!")
			SignalHub.on_loop_finished.emit()
		else:
			print("Wrong direction, no lap counted.")
