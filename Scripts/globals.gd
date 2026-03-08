extends Node

# TODO ADD ACTUAL RESOURCE TYPES!
enum ItemType { # CONTAINS ALL TYPES OF RESOURCES
	WATER,
	LIGHT,
	DIRT,
}

var inventory := [] # CONTAINS ALL ITEMS

func add_item(type : ItemType):
	'
	Adds an item to the inventory array
	
	Arguments:
		type: the type of item being added
	'
	inventory.append(type)
	

enum LevelID{ # CONTAINS ALL SCENES THAT CAN BE SWITCHED TO
	INSIDE,
	OUTSIDE,
	MAIN_MENU
}


var current_scene = null
func _ready() -> void:
	'
	Sets up game
	- sets current level
	- randomizes seed that random numbers use to generate
	'
	get_tree().scene_changed.connect(done_loading)
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
	randomize()
	

# SCENE CHANGE RELATED
var loaded := false
signal scene_loaded

func done_loading():
	'
	makes sure that the scene is done loading after being switched
	'
	loaded = true

func switch_level(id:LevelID):
	call_deferred("_deferred_switch_scene",id)
	loaded = false
	

func _deferred_switch_scene(id):
	'
	Switches the current scene
	
	Arguments:
		id: the id of the level being switched to
	'
	current_scene.free()
	var new_scene
	match id:
		LevelID.INSIDE: new_scene = load("res://Scenes/inside_world.tscn")
		LevelID.OUTSIDE: 
			new_scene = load("res://Scenes/outside_world.tscn")
			outside_timer_run()
		LevelID.MAIN_MENU:
			new_scene = load("res://Scenes/main_menu.tscn")
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

# TIMER VARIABLES
var timer_length := 10 # Written in seconds
var time_left := 360

func outside_timer_run():
	'
	runs the outside timer
	waits for the scene to load
	'
	await get_tree().create_timer(0.1).timeout
	get_tree().get_first_node_in_group("player").outside_timer_run()
