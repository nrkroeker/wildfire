extends KinematicBody2D

enum CHARACTER_STATE { DEFAULT, JUMP } 

# Member variables
export (int) var speed = 100
export (float) var rotation_speed = 3
export var state = CHARACTER_STATE.DEFAULT
var current_speed = speed
var jump_time = 0.004
var delta_speed = 10
var min_speed = 50
var max_speed = 200
var velocity = Vector2()
var rotation_dir = 0
var last_position

var ui_select = 'ui_select'
var ui_up = 'ui_up'
var ui_down = 'ui_down'
var ui_right = 'ui_right'
var ui_left = 'ui_left'

var jump_timer = Timer.new()
var jump_timeout_timer = Timer.new()

onready var character = get_parent()
onready var tile_map = character.get_parent().get_node('Map').get_node('TileMap')

# Called when the node enters the scene tree for the first time.
func _ready():
	jump_timer.connect("timeout", self,"_on_timer_timeout")
	jump_timer.set_wait_time(jump_time * current_speed)
	jump_timeout_timer.set_wait_time(jump_time * current_speed)
	jump_timer.one_shot = true
	jump_timeout_timer.one_shot = true
	add_child(jump_timer)
	add_child(jump_timeout_timer)
	randomize()
	# position = Vector2(screen_size.x / 2, screen_size.y / 2)
	velocity = Vector2(speed, 0)
	rotation_dir = deg2rad(rand_range(0, 360))
	rotate(rotation_dir)

	
func set_ui_two():
	ui_select = 'ui_select_two'
	ui_up = 'ui_up_two'
	ui_down = 'ui_down_two'
	ui_right = 'ui_right_two'
	ui_left = 'ui_left_two'
#func _process(delta):
	# Get line between last burned tile and current tile
	# Get all tiles overlapped by that line
	# Any tiles that do not overlap with flame position
		# Either use the bounding box as a static distance
		# Or use bounding edges of visible node to see if any contained tiles are overlapped
	# - will be burned 
	# Check if last position is no longer in the same cell as this one
	#if last_position:
	#	var is_in_last_cell = tile_map._is_same_cell(position, last_position)
	#	print(is_in_last_cell)
	#	if !is_in_last_cell:
	#		tile_map._burn_tile(last_position)
	#		last_position = position
	#else:
	#	last_position = position

func _physics_process(delta):
	_check_inputs(delta)
	velocity = Vector2(current_speed, 0).rotated(rotation)
	move_and_slide(velocity)
	if state != CHARACTER_STATE.JUMP:
		if last_position:
			# print(position.distance_to(last_position))
			if position.distance_to(last_position) > 8:

				# var angle = last_position.angle_to(position)
				#print(angle)
				# var new_position = Vector2(position.x, position.y)
				# new_position.x -= cos(angle) * 10
				# new_position.y -= sin(angle) * 10
				character.extend_trail(last_position)
				last_position = position
		else:
			last_position = position
	else:
		last_position = position

func on_body_enter(object):
	print(object.get_name())

# Custom methods

func _check_inputs(delta):
	rotation_dir = 0
	if Input.is_action_pressed(ui_select):
		if state != CHARACTER_STATE.JUMP and jump_timeout_timer.time_left == 0:
			state = CHARACTER_STATE.JUMP
			jump_timer.start()
	if Input.is_action_pressed(ui_right):
		rotation_dir += 1
	if Input.is_action_pressed(ui_left):
		rotation_dir -= 1
	if Input.is_action_pressed(ui_up):
		if (current_speed <= max_speed):
			current_speed += delta_speed
	if Input.is_action_pressed(ui_down):
		if (current_speed >= min_speed):
			current_speed -= delta_speed
	rotation += rotation_dir * rotation_speed * delta
	
func _on_timer_timeout():
	character.add_trail()
	state = CHARACTER_STATE.DEFAULT
	jump_timeout_timer.start()
