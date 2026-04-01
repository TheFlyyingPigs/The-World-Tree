extends Node3D
'
updates the variables that get upgraded to the upgraded variable 
'

@onready var sun: DirectionalLight3D = $DirectionalLight3D
@onready var fog_volume: FogVolume = $FogVolume
@onready var fog_material: FogMaterial = $FogVolume.get_material()
@onready var tree_model: MeshInstance3D = $TreeModel
@onready var beacon: MeshInstance3D = $Beacon


func _ready() -> void:
	fog_material.density = Globals.fog_density
	if Globals.beacon_strength == -1:
		beacon.visible = false
	else:
		beacon.visible = true
		beacon.mesh.material.distance_fade_min_distance = Globals.beacon_strength
	
	tree_model.mesh = Globals.tree_stages["stage_"+str(Globals.tree_stage)]
