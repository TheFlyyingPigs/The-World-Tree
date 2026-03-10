extends Node

# TODO ADD ACTUAL RESOURCE TYPES!
enum ItemType { # CONTAINS ALL TYPES OF RESOURCES
	WATER,
	LIGHT,
	DIRT,
	
	DIED, # NOT A RESOURCE TYPE, USED FOR ALERTS WHEN PLAYER DIED
}

var inventory := [] # CONTAINS ALL ITEMS
var found_this_run := [] # CONTAINS ALL ITEMS FOUND THIS RUN

# SCENE CHANGE IDENTIFIERS
var current_scene = null
var loaded := false
signal scene_loaded
var died := false
var current_scene_id : LevelID

enum LevelID{ # CONTAINS ALL SCENES THAT CAN BE SWITCHED TO
	INSIDE,
	OUTSIDE,
	MAIN_MENU
}

# TIMER VARIABLES
var timer_length := 120 # Written in seconds
var time_left := 360


func add_item(type : ItemType):
	'
	Adds an item to the inventory array
	
	Arguments:
		type: the type of item being added
	'
	found_this_run.append(type)
	inventory.append(type)
	


func _ready() -> void:
	'
	Sets up game
	- sets current level
	- randomizes seed that random numbers use to generate
	'
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
	randomize()
	


func switch_level(id:LevelID):
	call_deferred("_deferred_switch_scene",id)
	loaded = false
	found_this_run.clear()

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
	loaded = true
	scene_loaded.emit()
	Gui.fade_in()
	if died:
		Gui.alert(Globals.ItemType.DIED)
		died = false


func outside_timer_run():
	'
	runs the outside timer
	waits for the scene to load
	'
	await scene_loaded
	get_tree().get_first_node_in_group("player").outside_timer_run()
