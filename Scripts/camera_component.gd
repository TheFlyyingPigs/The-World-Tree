class_name CameraComponent extends Node

@export var body : CharacterBody3D
@export var camera_pivot : Marker3D

var camera_rotation :=  Vector2(0,0)

const LOWEST_CAMERA_ROTATION = -1.5
const HIGHEST_CAMERA_ROTATION = 1.2

func tick(mouse_movement):
	camera_rotation += mouse_movement
	camera_rotation.y = clamp(camera_rotation.y, LOWEST_CAMERA_ROTATION,HIGHEST_CAMERA_ROTATION)
	
	body.transform.basis = Basis()
	camera_pivot.transform.basis = Basis()
	
	body.rotate_object_local(Vector3(0,1,0), -camera_rotation.x)
	camera_pivot.rotate_object_local(Vector3(1,0,0),-camera_rotation.y)
