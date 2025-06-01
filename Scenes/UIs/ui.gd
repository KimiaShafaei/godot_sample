extends CanvasLayer

func _ready() -> void:
	SignalHub.on_race_finished.connect(show_screen)
	SignalHub.on_timer_out.connect(show_lose_screen)

func show_screen(result):
	if result == "win":
		show_win_screen()
	elif result == "lose":
		show_lose_screen()
		
func show_win_screen():
	$"./WinLabel".visible = true
	
func show_lose_screen():
	$"./LoseLabel".visible = true
