extends Node

'
passes on functions to the gui.gd script
so they can be used globally
'

enum ScreenType{ # CONTAINS ALL TYPES OF MENUS/SCREENS
	PAUSE,
	MAIN_MENU,
	UPGRADE
}

@onready var gui 
@onready var camera 

func scene_switched():
	'
	set the variables every time the scene is switched
	'
	gui = get_tree().get_first_node_in_group("gui")
	camera = get_tree().get_first_node_in_group("camera_comp")


func alert(type):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.alert(type)

func show_screen(type):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.show_screen(type)

func screen_shake(intensity, time):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		camera.screen_shake(intensity,time)

func update_timer_bar():
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.update_timer_bar()

func update_stamina_bar(value):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.update_stamina_bar(value)

func fade_out():
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.fade_out()

func fade_in():
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.fade_in()

func set_crosshair_color(color:Color):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.set_crosshair_color(color)

func update_crumbs_bar(value):
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.update_crumbs_bar(value)

func show_quota_end_screen():
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.show_quota_end_screen()

func show_day_end_screen():
	if Globals.loaded && not Globals.current_scene_id == Globals.LevelID.MAIN_MENU:
		gui.show_day_end_screen()
