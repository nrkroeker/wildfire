extends TileMap

func _ready():
	pass # Replace with function body.

func is_same_cell(position_a, position_b):
	var map_pos_a = world_to_map(position_a)
	var map_pos_b = world_to_map(position_b)
	print(map_pos_a, map_pos_b)
	return map_pos_a.distance_to(map_pos_b) == 0

func burn_tile(position):
	var map_position = world_to_map(position)
	var current_tile_type = get_cellv(map_position)
	if current_tile_type == self.tile_set.find_tile_by_name("Grass"):
		# Dirt needs to not have collisions
		set_cellv(map_position, self.tile_set.find_tile_by_name("Dirt"))
		
