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
@onready var crumbs_label: Label = %CrumbsLabel

@onready var timer_bar := %TimerProgress
@onready var stamina_bar := %StaminaProgress
@onready var anim := %AlertPlayer
@onready var alert_label := %AlertLabel

@onready var quota_end_screen: Control = $CanvasLayer/QuotaEndScreen
@onready var quota_title_label: Label = $CanvasLayer/QuotaEndScreen/TitleLabel
@onready var quota_resources_found_label: Label = $CanvasLayer/QuotaEndScreen/ResourcesFoundLabel

@onready var day_end_screen: Control = $CanvasLayer/DayEndScreen
@onready var day_title_label: Label = $CanvasLayer/DayEndScreen/DayTitleLabel
@onready var day_resources_found_label: Label = $CanvasLayer/DayEndScreen/DayResourcesFoundLabel


signal upgrade_menu_opened
signal end_screen_gone

func _ready() -> void:
	$CanvasLayer/BlackScreen.color = Color(0,0,0,1)


func update_timer_bar():
	'
	updates the progress bar for the outside timer
	'
	timer_bar.max_value = Globals.timer_length
	timer_bar.value = Globals.time_left

func update_crumbs_bar(value):
	'
	updates the progress bar for the amount of crumbs left to a given value
	arguments: value: the new value of the bar
	'
	crumbs_label.text = str(value)+"x"
	

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
	menus.visible = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	crosshair.visible = false
	get_tree().paused = true
	match type:
		Gui.ScreenType.PAUSE: 
			pause_menu.visible = true
			current_screen = pause_menu
		Gui.ScreenType.UPGRADE: 
			await end_screen_gone
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

func show_day_end_screen():
	day_end_screen.visible = true
	get_tree().paused = true
	day_title_label.text = "Day "+str(Globals.day)+ " End"
	day_resources_found_label.text = str(Globals.total_resources)+" / "+str(Globals.quota_requirement)+" Resource Found"
	
	await get_tree().create_timer(2).timeout
	day_end_screen.visible = false
	
	end_screen_gone.emit()

func show_quota_end_screen():
	quota_end_screen.visible = true
	get_tree().paused = true
	if Globals.quota_requirement <= Globals.total_resources:
		quota_title_label.text = "Quota "+str(Globals.quota_num)+ " Completed"
	else:
		quota_title_label.text = "Quota "+str(Globals.quota_num)+ " Failed"
	quota_resources_found_label.text = str(Globals.total_resources)+" / "+str(Globals.quota_requirement)+" Resource Found"
	
	await get_tree().create_timer(2).timeout
	quota_end_screen.visible = false
	
	end_screen_gone.emit()
	
	if not Globals.quota_requirement <= Globals.total_resources:
		get_tree().paused = false
		Globals.switch_level(Globals.LevelID.MAIN_MENU, false)
