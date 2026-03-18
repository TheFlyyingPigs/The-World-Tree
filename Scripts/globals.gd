extends Node

# TODO ADD ACTUAL RESOURCE TYPES!
enum ItemType { # CONTAINS ALL TYPES OF RESOURCES
	WATER,
	SCRAP_METAL,
	CO2_CANISTER,
	LIGHT_CRYSTAL,
	ELETRCICAL_SCRAP,
	SOUL_ESSENCE
}
# TODO ADD ACTUAL COMMON RESOURCES
const common_item_types := [ItemType.WATER, ItemType.SCRAP_METAL, ItemType.CO2_CANISTER]
const rare_item_types := [ItemType.LIGHT_CRYSTAL,ItemType.ELETRCICAL_SCRAP,ItemType.SOUL_ESSENCE]

const ItemTypeAttributes = { # ATTRIBUTES FOR THE ITEMTYPE ENUM
	"WATER":{
		'total'='total_water',
		'current'='current_water'
	},
	"SCRAP_METAL":{
		'total'='total_metal',
		'current'='current_metal'
	},
	"CO2_CANISTER":{
		'total'='total_co2',
		'current'='current_co2'
	},
	"LIGHT_CRYSTAL":{
		'total'='total_light',
		'current'='current_light'
	},
	"ELETRCICAL_SCRAP":{
		'total'='total_electric',
		'current'='current_electric'
	},
	"SOUL_ESSENCE":{
		'total'='total_soul',
		'current'='current_soul'
	},
}

var inventory := { # CONTAINS NUMBER OF ALL ITEMS
	'total_water':99,
	'current_water':0,
	
	'total_metal':99,
	'current_metal':0,
	
	'total_co2':99,
	'current_co2':0,
	
	'total_light':99,
	'current_light':0,
	
	'total_electric':99,
	'current_electric':0,
	
	'total_soul':99,
	'current_soul':0,
} 

var found_upgrades := []

# SCENE CHANGE IDENTIFIERS
var current_scene = null
var loaded := false
signal scene_loaded
var died := false
var current_scene_id : LevelID
var just_opened_game := true

enum LevelID{ # CONTAINS ALL SCENES THAT CAN BE SWITCHED TO
	INSIDE,
	OUTSIDE,
	MAIN_MENU
}

# TIMER VARIABLES
var timer_length := 120 # Written in seconds
var time_left := 360

# UPGRADE GLOBAL VARS
enum Upgrades{
	FOG_DENSITY_1,
	FOG_DENSITY_2,
	FOG_DENSITY_3,
	FOG_DENSITY_4,
	FOG_DENSITY_5,
	
	LONGER_TIMER_1,
	LONGER_TIMER_2,
	LONGER_TIMER_3,
	LONGER_TIMER_4,
	LONGER_TIMER_5,
	
	#TODO ADD LESS HAZARDS AND MORE RESOURCES UPGRADES!
	
	BRIGHTER_SUN_1,
	BRIGHTER_SUN_2,
	BRIGHTER_SUN_3,
	BRIGHTER_SUN_4,
	BRIGHTER_SUN_5,
	
	MORE_BREAD_CRUMBS_1, # TODO CHANGE BREAD CRUMB TO REAL NAME
	MORE_BREAD_CRUMBS_2,
	MORE_BREAD_CRUMBS_3,
	MORE_BREAD_CRUMBS_4,
	MORE_BREAD_CRUMBS_5,
	
}

# UPGRADEABLE VARIABLES
var fog_density := 0.4
var sunlight := 0.3
var max_bread_crumbs := 15

func add_item(type : ItemType):
	'
	Adds an item to the inventory array
	
	Arguments:
		type: the type of item being added
	'
	
	inventory[ItemTypeAttributes[ItemType.keys()[type]]["current"]] += 1
	
	

func update_inventory(didDie):
	'
	updates inventory dictionary current and total values
	
	arguments:
		didDie: if the player died to cause this scene transition
	'
	if didDie:
		for i in ItemType:
			
			inventory[ItemTypeAttributes[i]["current"]] = 0
			
	else:
		for i in ItemType:
			
			var current = inventory[ItemTypeAttributes[i]["current"]]
			
			inventory[ItemTypeAttributes[i]["total"]] += current
			inventory[ItemTypeAttributes[i]["current"]] = 0
			

func _ready() -> void:
	'
	Sets up game
	- sets current level
	- randomizes seed that random numbers use to generate
	'
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
	randomize()
	


func switch_level(id:LevelID,didDie):
	call_deferred("_deferred_switch_scene",id)
	loaded = false
	update_inventory(didDie)


func _deferred_switch_scene(id):
	'
	Switches the current scene
	
	Arguments:
		id: the id of the level being switched to
	'
	current_scene.free()
	var new_scene
	match id:
		LevelID.INSIDE: 
			new_scene = load("res://Scenes/inside_world.tscn")
			current_scene_id = LevelID.INSIDE
		LevelID.OUTSIDE: 
			new_scene = load("res://Scenes/outside_world.tscn")
			outside_timer_run()
			current_scene_id = LevelID.OUTSIDE
		LevelID.MAIN_MENU:
			new_scene = load("res://Scenes/main_menu.tscn")
			current_scene_id = LevelID.MAIN_MENU
	
	current_scene = new_scene.instantiate()
	current_scene.ready.connect(scene_initialized)
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene


func scene_initialized():
	'
	sends a signal when the scene is fully loaded
	'
	Gui.scene_switched()
	StatusEffects.scene_switched()
	loaded = true
	scene_loaded.emit()
	Gui.fade_in()
	if current_scene_id == LevelID.INSIDE && not just_opened_game && not died:
		Gui.show_screen(Gui.ScreenType.UPGRADE)
	if died:
		Gui.alert(true)
		died = false
	just_opened_game = false


func outside_timer_run():
	'
	runs the outside timer
	waits for the scene to load
	'
	await scene_loaded
	get_tree().get_first_node_in_group("player").outside_timer_run()
