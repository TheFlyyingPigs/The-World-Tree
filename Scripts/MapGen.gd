class MapGen extends Node3D:
	'
	Contains methods to generate a miscellaneous structure of tile objects.
	'
	@onready var _map = get_node("res://Scenes/Map")
	static var _spawn_coordinates: Vector3i = Vector3i(0, 0, 0)
	static var min_dist: int = 5 # Minimum distance between objective tiles
	
	# Methods
	func _ready():
		rand_gen(15, 15)

	func rand_gen(x: int, y:int):
		'
		Generates a completely random map of x * y size.
		'
		for i in x:
			for j in y:
				_map.set_cell_item(Vector3i(i,j,-1), randi_range(0, 4))
		return

	func procedural_gen(rounds:int = 20):
		'
		Procedurally generate map based on a set of rules.
		
		Args:
			rounds (int): number of times to run through the generation loop
		'
		var curr_dist: int = None # Tracks distance between objective tiles
		
		for i in rounds:
			match randi_range(0,4): # From 0 to maximum number of tiles in meshlibrary
				0: # Objective tile
					# No objective tile within x spaces of eachother
					# No objective tile within 10 spaces of spawn
