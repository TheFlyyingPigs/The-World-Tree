extends CharacterBody3D


# ONREADY VARIABLES
@onready var input_component = %InputComponent
@onready var movement_component = %MovementComponent
@onready var camera_component = %CameraComponent
@onready var interact_component = %InteractComponent
@onready var camera_anims := $CameraAnims
@onready var anim_pivot = $Pivot/AnimPivot
@onready var outside_timer := $OutsideTimer
@onready var timer_component := $TimerComponent
@onready var camera_bob_component := $CameraBobComponent

# VARIABLES
var can_interact := true
var motion_overide := false


func _physics_process(delta: float) -> void:
	'
	processes the components that need to happen every frame
	'
	# UPDATE INPUTS
	input_component.tick()
	
	if not motion_overide:
		# UPDATE MOVEMENT DIRECTION
		movement_component.direction = input_component.move_dir
		movement_component.sprinting = input_component.sprint_pressed
		# MOVE
		movement_component.tick(delta)
		
		# CAMERA BOB AND SWAY
		camera_bob_component.tick()

# MOUSE MOVEMENT
func on_mouse_movement() -> void:
	'
	processes the camera_component
	'
	camera_component.tick(input_component.mouse_event)

# INTERACT
func on_interact() -> void:
	'
	Checks if you are looking at an interactable object,
	then interacts with it
	'
	if can_interact:
		interact_component.try_interact()
		$InteractTimer.start()
		can_interact = false

# LETS PLAYER INTERACT
func _on_interact_timer_timeout() -> void:
	'
	lets player interact after 0.5 seconds
	'
	can_interact = true

func outside_timer_run():
	'
	passes outside_timer_run() to the timer_component
	'
	timer_component.outside_timer_run()


func died() -> void:
	'
	runs the dying anim
	'
	motion_overide = true
	camera_anims.play("die")


func reset_motion_overide():
	'
	lets the player continue to move
	'
	motion_overide = false
