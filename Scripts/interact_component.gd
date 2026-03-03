class_name InteractComponent extends Node

@export var raycast : RayCast3D

var body : StaticBody3D

func try_interact():
	if raycast.is_colliding():
		# CAUSED A CRASH ONCE, THIS LINE IS JUST INCASE
		if raycast.get_collider() != null:
			body = raycast.get_collider()
			if body.has_method("interact"):
				body.interact()
