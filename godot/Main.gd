extends Node2D

var screen_size
var health_item_timer = Timer.new()
var HEALTH_ITEM_TIME = 2

var character = preload('res://actors/Character/Character.tscn')

func _ready():
	screen_size = get_viewport_rect().size
	var player_one = character.instance()
	player_one.set_name('fire')
	player_one.position = Vector2(screen_size.x * 0.75, screen_size.y * 0.75)
	var player_two = character.instance()
	player_two.set_name('water')
	player_two.set_gradient_water()
	player_two.get_node('Flame').set_ui_two()
	player_two.position = Vector2(screen_size.x * 0.25, screen_size.y * 0.25)
	add_child(player_one)
	add_child(player_two)
	
	health_item_timer.one_shot = true
	health_item_timer.set_wait_time(HEALTH_ITEM_TIME)

func finish_game(loser):
	var winner = 'fire' if loser == 'water' else 'water'
	print('winner: ', winner)
	health_item_timer.stop()

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
