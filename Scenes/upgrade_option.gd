extends Control

@onready var name_label := $Name_Label
@onready var description_label := $Description_Label
@onready var icon := $Icon

var id : UpgradeManager.Upgrades

signal upgrade_selected(id)

func _ready() -> void:
	var upgrade = UpgradeManager.UpgradeAttributes[id]
	
	name_label.text = upgrade.display_name
	icon.texture = upgrade.icon
	description_label.text = upgrade.description


func button_pressed() -> void:
	upgrade_selected.emit(id)
