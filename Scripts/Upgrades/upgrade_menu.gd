extends Control
'
the manager of all the upgrade options
'

var available_upgrades : Array[UpgradeType]

var refresh_cost := 1 # Random common resource
@onready var refresh_item_type 

@onready var refresh_button: Button = $UpgradeRefresh
@onready var inventory_label: Label = $UpgradeInventory

func open_screen():
	'
	triggered when the menu is opened, resets refresh cost
	'
	for i in range(3):
		var upgrade_button = get_node("HBoxContainer/UpgradeOption"+str(i+1))
		upgrade_button.different_option_picked = false
	
	refresh_cost = 1
	generate_upgrade_choices()

func generate_upgrade_choices():
	'
	sets the three upgrade options to random ones
	'
	var upgrade_options := []
	
	for i in range(3):
		var choice = get_random_upgrade(upgrade_options)
		if not choice == null:
			upgrade_options.append(choice)
		else:
			upgrade_options.append(load("res://Resources/Upgrades/exit_protocol.tres"))
	
	for i in range(3):
		var upgrade_button = get_node("HBoxContainer/UpgradeOption"+str(i+1))
		upgrade_button.upgrade = upgrade_options[i]
		upgrade_button.set_up()

func get_random_upgrade(upgrade_options) -> UpgradeType:
	'
	returns a possible random upgrade type
	
	arguments:
		upgrade_options: the options that are already being shown as an option
	'
	var possible_upgrades := []
	
	for choice in available_upgrades:
		if choice in upgrade_options: # if choice not already an option
			pass
		elif choice in possible_upgrades: # if choice already in list of possible random upgrades
			pass
		elif choice.upgrade in Globals.found_upgrades: # if choice not already picked
			pass
		elif choice.prerequisites.size() > 0: # if there are prerequisites
				for i in choice.prerequisites: # then check if you have them
					if i in Globals.found_upgrades:
						possible_upgrades.append(choice)
		else: # if it passes all those checks
			possible_upgrades.append(choice)
	if possible_upgrades.size() > 0:
		var random_item = possible_upgrades.pick_random()
		return random_item
	else: 
		return null

func refresh():
	'
	called when the refresh button is pressed, relpads the upgrade options 
	and charges the player a increasing amount of a random common item type
	'
	var total = Globals.ItemTypeAttributes[refresh_item_type].total
	
	if Globals.inventory[total] >= refresh_cost:
		Globals.inventory[total] -= refresh_cost
		refresh_cost += 1
		generate_upgrade_choices()
		refresh_item_type = Globals.ItemType.keys()[Globals.common_item_types[randi_range(0, Globals.common_item_types.size()-1)]]
		refresh_button.text = "Refresh: x" +str(refresh_cost)+" "+str(refresh_item_type)

func _ready() -> void:
	'
	sets up everything when the scene loads
	'
	refresh_item_type = Globals.ItemType.keys()[Globals.common_item_types[randi_range(0, Globals.common_item_types.size()-1)]]
	refresh_button.text = "Refresh: x" +str(refresh_cost)+" "+str(refresh_item_type)
	
	for i in DirAccess.get_files_at("res://Resources/Upgrades/"):
		if i != "null_upgrade_type.tres" && i != "exit_protocol.tres":
			available_upgrades.append(load("res://Resources/Upgrades/"+i))


func _process(_delta: float) -> void:
	'
	sets inventory label every frame
	'
	inventory_label.text = get_inventory_label()


func get_inventory_label() -> String:
	'
	returns inventory label
	'
	return  "water: "+str(Globals.inventory.total_water)+"x   scrap metal: "+str(Globals.inventory.total_metal)+"x   co2 canister: "+str(Globals.inventory.total_co2)+"x   Electrical scrap: "+str(Globals.inventory.total_electric)+"x"

func upgrade_picked(upgrade):
	Globals.found_upgrades.append(upgrade.upgrade)

func button_pressed():
	for i in range(3):
		var upgrade_button = get_node("HBoxContainer/UpgradeOption"+str(i+1))
		upgrade_button.different_option_picked = true
