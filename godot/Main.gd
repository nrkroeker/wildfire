extends Node2D

const TILE_SIZE = 25
const LEVEL_SIZE = Vector2(1000, 1000)
const MAPSIZE = Vector2(50, 50)

enum Tile { Dirt, Road, Grass }


var trail_scene = preload("res://actors/Trail.tscn")

var map = []

# func _ready():
	# randomize()
	# build_level()

#func build_level():
#	tile_map.clear()
#	for x in range(LEVEL_SIZE.x):
#		map.append([])
#		for y in range(LEVEL_SIZE.y):
#			var type = Tile.Grass
#			if x == 0 or x == (LEVEL_SIZE.x - 2) or y == 0 or y == (LEVEL_SIZE.y - 2):
#				type = Tile.Road
#			map[x].append(type)
#			tile_map.set_cell(x, y, type)

#func set_tile(x, y, type):
#	map[x][y] = type
#	tile_map.set_cell(x, y, type)
