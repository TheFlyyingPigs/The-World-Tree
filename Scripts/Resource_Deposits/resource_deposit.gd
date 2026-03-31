class_name ResourceDeposit extends StaticBody3D
'
gives the player a specified resource when interacted with
'
@export var deposit_type : DepositType

func _ready() -> void:
	'
	sets up the mesh, collision, particles, and material
	'
	%GPUParticles3D.emitting = false
	%MeshInstance3D.mesh = deposit_type.mesh
	%MeshInstance3D.set_surface_override_material(0, deposit_type.mesh_material)
	%CollisionShape3D.shape = deposit_type.collision_shape
	
	

func interact():
	'
	disappears when interacted with
	and gives player specified resource
	'
	
	var material = StandardMaterial3D.new()
	material.albedo_color = deposit_type.particle_color
	%GPUParticles3D.draw_pass_1.surface_set_material(0, material)
	if randf() < Globals.additonal_chance:
		Globals.add_item(deposit_type.resource_type)
		Globals.add_item(deposit_type.resource_type)
		Gui.alert(deposit_type.resource_type, 2)
	else:
		Globals.add_item(deposit_type.resource_type)
		Gui.alert(deposit_type.resource_type, 1)
	%AnimationPlayer.play("break")
	Gui.screen_shake(0.45,0.5)
	
