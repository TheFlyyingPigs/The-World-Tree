class_name MovementComponent extends Node

@export var body : CharacterBody3D
@export var speed := 2.5
@export var sprinting_speed := 5.5

var direction : Vector2
var sprinting := false

func tick(delta :float) -> void:
	var normalized_direction = (body.transform.basis * Vector3(direction.x,0,direction.y)).normalized()
	
	body.velocity.x = normalized_direction.x * get_speed()
	body.velocity.z = normalized_direction.z * get_speed()
	
	body.move_and_slide()

func get_speed() -> float:
	if sprinting:
		return sprinting_speed
	else:
		return speed
