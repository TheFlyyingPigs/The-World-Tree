extends Node

enum Upgrades {
	TEST_1,
	TEST_2,
	TEST_3
}

var test_var := 0

var UpgradeAttributes = {
	"TEST_1": {
		"display_name" : "Test Upgrade 1",
		"icon" : preload("res://Assets/Textures/GUI/spr_TimerProgressBar.png"),
		"description" : "The first upgrade used for creating and testing the upgrade system",
		"variable" : test_var,
		"power" : 0,
	},
	"TEST_2":{
		"display_name" : "Test Upgrade 2",
		"icon" : preload("res://Assets/Textures/GUI/spr_TimerProgressBar.png"),
		"description" : "The second upgrade used for creating and testing the upgrade system",
		"variable" : test_var,
		"power" : 0
	},
	"TEST_3":{
		"display_name" : "Test Upgrade 3",
		"icon" : preload("res://Assets/Textures/GUI/spr_TimerProgressBar.png"),
		"description" : "The third upgrade used for creating and testing the upgrade system",
		"variable" : test_var,
		"power" : 0
	},
}

func apply_upgrade(upgrade : Upgrades):
	var upgrade_name = Upgrades.keys()[upgrade]
	var power = UpgradeAttributes[upgrade_name].power
	UpgradeAttributes[upgrade_name].variable += power
	print_debug("Upgraded variable: "+UpgradeAttributes[upgrade_name].variable)
