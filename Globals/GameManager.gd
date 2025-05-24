extends Node


var racers = []
var current_level: int = 1
var position_in_race: int = 1

var loops: int = 1

func _enter_tree() -> void:
	SignalHub.on_loop_finished.connect(on_loop_finished)
	SignalHub.on_race_finished.connect(on_race_finished)

func on_race_finished():
	print("You won!")
	
func on_loop_finished():
	print("On loop is finished! Loop: ", loops)
	loops += 1
