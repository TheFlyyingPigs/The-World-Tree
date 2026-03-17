class_name UpgradeHandler extends Node
'
handles applying the changes from every upgrade in the game!
'

signal upgraded

# CONSTANTS
const FOG_DECREASE = 0.05
const TIMER_INCREASE = 30
const SUNLIGHT_INCREASE = 0.05
const CRUMBS_INCREASE = 5

func apply_upgrade(upgrade_resource : UpgradeType):
	'
	applies the selected upgrade via enourmous match statement (it was the best solution i could come up with)
	
	arguments:
		upgrade_resource: the UpgradeType of the selected upgrade
	'
	var upgrade = upgrade_resource.upgrade
	match upgrade:
		Globals.Upgrades.FOG_DENSITY_1: Globals.fog_density -= FOG_DECREASE
		Globals.Upgrades.FOG_DENSITY_2: Globals.fog_density -= FOG_DECREASE
		Globals.Upgrades.FOG_DENSITY_3: Globals.fog_density -= FOG_DECREASE
		Globals.Upgrades.FOG_DENSITY_4: Globals.fog_density -= FOG_DECREASE
		Globals.Upgrades.FOG_DENSITY_5: Globals.fog_density -= FOG_DECREASE
		
		Globals.Upgrades.LONGER_TIMER_1: Globals.timer_length += TIMER_INCREASE
		Globals.Upgrades.LONGER_TIMER_2: Globals.timer_length += TIMER_INCREASE
		Globals.Upgrades.LONGER_TIMER_3: Globals.timer_length += TIMER_INCREASE
		Globals.Upgrades.LONGER_TIMER_4: Globals.timer_length += TIMER_INCREASE
		Globals.Upgrades.LONGER_TIMER_5: Globals.timer_length += TIMER_INCREASE
		
		Globals.Upgrades.BRIGHTER_SUN_1: Globals.sunlight += SUNLIGHT_INCREASE
		Globals.Upgrades.BRIGHTER_SUN_2: Globals.sunlight += SUNLIGHT_INCREASE
		Globals.Upgrades.BRIGHTER_SUN_3: Globals.sunlight += SUNLIGHT_INCREASE
		Globals.Upgrades.BRIGHTER_SUN_4: Globals.sunlight += SUNLIGHT_INCREASE
		Globals.Upgrades.BRIGHTER_SUN_5: Globals.sunlight += SUNLIGHT_INCREASE
		
		Globals.Upgrades.MORE_BREAD_CRUMBS_1: Globals.max_bread_crumbs += CRUMBS_INCREASE
		Globals.Upgrades.MORE_BREAD_CRUMBS_2: Globals.max_bread_crumbs += CRUMBS_INCREASE
		Globals.Upgrades.MORE_BREAD_CRUMBS_3: Globals.max_bread_crumbs += CRUMBS_INCREASE
		Globals.Upgrades.MORE_BREAD_CRUMBS_4: Globals.max_bread_crumbs += CRUMBS_INCREASE
		Globals.Upgrades.MORE_BREAD_CRUMBS_5: Globals.max_bread_crumbs += CRUMBS_INCREASE
	
	upgraded.emit()
