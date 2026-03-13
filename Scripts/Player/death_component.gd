class_name DeathComponent extends Node
'
handles player death
'

func die():
	'
	switches levels and deletes resources when player dies
	'
	Globals.died = true
	Globals.switch_level(Globals.LevelID.INSIDE, true)
