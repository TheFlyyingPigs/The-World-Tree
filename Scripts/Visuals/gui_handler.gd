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

func alert(type):
	var gui := get_tree().get_first_node_in_group("gui")
	gui.alert(type)

func show_screen(type):
	var gui := get_tree().get_first_node_in_group("gui")
	gui.show_screen(type)

func screen_shake(intensity, time):
	var camera :CameraComponent= get_tree().get_first_node_in_group("camera_comp")
	camera.screen_shake(intensity,time)

func update_timer_bar():
	var gui := get_tree().get_first_node_in_group("gui")
	gui.update_timer_bar()
