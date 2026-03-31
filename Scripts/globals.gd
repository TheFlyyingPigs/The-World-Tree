extends Node


enum ItemType { # CONTAINS ALL TYPES OF RESOURCES
	WATER,
	SCRAP_METAL,
	CO2_CANISTER,
	ELETRCICAL_SCRAP,
}

const common_item_types := [ItemType.WATER, ItemType.SCRAP_METAL, ItemType.CO2_CANISTER, ItemType.ELETRCICAL_SCRAP]

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
	"ELETRCICAL_SCRAP":{
		'total'='total_electric',
		'current'='current_electric'
	},
}

var inventory := { # CONTAINS NUMBER OF ALL ITEMS
	'total_water':99,
	'current_water':0,
	
	'total_metal':99,
	'current_metal':0,
	
	'total_co2':99,
	'current_co2':0,
	
	'total_electric':99,
	'current_electric':0,
} 

var total_resources := 0

var found_upgrades := []
var tree_stage := 1
const tree_stages := {
	"stage_1" : preload("res://Assets/Models/Tree/exterior_stage_1.res"),
	"stage_2" : preload("res://Assets/Models/Tree/exterior_stage_2.res"),
	"stage_3" : preload("res://Assets/Models/Tree/exterior_stage_3.res")
}

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
	
	BRIGHTER_SUN_1,
	BRIGHTER_SUN_2,
	BRIGHTER_SUN_3,
	BRIGHTER_SUN_4,
	BRIGHTER_SUN_5,
	
	MORE_BREAD_CRUMBS_1, 
	MORE_BREAD_CRUMBS_2,
	MORE_BREAD_CRUMBS_3,
	MORE_BREAD_CRUMBS_4,
	MORE_BREAD_CRUMBS_5,
	
	MORE_STAMINA_1,
	MORE_STAMINA_2,
	MORE_STAMINA_3,
	MORE_STAMINA_4,
	MORE_STAMINA_5,
	
	BEACON_STRENGTH_1,
	BEACON_STRENGTH_2,
	BEACON_STRENGTH_3,
	BEACON_STRENGTH_4,
	BEACON_STRENGTH_5,
	
	SHORTER_EFFECTS_1,
	SHORTER_EFFECTS_2,
	SHORTER_EFFECTS_3,
	SHORTER_EFFECTS_4,
	SHORTER_EFFECTS_5,
	
	ADDITONAL_RESOURCES_1,
	ADDITONAL_RESOURCES_2,
	ADDITONAL_RESOURCES_3,
	ADDITONAL_RESOURCES_4,
	ADDITONAL_RESOURCES_5,
	
	
	NULL_UPGRADE,
	
	EXIT_PROTOCOL,
}

# UPGRADEABLE VARIABLES
var fog_density := 0.3
var sunlight := 30
var max_bread_crumbs := 15
var beacon_strength := -1
var max_stamina := 30
var additonal_chance := 0.0
var status_effects_shorten := 0


# QUOTA VARIABLES
var day := 0
var quota_num := 1
var quota_requirement := 10
var days_per_quota := 3
var quota_day := 0

func day_end():
	day += 1
	quota_day += 1
	quota_requirement = quota_num * 5 + 5
	if quota_day % (days_per_quota+1) == 0:
		if not total_resources >= quota_requirement:
			failed_quota()
			Gui.show_quota_end_screen()
		else:
			Gui.show_quota_end_screen()
			quota_num += 1
			quota_day = 0
	else:
		Gui.show_day_end_screen()

func failed_quota():
	quota_num = 1
	quota_requirement = 10
	day = 0
	fog_density = 0.3
	sunlight = 0.3
	max_bread_crumbs = 15
	found_upgrades = []
	tree_stage = 1
	
	for item in ItemType:
		inventory[ItemTypeAttributes[item]["total"]] = 0
	
	just_opened_game = true
	

func add_item(type : ItemType):
	'
	Adds an item to the inventory array
	
	Arguments:
		type: the type of item being added
	'
	
	inventory[ItemTypeAttributes[ItemType.keys()[type]]["current"]] += 1
	total_resources += 1
	

func update_inventory(didDie):
	'
	updates inventory dictionary current and total values
	
	arguments:
		didDie: if the player died to cause this scene transition
	'
	if didDie:
		for i in ItemType:
			
			total_resources -= inventory[ItemTypeAttributes[i]["current"]]
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
	if not current_scene == null:
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
			just_opened_game = false
		LevelID.MAIN_MENU:
			new_scene = load("res://Scenes/main_menu.tscn")
			current_scene_id = LevelID.MAIN_MENU
			just_opened_game = true
	
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
	if current_scene_id == LevelID.INSIDE && not just_opened_game:
		day_end()
	if died:
		Gui.alert(true)
		died = false
	


func outside_timer_run():
	'
	runs the outside timer
	waits for the scene to load
	'
	await scene_loaded
	get_tree().get_first_node_in_group("player").outside_timer_run()
