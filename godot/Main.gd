extends Node2D

const TILE_SIZE = 25
const LEVEL_SIZE = Vector2(1000, 1000)
const MAPSIZE = Vector2(50, 50)

enum Tile { Dirt, Road, Grass }

onready var tile_map = $Map/TileMap

var map = []

func _ready():
	randomize()
	build_level()

func build_level():
	tile_map.clear()
	for x in range(LEVEL_SIZE.x):
		map.append([])
		for y in range(LEVEL_SIZE.y):
			map[x].append(Tile.Grass)
			tile_map.set_cell(x, y, Tile.Grass)

func set_tile(x, y, type):
	map[x][y] = type
	tile_map.set_cell(x, y, type)
