extends Node

@onready var time_ui = $"../UI/TimeLabel"

var time_elapsed := 0.0
var race_started := false
var race_finished := false

func _enter_tree() -> void:
	start_race()
	SignalHub.on_race_start.emit()
	SignalHub.on_race_finished.connect(game_finished)

func _process(delta):
	if race_started and not race_finished:
		time_elapsed += delta
		time_ui.text = String("%.2f seconds" % time_elapsed)
		
		
func start_race():
	time_elapsed = 0.0
	race_started = true
	race_finished = false
	
func game_finished():
	race_finished = true
	race_started = false
	print("Finished in: %.2f seconds" % time_elapsed)
