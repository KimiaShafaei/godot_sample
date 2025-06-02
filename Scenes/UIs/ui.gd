extends CanvasLayer

@onready var loops_label = $LoopsLabel
@onready var level = get_tree().get_first_node_in_group("Level")

func _ready() -> void:
	SignalHub.on_loop_finished.connect(update_loops_label)
	SignalHub.on_race_finished.connect(show_screen)
	SignalHub.on_timer_out.connect(show_lose_screen)
	update_loops_label()

func show_screen(result):
	if result == "win":
		show_win_screen()
	elif result == "lose":
		show_lose_screen()
		
func show_win_screen():
	$"./WinLabel".visible = true
	
func show_lose_screen():
	$"./LoseLabel".visible = true

func update_loops_label(loops_passed = null):
	var player = get_tree().get_first_node_in_group("Player")
	var level_loops = level.LevelLoops
	loops_passed = GameManager.get_loop(player)
	loops_label.text = "Loops: %d/%d" % [loops_passed, level_loops]
