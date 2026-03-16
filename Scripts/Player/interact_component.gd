class_name InteractComponent extends Node
'
handles raycast
'

# VARIABLES
@export var raycast : RayCast3D

var body : StaticBody3D

func try_interact():
	'
	attempts to interact with the object being seen by the raycast
	'
	if raycast.is_colliding():
		# CAUSED A CRASH ONCE, THIS LINE IS JUST INCASE
		if raycast.get_collider() != null:
			body = raycast.get_collider()
			if body.has_method("interact"):
				body.interact()

func _process(_delta: float) -> void:
	'
	sets the crosshairs color if it sees something
	'
	if raycast.is_colliding():
		Gui.set_crosshair_color(Color(1,0,0.25,1))
	else:
		Gui.set_crosshair_color(Color(1,1,1,1))
