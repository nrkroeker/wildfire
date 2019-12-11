extends Node2D

enum CHARACTER_STATE { DEFAULT, JUMP } 

var player_num

var current_trail
var trails = []
var trail_scene = preload("res://actors/Character/Trail.tscn")
var fire_gradient = preload('res://assets/trails/FireTrail.tres')
var water_gradient = preload('res://assets/trails/WaterTrail.tres')

var CHARACTER_TEXTURE = {
	1: water_gradient,
	2: fire_gradient
}

var CHARACTER_UI_KEYS = {
	1: {
		'select': 'ui_select',
		'up': 'ui_up',
		'down': 'ui_down',
		'right': 'ui_right',
		'left': 'ui_left'
	},
	2: {
		'select': 'ui_select_two',
		'up': 'ui_up_two',
		'down': 'ui_down_two',
		'right': 'ui_right_two',
		'left': 'ui_left_two'
	}	
}

var max_health = 2
export (int) var health = max_health

var gradient = CHARACTER_TEXTURE[1]

func _ready():
	#add_trail()
	pass
	

func start(new_position):
	if current_trail:
		current_trail.clear()
		current_trail = null
	for child in get_children():
		if child.get_name() == 'Trail':
			child.clear()
	$Flame.start_moving(new_position)
	if !current_trail:
		add_trail()
	
	set_health(max_health)

func set_num(number):
	player_num = number
	gradient = CHARACTER_TEXTURE[number]

func add_trail():
	current_trail = trail_scene.instance()
	# trails.append(current_trail)

	current_trail.set_gradient(gradient)
	add_child(current_trail)

func take_damage():
	if get_node('Flame').state != CHARACTER_STATE.JUMP:
		set_health(health - 1)
	if health == 0:
		get_parent().finish_game(name)

func set_gradient_water():
	gradient = water_gradient

func set_health(new_health):
	health = new_health
	get_parent().set_health_label(player_num, health)

func stop_moving():
	$Flame.stop_moving()

func extend_trail(position):
	current_trail._lengthen(position)
