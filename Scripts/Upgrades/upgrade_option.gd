extends Control
'
the display and button for an upgrade type
'
@export var upgrade : UpgradeType

@onready var name_label: Label = $Name_Label
@onready var description_label: Label = $Description_Label
@onready var icon: TextureRect = $Icon
@onready var cost_label: Label = $Cost_Label

signal upgrade_selected(upgrade)

func _ready() -> void:
	set_up()

func set_up():
	'
	sets up a new upgrade card
	'
	name_label.text = upgrade.display_name
	description_label.text = upgrade.description
	icon.texture = upgrade.icon
	cost_label.text = get_cost_label()

func get_cost_label() -> String:
	'
	returns the label for the cost of the upgrade
	returns String
	'
	if upgrade.second_cost:
		return str(upgrade.cost_1)+"x "+ str(Globals.ItemType.keys()[upgrade.cost_1_type]) + "
		" + str(upgrade.cost_2)+"x "+str(Globals.ItemType.keys()[upgrade.cost_2_type])
	
	else:
		return str(upgrade.cost_1)+"x "+ str(Globals.ItemType.keys()[upgrade.cost_1_type])
	


func button_pressed():
	upgrade_selected.emit(upgrade)
