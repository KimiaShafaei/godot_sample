extends Camera2D


func _enter_tree() -> void:
	var level = get_tree().get_first_node_in_group("Level")
	print(level.name)
	limit_top = 0
	limit_left = 0
	limit_right = level.RightLimit
	limit_bottom = level.BottomLimit
