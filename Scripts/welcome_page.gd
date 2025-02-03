extends Control  # Assuming the root node is a Control node

func _ready():
	# Connect the button's "pressed" signal to this script
	var StartButton = get_node("WelcomeColor/VBoxContainer/CenterForButton/Button")
	StartButton.pressed.connect(self._on_button_pressed)


func _on_button_pressed():
	
	# Load the next scene
	var next_scene = "res://Scenes/Level_1.tscn" 
	get_tree().change_scene_to_file(next_scene)
