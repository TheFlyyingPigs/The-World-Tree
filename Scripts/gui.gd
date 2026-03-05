extends Control

@onready var anim := $AnimationPlayer
@onready var alert_label := $AlertPivot/AlertLabel
@onready var crosshair := $Crosshair

var current_screen : Control

func alert(type : Globals.ItemType):
	match type:
		Globals.ItemType.WATER: alert_label.text = "Found  Water" # CHANGE PICTURE / DISPLAY
		# ADD THE REST OF THE RESOURCES
	
	anim.play("alert")

@onready var menus := $Menus
@onready var pause_menu := $Menus/PauseMenu
@onready var main_menu := $Menus/MainMenu
@onready var upgrade_menu

func show_screen(type : Gui.ScreenType):
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
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().paused = false
	
	menus.visible = false
	current_screen.visible = false
	current_screen = null
	
	crosshair.visible = true


func quit() -> void:
	get_tree().quit()
