class_name DepositSpawner extends Marker3D
'
spawns a random resource deposit at its location
'
@export var spawner_type : SpawnerType
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	'
	picks a random resource from weighted list in SpawnerType and places it
	'
	var placed_resource = load("res://Scenes/resource_deposit.tscn").instantiate()
	placed_resource.deposit_type = spawner_type.possible_deposits[rng.rand_weighted(spawner_type.weights)]
	
	await Globals.scene_loaded
	
	Globals.current_scene.add_child(placed_resource)
	placed_resource.global_position = self.global_position
	placed_resource.rotation.y = rng.randi_range(-180,180)
	
	
	queue_free()
