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
	OUTSIDE
}

var current_scene = null
func _ready() -> void:
	'
	Sets up game
	- sets current level
	- shows main menu
	- randomizes seed that random numbers use to generate
	'
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
	Gui.show_screen(Gui.ScreenType.MAIN_MENU)
	randomize()


func switch_level(id:LevelID):
	call_deferred("_deferred_switch_scene",id)
	

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
	current_scene = new_scene.instantiate()
	get_tree().root.add_child(current_scene)
	get_tree().current_scene = current_scene

# TIMER VARIABLES
var timer_length := 360 # Written in seconds
var time_left := 360

func outside_timer_run():
	'
	runs the outside timer
	waits for the scene to load
	'
	await get_tree().create_timer(0.1).timeout
	get_tree().get_first_node_in_group("player").outside_timer_run()
