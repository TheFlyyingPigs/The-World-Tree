extends Node3D
'
updates the variables that get upgraded to the upgraded variable 
'

@onready var sun: DirectionalLight3D = $DirectionalLight3D
@onready var fog_volume: FogVolume = $FogVolume
@onready var fog_material: FogMaterial = $FogVolume.get_material()

func _ready() -> void:
	fog_material.density = Globals.fog_density
	sun.light_energy = Globals.sunlight
