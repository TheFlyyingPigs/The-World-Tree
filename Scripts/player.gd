extends CharacterBody3D

@onready var input_component = %InputComponent
@onready var movement_component = %MovementComponent
@onready var camera_component = %CameraComponent


func _physics_process(delta: float) -> void:
	# UPDATE INPUTS
	input_component.tick()
	
	# UPDATE MOVEMENT DIRECTION
	movement_component.direction = input_component.move_dir
	movement_component.sprinting = input_component.sprint_pressed
	# MOVE
	movement_component.tick(delta)

func on_mouse_movement() -> void:
	camera_component.tick(input_component.mouse_event)
