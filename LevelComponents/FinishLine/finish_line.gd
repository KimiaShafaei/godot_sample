extends Area2D

@export var allowed_direction := Vector2.LEFT # Change based on your track


@onready var level = $".."
@onready var last_finish_sprite = load("res://kenney_top-down-tanks-redux/PNG/Default size/fenceRed.png")
@onready var line_sprite = $Sprite2D


var last_loop = false

func _ready():
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body):
	if body.name == "Player":
		var movement_direction = body.get_movement_direction() # You implement this on the player
		var dot = movement_direction.normalized().dot(allowed_direction.normalized())
		
		if dot > 0.7: # Acceptable angle tolerance (1.0 = perfect alignment)
			if last_loop:
				SignalHub.on_race_finished.emit()
				return
			print("FinishLine: Lap counted!")
			SignalHub.on_loop_finished.emit()
		else:
			print("FinishLine: Wrong direction, no lap counted.")
			
func _process(_delta: float) -> void:
	if GameManager.loops == level.LevelLoops:
		set_the_finish_sprite()
		last_loop = true
	
func set_the_finish_sprite():
	line_sprite.set_texture(last_finish_sprite)
