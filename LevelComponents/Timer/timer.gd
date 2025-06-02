extends Node



var time_elapsed := 0.0
var race_started := false
var race_finished := false

var level: Node2D
var time_ui: Label

func _enter_tree() -> void:
	start_race()
	SignalHub.on_race_start.emit()
	SignalHub.on_race_finished.connect(game_finished)
	SignalHub.on_timer_out.connect(game_finished)

func _ready() -> void:
	level = get_tree().get_first_node_in_group("Level")
	time_ui = get_node(String(level.get_path()) + "/UI/TimeLabel")
	
func _process(delta):
	if race_started and not race_finished:
		time_elapsed += delta
		time_ui.text = String("%.2f seconds" % time_elapsed)
		
	# You can find a property in the node with the logic below
	if level.TimeLimit:
		if level.TimeLimit <= time_elapsed:
			SignalHub.on_timer_out.emit()
		
		
		
func start_race():
	time_elapsed = 0.0
	race_started = true
	race_finished = false
	
func game_finished(_result = null):
	race_finished = true
	race_started = false
