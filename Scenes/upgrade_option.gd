extends Control
'
an upgrade option, randomly picks one upgrade
'

@onready var name_label := $Name_Label
@onready var description_label := $Description_Label
@onready var icon := $Icon

var id 

signal upgrade_selected(id)

func _ready() -> void:
	set_up()
	
	upgrade_selected.connect(UpgradeManager.apply_upgrade)

func set_up():
	'
	sets up a new upgrade option
	'
	var random_upgrade = randi_range(0, UpgradeManager.Upgrades.size() - 1)
	id = UpgradeManager.Upgrades.keys()[random_upgrade]
	
	var upgrade = UpgradeManager.UpgradeAttributes[id]
	
	name_label.text = upgrade.display_name
	icon.texture = upgrade.icon
	description_label.text = upgrade.description



func button_pressed() -> void:
	'
	emits the upgrade selected signal
	'
	upgrade_selected.emit(id)
