class_name UpgradeType extends Resource
'
resource that contains all information that an upgrade needs
'
# visual variables
@export var icon : Texture
@export var display_name := ""
@export_multiline var description := ""

# upgrade variables
@export var upgrade : Globals.Upgrades
@export var prerequisites : Array[Globals.Upgrades] = []

# cost variables
@export var cost_1_type : Globals.ItemType
@export var cost_1 := 0
@export var second_cost := false
@export var cost_2_type : Globals.ItemType
@export var cost_2 := 0
