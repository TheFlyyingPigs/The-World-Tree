class_name MovementComponent extends Node
'
Defines the movement for the player character
'

# EXPORT VARIABLES
@export var body : CharacterBody3D
@export var walking_speed := 145.0
@export var sprinting_speed := 220.0
@export var air_control := 1.0

# VARIABLES
var direction : Vector2
var sprinting := false

func tick(delta :float) -> void:
	'
	The process of the movement component
	'
	var normalized_direction = (body.transform.basis * Vector3(direction.x,0,direction.y)).normalized()
	
	body.velocity.x = normalized_direction.x * get_speed() * delta
	body.velocity.z = normalized_direction.z * get_speed() * delta
	
	if not body.is_on_floor():
		body.velocity.y = body.get_gravity().y * delta
	
	body.move_and_slide()

func get_speed() -> float:
	'
	Returns the current speed of the player
	'
	if sprinting:
		if body.is_on_floor():
			return sprinting_speed
		else:
			return sprinting_speed/air_control
	else:
		if body.is_on_floor():
			return walking_speed
		else:
			return walking_speed/air_control
