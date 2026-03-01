extends CharacterBody3D

@onready var input_component = %InputComponent

func _physics_process(delta: float) -> void:
	# UPDATE INPUTS
	input_component.tick()
	
