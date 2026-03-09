class_name TimerComponent extends Node
'
handles the outside timer
'

@export var timer : Timer

func outside_timer_run():
	'
	runs the outside timer and sets its length to the Global var
	'
	timer.wait_time = Globals.timer_length
	timer.start()

func _process(_delta: float) -> void:
	'
	updates global time_left var and gui progress bar
	'
	if Globals.current_scene_id == Globals.LevelID.OUTSIDE:
		Globals.time_left = int(timer.time_left)
	else:
		Globals.time_left = Globals.timer_length
	Gui.update_timer_bar()
