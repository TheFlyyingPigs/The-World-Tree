class_name SpawningComponent extends Node
'
handles throwing and spawning a given packedscene
'

@export var spawned_object : PackedScene
@export var body : CharacterBody3D

func spawn():
	'
	spawns a new version of the given packedscene at the bodys global pos 
	'
	if spawned_object != null:
		var new_object = spawned_object.instantiate()
		get_tree().current_scene.add_child(new_object)
		
		new_object.global_position = body.global_position
	else:
		print_debug("cant spawn null object")
