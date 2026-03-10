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
	if Globals.loaded:
		gui.alert(type)

func show_screen(type):
	if Globals.loaded:
		gui.show_screen(type)

func screen_shake(intensity, time):
	if Globals.loaded:
		camera.screen_shake(intensity,time)

func update_timer_bar():
	if Globals.loaded:
		gui.update_timer_bar()

func update_stamina_bar(value):
	if Globals.loaded:
		gui.update_stamina_bar(value)

func fade_out():
	if Globals.loaded:
		gui.fade_out()

func fade_in():
	if Globals.loaded:
		gui.fade_in()
