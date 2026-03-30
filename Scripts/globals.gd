extends Node

# ADD ACTUAL RESOURCE TYPES!
enum ItemType {
	WATER,
	LIGHT,
	DIRT,
}

var inventory := []

func add_item(type : ItemType):
	inventory.append(type)
	

enum LevelID{
	INSIDE,
	OUTSIDE
}

var current_scene = null
func _ready() -> void:
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count()-1)
	
	Gui.show_screen(Gui.ScreenType.MAIN_MENU)
	randomize()


func switch_level(id:LevelID):
	call_deferred("_deferred_switch_scene",id)	

func _deferred_switch_scene(id):
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

var timer_length := 360
var time_left := 360

func outside_timer_run():
	await get_tree().create_timer(0.1).timeout
	get_tree().get_first_node_in_group("player").outside_timer_run()
