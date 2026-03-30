class MapGen extends Node3D:
	'
	Script to generate a miscellaneous structure of tile objects.
	'
	@onready var _map = get_node("res://Scenes/Map")
	@onready var _spawn_coordinates = Vector3i(0, 0, 0)
	
	# Methods
	func _ready():
		rand_gen(15, 15)

	func rand_gen(x: int, y:int):
		'
		Generates a completely random map of x * y size.
		'
		var curr_tile: Material
		for i in x:
			for j in y:
				_map.set_cell_item(Vector3i(i,j,-1), randi_range(0, 4))
		return

	func procedural_gen():
		'
		Procedurally generate map based on a set of rules.
		'
		pass
