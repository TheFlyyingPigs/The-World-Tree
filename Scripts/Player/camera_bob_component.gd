class_name CameraBobComponent extends Node
'
handles code for camera bob and camera sway
'

# EXPORT VARIABLES
@export var camera_anims : AnimationPlayer
@export var anim_pivot : Marker3D
@export var movement_component : MovementComponent
@export var input_component : InputComponent

# CONSTANTS
const MAX_SWAY = 2.5

func tick():
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
