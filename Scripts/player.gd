extends CharacterBody3D

@onready var input_component = %InputComponent
@onready var movement_component = %MovementComponent
@onready var camera_component = %CameraComponent
@onready var interact_component = %InteractComponent
@onready var camera_anims := $CameraAnims
@onready var anim_pivot = $Pivot/AnimPivot
@onready var outside_timer := $OutsideTimer
@onready var timer_component := $TimerComponent

var can_interact := true

const MAX_SWAY = 2.5

func _physics_process(delta: float) -> void:
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
	
	print(Globals.time_left)

# MOUSE MOVEMENT
func on_mouse_movement() -> void:
	camera_component.tick(input_component.mouse_event)

# INTERACT
func on_interact() -> void:
	if can_interact:
		interact_component.try_interact()
		$InteractTimer.start()
		can_interact = false

# LETS PLAYER INTERACT
func _on_interact_timer_timeout() -> void:
	can_interact = true

func outside_timer_run():
	timer_component.outside_timer_run()
