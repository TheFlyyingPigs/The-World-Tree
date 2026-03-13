extends Area3D
'
transitions to a specified level when the player walks into it
'
@export var connected_level : Globals.LevelID

func switch_level(body: Node3D) -> void:
	'
	switches the level to the connected_level var
	'
	if body is CharacterBody3D:
		Globals.switch_level(connected_level,false)
