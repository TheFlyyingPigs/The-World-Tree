class_name TimerComponent extends Node

@export var timer : Timer

func outside_timer_run():
	timer.wait_time = Globals.timer_length
	timer.start()

func _process(_delta: float) -> void:
	Globals.time_left = int(timer.time_left)
	Gui.update_timer_bar()
