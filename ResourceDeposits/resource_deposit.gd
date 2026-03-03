class_name ResourceDeposit
extends StaticBody3D

@export var deposit_type : DepositType

func _ready() -> void:
	$GPUParticles3D.emitting = false
	var material = StandardMaterial3D.new()
	material.albedo_color = deposit_type.particle_color
	$GPUParticles3D.draw_pass_1.surface_set_material(0, material)
	$MeshInstance3D.mesh = deposit_type.mesh
	$MeshInstance3D.set_surface_override_material(0, deposit_type.mesh_material)

func interact():
	Globals.add_item(deposit_type.resource_type)
	$AnimationPlayer.play("break")
	
