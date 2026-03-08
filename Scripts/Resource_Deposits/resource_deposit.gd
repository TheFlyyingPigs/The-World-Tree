class_name ResourceDeposit extends StaticBody3D
'
gives the player a specified resource when interacted with
'
@export var deposit_type : DepositType
@onready var particles := %GPUParticles3D
@onready var mesh := %MeshInstance3D
@onready var collision := %CollisionShape3D
@onready var animation := %AnimationPlayer

func _ready() -> void:
	'
	sets up the mesh, collision, particles, and material
	'
	particles.emitting = false
	var material = StandardMaterial3D.new()
	material.albedo_color = deposit_type.particle_color
	particles.draw_pass_1.surface_set_material(0, material)
	mesh.mesh = deposit_type.mesh
	mesh.set_surface_override_material(0, deposit_type.mesh_material)
	collision.shape = deposit_type.collision_shape

func interact():
	'
	disappears when interacted with
	and gives player specified resource
	'
	Globals.add_item(deposit_type.resource_type)
	animation.play("break")
	Gui.screen_shake(0.45,0.5)
	Gui.alert(deposit_type.resource_type)
