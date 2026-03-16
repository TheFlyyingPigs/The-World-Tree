class_name UpgradeHandler extends Node
'
handles applying the changes from every upgrade in the game!
'


func apply_upgrade(upgrade):
	match upgrade:
		Globals.Upgrades.FOG_DENSITY_1: Globals.fog_density -= 0.05
