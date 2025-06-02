extends Node

var racers = []
var racer_loops = {}
var current_level: int = 1
var position_in_race: int = 1
var loops: int = 1
var race_finish = false

func _enter_tree() -> void:
	SignalHub.on_loop_finished.connect(on_loop_finished)
	SignalHub.on_race_finished.connect(on_race_finished)

func register_racer(racer):
	if racer not in racers:
		racers.append(racer)
		racer_loops[racer] = 0

func increase_racer_loop(racer):
	if race_finish:
		return
	if racer in racer_loops:
		racer_loops[racer] += 1

func get_loop(racer):
	return racer_loops.get(racer, 0)

func on_race_finished(result):
	race_finish = true
	if result == "win":
		print("GameManger: You won!")
	elif result == "lose":
		print("GameManager: You lose!")

func on_loop_finished():
	print("GameManager: On loop is finished! Loop: ", loops)
	loops += 1
