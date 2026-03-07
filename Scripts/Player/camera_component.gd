class_name CameraComponent extends Node
'
handles the camera;
moving 
camera shake
'

# EXPORT VARIABLES
@export var body : CharacterBody3D
@export var camera_pivot : Marker3D
@export var camera : Camera3D

# VARIABLES
var camera_rotation :=  Vector2(0,0)

# CONSTANTS
const LOWEST_CAMERA_ROTATION = -1.5
const HIGHEST_CAMERA_ROTATION = 1.2

func tick(mouse_movement):
	'
	process for moving camera
	
	arguments:
		mouse_movement: the mouse movement event
	'
	camera_rotation += mouse_movement
	camera_rotation.y = clamp(camera_rotation.y, LOWEST_CAMERA_ROTATION,HIGHEST_CAMERA_ROTATION)
	
	body.transform.basis = Basis()
	camera_pivot.transform.basis = Basis()
	
	body.rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	camera_pivot.rotate_object_local(Vector3(1,0,0),-camera_rotation.y)

# CAMERA SHAKE VARS
var shake_intensity := 0.0
var active_shake_time := 0.0
var shake_decay := 2.0
var shake_time := 0.0
var shake_time_speed := 20.0
var noise := FastNoiseLite.new()

func screen_shake(intensity, time):
	'
	sets the values of camera shake
	
	arguments:
		intensity: the intensity of cameara shake
		time: the time the camera shake lasts (not in seconds, just trial and error it)
	'
	noise.seed = randi()
	noise.frequency = 2.0
	
	shake_intensity = intensity
	active_shake_time = time
	shake_time = 0.0

func _physics_process(delta: float) -> void:
	'
	shakes the camera and brings it back to no offset
	'
	if active_shake_time > 0:
		shake_time += delta * shake_time_speed
		active_shake_time -= delta
		
		camera.h_offset = noise.get_noise_2d(shake_time,0)*shake_intensity
		camera.v_offset = noise.get_noise_2d(0,shake_time) * shake_intensity
		
		shake_intensity = max(shake_intensity - shake_decay * delta, 0)
