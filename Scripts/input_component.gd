class_name InputComponent extends Node

var move_dir := Vector2.ZERO
var sprint_pressed := false

func tick():
	move_dir = Input.get_vector("move_backward","move_forward","move_left","move_right")
	sprint_pressed = Input.is_action_just_pressed("sprint")
