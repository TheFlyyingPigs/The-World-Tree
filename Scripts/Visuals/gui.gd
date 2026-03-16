extends Control
'
handles the gui actions
'

# VARIABLES
var current_screen : Control

@onready var crosshair := %Crosshair
@onready var menus := %Menus
@onready var pause_menu := %PauseMenu
@onready var upgrade_menu := %UpgradeMenu

@onready var timer_bar := %TimerProgress
@onready var stamina_bar := %StaminaProgress
@onready var anim := %AlertPlayer
@onready var alert_label := %AlertLabel

signal upgrade_menu_opened

func _ready() -> void:
	$CanvasLayer/BlackScreen.color = Color(0,0,0,1)


func update_timer_bar():
	'
	updates the progress bar for the outside timer
	'
	timer_bar.max_value = Globals.timer_length
	timer_bar.value = Globals.time_left


func update_stamina_bar(value):
	'
	updates the progress bar for stamina
	arguments:
		value: the stamina value the bar should update to
	'
	create_tween().tween_property(stamina_bar,"value",value,0.075)

func fade_out():
	'
	fades screen to black
	'
	%ScreenFader.play("fade_out")

func fade_in():
	'
	fades screen from black
	'
	%ScreenFader.play("fade_in")


func alert(type : ):
	'
	shows an alert for an item being picked
	
	arguments:
		type: the type of item being picked up
	'
	
	match type:
		Globals.ItemType.WATER: alert_label.text = "Found Water" 
		Globals.ItemType.SCRAP_METAL: alert_label.text = "Found scrap metal"
		Globals.ItemType.CO2_CANISTER: alert_label.text = "Found Co2 canister"
		Globals.ItemType.LIGHT_CRYSTAL: alert_label.text = "Found Light Crystal"
		Globals.ItemType.ELETRCICAL_SCRAP: alert_label.text = "Found Electrical Scrap"
		Globals.ItemType.SOUL_ESSENCE: alert_label.text = "Found Soul essence"
		true: alert_label.text = "Lost all on-hand resources"
	
	anim.play("alert")



func show_screen(type : Gui.ScreenType):
	'
	shows a screen
	
	arguments: 
		type: the screen to show
	'
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	menus.visible = true
	crosshair.visible = false
	get_tree().paused = true
	match type:
		Gui.ScreenType.PAUSE: 
			pause_menu.visible = true
			current_screen = pause_menu
		Gui.ScreenType.UPGRADE: 
			upgrade_menu_opened.emit()
			upgrade_menu.visible = true
			current_screen = upgrade_menu
			Input.warp_mouse(Vector2(950,850))

func set_crosshair_color(color:Color):
	'
	sets the crosshairs color to a given variable
	arguments: color: the color to change the crosshair to
	'
	crosshair.modulate = color

func resume() -> void:
	'
	unpauses the game
	'
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	get_tree().paused = false
	
	menus.visible = false
	current_screen.visible = false
	current_screen = null
	
	crosshair.visible = true


func quit() -> void:
	'
	quits the game
	'
	get_tree().quit()
