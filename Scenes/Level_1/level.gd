extends Node2D

@export var LevelLoops: int = 1
@export var PlayersNum: int = 1

## You Only Should Apply this If you want to HAVE time limit.
@export var TimeLimit: float



const GROUP_NAME := "Level"
func _enter_tree() -> void:
	if not is_in_group(GROUP_NAME):
		add_to_group(GROUP_NAME)
