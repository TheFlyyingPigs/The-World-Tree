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

# VARIABLES
var can_interact := true

# CONSTANTS
const MAX_SWAY = 2.5

func _physics_process(delta: float) -> void:
	'
	processes the components that need to happen every frame
	'
	# UPDATE INPUTSw
	input_component.tick()
	
	# UPDATE MOVEMENT DIRECTION
	movement_component.direction = input_component.move_dir
	movement_component.sprinting = input_component.sprint_pressed
	# MOVE
	movement_component.tick(delta)
	
	# CAMERA BOB
	if movement_component.direction == Vector2.ZERO:
		camera_anims.current_animation = "idle"
	else:
		if movement_component.sprinting == false:
			camera_anims.current_animation = "walking"
		else:
			camera_anims.current_animation = "running"
	
	# CAMERA SWAY
	if input_component.move_dir.x > 0:
		anim_pivot.rotation.z = lerp_angle(anim_pivot.rotation.z,deg_to_rad(-MAX_SWAY), 0.035)
	elif input_component.move_dir.x < 0:
		anim_pivot.rotation.z = lerp_angle(anim_pivot.rotation.z,deg_to_rad(MAX_SWAY), 0.035)
	else:
		anim_pivot.rotation.z = lerp_angle(anim_pivot.rotation.z,deg_to_rad(0), 0.035)
	

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
