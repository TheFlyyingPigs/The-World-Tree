class_name TimerComponent extends Node
'
handles the outside timer
'

@export var timer : Timer
signal outside_timeout

func outside_timer_run():
	'
	runs the outside timer and sets its length to the Global var
	'
	Globals.time_left = Globals.timer_length
	timer.start()


func _on_timeout() -> void:
	'
	updates global time_left var and gui progress bar
	and emits a timeout if globals time_left is less than or equal to 0
	'
	Globals.time_left -= 1 + StatusEffects.final_poison_damage
	Gui.update_timer_bar()
	
	if Globals.time_left <= 0:
		outside_timeout.emit()
		Globals.time_left = Globals.timer_length
		timer.stop()
