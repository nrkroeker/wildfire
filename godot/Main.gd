extends Node2D

export (Vector2) onready var screen_size = get_viewport_rect().size

var health_item_timer = Timer.new()
var HEALTH_ITEM_TIME = 2

var is_game_running = false

var character = preload('res://sprites/Character/Character.tscn')

var player_one
var player_two

func _ready():
	screen_size = get_viewport_rect().size
	player_one = character.instance()
	player_one.set_name('fire')
	player_one.set_num(2)
	player_two = character.instance()
	player_two.set_name('water')
	player_two.set_num(1)
	player_two.get_node('Flame').set_ui_two()
	
	# Set up timer for spawning health items
	health_item_timer.one_shot = true
	health_item_timer.set_wait_time(HEALTH_ITEM_TIME)
	
	# Set health labels to starting health
	$HUD.update_health(1, player_one.health)
	$HUD.update_health(2, player_two.health)
	$MenuMusic.play()

func start_new_game():
	$MenuMusic.stop()
	$GameMusic.play()
	$ItemSpawner.start()
	$HUD/MessageLabel.hide()
	if !player_one.get_parent():
		add_child(player_one)
	if !player_two.get_parent():
		add_child(player_two)
	player_one.start(get_character_position(1))
	player_two.start(get_character_position(2))
	is_game_running = true

func finish_game(loser):
	$GameMusic.stop()
	$DeathMusic.play()
	$MenuMusic.play()
	$ItemSpawner.stop()
	is_game_running = false
	var winner = 'fire' if loser == 'water' else 'water'
	print('winner: ', winner)
	health_item_timer.stop()
	
	$HUD.show_game_over(winner)
	
	player_one.clear_trails()
	player_one.stop_moving()
	player_two.clear_trails()
	player_two.stop_moving()

func set_health_label(player, health):\
	$HUD.update_health(player, health)

func get_character_position(player):
	var multiplier = 0.75 if player == 1 else 0.25
	return Vector2(screen_size.x * multiplier, screen_size.y * multiplier)