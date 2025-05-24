extends Node2D


@onready var ai_car_scene = preload("res://Characters/AICar/ai_car.tscn")
@onready var path = $"./Path2D"
@onready var level = $".."


func _ready():
	for i in range(level.PlayersNum):
		var ai = ai_car_scene.instantiate()
		ai.path_node = path
		ai.global_position = path.curve.sample_baked(i * 50.0)
		add_child(ai)
