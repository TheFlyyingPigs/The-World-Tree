class_name UpgradeHandler extends Node
'
handles applying the changes from every upgrade in the game!
'

signal upgraded

# UPGRADE CONSTANTS
const FOG_DECREASE = 0.05
const TIMER_INCREASE = 30
const SUNLIGHT_INCREASE = 20
const CRUMBS_INCREASE = 5
const STAMINA_INCREASE = 10
const BEACON_STRENGTH_INCREASE = 50
const SHORTER_EFFECTS_INCREASE = 2
const CHANCE_INCREASE = 0.1


# TREE STAGE CONSTANTS
const TREE_STAGE_2_AMOUNT = 10
const TREE_STAGE_3_AMOUNT = 15

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
		
		Globals.Upgrades.MORE_STAMINA_1: Globals.max_stamina += STAMINA_INCREASE
		Globals.Upgrades.MORE_STAMINA_2: Globals.max_stamina += STAMINA_INCREASE
		Globals.Upgrades.MORE_STAMINA_3: Globals.max_stamina += STAMINA_INCREASE
		Globals.Upgrades.MORE_STAMINA_4: Globals.max_stamina += STAMINA_INCREASE
		Globals.Upgrades.MORE_STAMINA_5: Globals.max_stamina += STAMINA_INCREASE
		
		Globals.Upgrades.BEACON_STRENGTH_1: Globals.beacon_strength = 150
		Globals.Upgrades.BEACON_STRENGTH_2: Globals.beacon_strength += BEACON_STRENGTH_INCREASE
		Globals.Upgrades.BEACON_STRENGTH_3: Globals.beacon_strength += BEACON_STRENGTH_INCREASE
		Globals.Upgrades.BEACON_STRENGTH_4: Globals.beacon_strength += BEACON_STRENGTH_INCREASE
		Globals.Upgrades.BEACON_STRENGTH_5: Globals.beacon_strength += BEACON_STRENGTH_INCREASE
		
		Globals.Upgrades.SHORTER_EFFECTS_1: Globals.status_effects_shorten += SHORTER_EFFECTS_INCREASE
		Globals.Upgrades.SHORTER_EFFECTS_2: Globals.status_effects_shorten += SHORTER_EFFECTS_INCREASE
		Globals.Upgrades.SHORTER_EFFECTS_3: Globals.status_effects_shorten += SHORTER_EFFECTS_INCREASE
		Globals.Upgrades.SHORTER_EFFECTS_4: Globals.status_effects_shorten += SHORTER_EFFECTS_INCREASE
		Globals.Upgrades.SHORTER_EFFECTS_5: Globals.status_effects_shorten += SHORTER_EFFECTS_INCREASE
		
		Globals.Upgrades.ADDITONAL_RESOURCES_1: Globals.additonal_chance += CHANCE_INCREASE
		Globals.Upgrades.ADDITONAL_RESOURCES_2: Globals.additonal_chance += CHANCE_INCREASE
		Globals.Upgrades.ADDITONAL_RESOURCES_3: Globals.additonal_chance += CHANCE_INCREASE
		Globals.Upgrades.ADDITONAL_RESOURCES_4: Globals.additonal_chance += CHANCE_INCREASE
		Globals.Upgrades.ADDITONAL_RESOURCES_5: Globals.additonal_chance += CHANCE_INCREASE
		
		Globals.Upgrades.EXIT_PROTOCOL: get_tree().quit()
		
	
	upgraded.emit()
	match Globals.found_upgrades.size():
		TREE_STAGE_2_AMOUNT: 
			Globals.tree_stage += 1
		TREE_STAGE_3_AMOUNT: 
			Globals.tree_stage += 1
