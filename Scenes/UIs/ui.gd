extends CanvasLayer

func _ready() -> void:
	SignalHub.on_race_finished.connect(show_win_screen)
	
func show_win_screen():
	$"./WinLabel".visible = true
