extends Control
'
the display and button for an upgrade type
'
@export var upgrade : UpgradeType

@onready var name_label: Label = $AnimPivot/Name_Label
@onready var description_label: Label = $AnimPivot/Description_Label
@onready var cost_label: Label = $AnimPivot/Cost_Label
@onready var icon: TextureRect = $AnimPivot/Icon
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var set_up_player: AnimationPlayer = $SetUpPlayer


signal upgrade_selected(upgrade)

@onready var total_type_1 = Globals.ItemTypeAttributes[Globals.ItemType.keys()[upgrade.cost_1_type]].total
@onready var total_type_2 = Globals.ItemTypeAttributes[Globals.ItemType.keys()[upgrade.cost_2_type]].total

func _ready() -> void:
	set_up()

func set_up():
	'
	sets up a new upgrade card
	'
	set_up_player.current_animation = "appear"
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
	'
	called when the upgrade is clicked
	checks if player can buy upgrade
	'
	if Globals.inventory[total_type_1] > upgrade.cost_1:
		if upgrade.second_cost:
			if Globals.inventory[total_type_2] > upgrade.cost_2:
				on_upgrade_selected()
			else:
				animation_player.current_animation = "failed_buying"
		else:
			on_upgrade_selected()
	else:
		animation_player.current_animation = "failed_buying"

func on_upgrade_selected():
	'
	emits upgrade selected and pays resource costs
	'
	upgrade_selected.emit(upgrade)
	
	Globals.inventory[total_type_1] -= upgrade.cost_1
	if upgrade.second_cost:
		Globals.inventory[total_type_2] -= upgrade.cost_2


func _on_mouse_hovering() -> void:
	animation_player.current_animation = "hovering"


func _on_mouse_not_hovering() -> void:
	animation_player.current_animation = "not_hovering"
