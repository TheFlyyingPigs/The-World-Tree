extends Area3D

@export var connected_level : Globals.LevelID

func switch_level(body: Node3D) -> void:
	if body is CharacterBody3D:
		Globals.switch_level(connected_level)
