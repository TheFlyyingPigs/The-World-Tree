class_name DeathComponent extends Node
'
handles player death
'

func die():
	'
	switches levels when died
	'
	for i in Globals.found_this_run:
		Globals.inventory.erase(i)
	Globals.died = true
	Globals.switch_level(Globals.LevelID.INSIDE)
	
