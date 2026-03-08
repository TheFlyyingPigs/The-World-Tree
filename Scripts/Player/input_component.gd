class_name InputComponent extends Node
'
handles all inputs
'
# MOVEMENT VARIABLES
var move_dir := Vector2.ZERO
var sprint_pressed := false

# MOUSE VARIABLES
@export var mouse_sens := 0.0015
signal mouse_movement
var mouse_event : Vector2

# SIGNALS
signal interact

func tick():
	'
	processes the movement direction
	'
	move_dir = Input.get_vector("move_left","move_right","move_forward","move_backward")
	sprint_pressed = Input.is_action_pressed("sprint")

func _input(event: InputEvent) -> void:
	'
	handles the input events
	'
	if event is InputEventMouseMotion  && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		mouse_movement.emit()
		mouse_event = event.relative * mouse_sens
	
	if Input.is_action_just_pressed("interact"):
		interact.emit()
	
	if Input.is_action_just_pressed("ui_cancel"):
		Gui.show_screen(Gui.ScreenType.PAUSE)
	
