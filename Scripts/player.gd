extends CharacterBody3D

@onready var input_component = %InputComponent
@onready var movement_component = %MovementComponent
@onready var camera_component = %CameraComponent
@onready var interact_component = %InteractComponent
@onready var camera_anims := $CameraAnims

var can_interact := true

func _physics_process(delta: float) -> void:
	# UPDATE INPUTSw
	input_component.tick()
	
	# UPDATE MOVEMENT DIRECTION
	movement_component.direction = input_component.move_dir
	movement_component.sprinting = input_component.sprint_pressed
	# MOVE
	movement_component.tick(delta)
	
	if movement_component.direction == Vector2.ZERO:
		camera_anims.current_animation = "idle"
	else:
		if movement_component.sprinting == false:
			camera_anims.current_animation = "walking"
		else:
			camera_anims.current_animation = "running"

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
