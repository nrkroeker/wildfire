extends TileMap

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _is_same_cell(position_a, position_b):
	var map_pos_a = world_to_map(position_a)
	var map_pos_b = world_to_map(position_b)
	print(map_pos_a, map_pos_b)
	return map_pos_a.distance_to(map_pos_b) == 0

func _burn_tile(position):
	var map_position = world_to_map(position)
	var current_tile_type = get_cellv(map_position)
	if current_tile_type == self.tile_set.find_tile_by_name("Grass"):
		set_cellv(map_position, self.tile_set.find_tile_by_name("Dirt"))
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass