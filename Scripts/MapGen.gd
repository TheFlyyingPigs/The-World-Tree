class MapGen extends Node3D:
	'
	Contains methods to generate a miscellaneous structure of tile objects.
	'
	@onready var _map = get_node("res://Scenes/Map")
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

	func procedural_gen():
		'
		Procedurally generate map based on a set of rules.
		
		Args:
			rounds (int): number of times to run through the generation loop
		'
		var objective_dist: int = 0 # Tracks distance between objective tiles
		var hazard_dist: int = 0
		var objective_count: int = 0 # Tracks number of objective tiles
		var curr_loc: Vector3i = Vector3i(-25,-25,-1) # x, y are back left corner
		
		while curr_loc.x < 25 or curr_loc.y < 25:  # 50 by 50 grid centered on spawn
			match randi_range(0,4): # From 0 to maximum number of tiles in meshlibrary
				0: # Objective tile
					# No objective tile within x spaces of eachother
					if objective_dist < min_dist:
						continue
						
					# No objective tile within 10 spaces of spawn
					if (curr_loc.x >= 10 or curr_loc.x <= 10) or \
					(curr_loc.y >= 10 or curr_loc.y <= 10): 
						continue
						
					# No more than 4 objective tiles total
					if objective_count > 4:
						continue
					
					# Place tile, increment count and reset dist
					_map.set_cell_item(curr_loc, 0)
					objective_count += 1
					objective_dist = 0
					
					# Decide whether to increment x or y location
					if curr_loc.x >= curr_loc.y:
						curr_loc.y += 1
					else:
						curr_loc.x += 1
					
				1: # Dirt Tile
					# Place tile
					_map.place_cell_item(curr_loc, 1)
					
					# Decide whether to increment x or y location
					if curr_loc.x >= curr_loc.y:
						curr_loc.y += 1
					else:
						curr_loc.x += 1
					
				2: # Hazard Tile - Slow
					# No two hazards within 2 spaces of each other
					if hazard_dist < 2:
						continue
						
					# Place tile, reset dist
					_map.set_cell_item(curr_loc, 2)
					hazard_dist = 0
				3:
					continue # Not implmented
				4: 
					continue # Not implemented
			# Increment distance variables
			objective_dist += 1
			hazard_dist += 1
