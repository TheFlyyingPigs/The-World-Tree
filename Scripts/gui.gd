extends Control

@onready var timer_bar := %TimerProgress

func update_timer_bar():
	timer_bar.max_value = Globals.timer_length
	timer_bar.value = Globals.time_left


func alert(type : Globals.ItemType):
	var anim := %AnimationPlayer
	var alert_label := %AlertLabel
	match type:
		Globals.ItemType.WATER: alert_label.text = "Found  Water" # CHANGE PICTURE / DISPLAY
		# ADD THE REST OF THE RESOURCES
	
	anim.play("alert")


var current_screen : Control

func show_screen(type : Gui.ScreenType):
	var crosshair := %Crosshair
	var menus := %Menus
	var pause_menu := %PauseMenu
	var main_menu := %MainMenu
	var upgrade_menu
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	menus.visible = true
	crosshair.visible = false
	get_tree().paused = true
	match type:
		Gui.ScreenType.PAUSE: 
			pause_menu.visible = true
			current_screen = pause_menu
		Gui.ScreenType.MAIN_MENU: 
			main_menu.visible = true
			current_screen = main_menu
		Gui.ScreenType.UPGRADE: 
			upgrade_menu.visible = true
			current_screen = upgrade_menu
	


func resume() -> void:
	var crosshair := %Crosshair
	var menus := %Menus
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().paused = false
	
	menus.visible = false
	current_screen.visible = false
	current_screen = null
	
	crosshair.visible = true


func quit() -> void:
	get_tree().quit()
