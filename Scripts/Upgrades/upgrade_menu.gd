extends Control

@export var possibleUpgrades : Array[UpgradeType]

var found_upgrades := []

func generate_upgrade_choices():
	var upgrade_options := []
	
	for i in range(3):
		var choice = get_random_upgrade(upgrade_options)
		if not choice == null:
			upgrade_options.append(choice)
		else:
			upgrade_options.append(load("res://Upgrades/null_upgrade_type.tres"))
	
	for i in range(3):
		var upgrade_button = get_node("HBoxContainer/UpgradeOption"+str(i+1))
		upgrade_button.upgrade = upgrade_options[i]
		upgrade_button.set_up()

func get_random_upgrade(upgrade_options) -> UpgradeType:
	var possible_upgrades := []
	
	for choice in possibleUpgrades:
		print(choice)
		if choice in upgrade_options: # if choice not already an option
			pass
		elif choice in possible_upgrades: # if choice already in list of possible random upgrades
			pass
		elif choice in found_upgrades: # if choice not already picked
			pass
		elif choice.prerequisites.size() > 0: # if there are prerequisites
				for i in choice.prerequisites: # then check if you have them
					if i in found_upgrades:
						possible_upgrades.append(choice)
		else: # if it passes all those checks
			possible_upgrades.append(choice)
		print(possible_upgrades)
	if possible_upgrades.size() > 0:
		var random_item = possible_upgrades.pick_random()
		return random_item
	else: 
		print_debug("only "+str(possible_upgrades.size())+" upgrade choices")
		return null
