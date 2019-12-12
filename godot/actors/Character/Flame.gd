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

onready var main = get_node('/root/Main')

onready var character = get_parent()

func _ready():
	# Set up jump timers
	jump_timer.connect("timeout", self,"on_timer_timeout")
	jump_timer.set_wait_time(jump_time * current_speed)
	jump_timeout_timer.set_wait_time(jump_time * current_speed)
	jump_timer.one_shot = true
	jump_timeout_timer.one_shot = true
	add_child(jump_timer)
	add_child(jump_timeout_timer)

	# Set initial rotation
	randomize()
	rotation_dir = deg2rad(rand_range(0, 360))
	rotate(rotation_dir)
	
	# Set animation, a.k.a player color
	var animation = 'red' if get_parent().name == 'fire' else 'blue'
	$AnimatedSprite.play(animation)

func start_moving(new_position):
	position = new_position
	current_speed = speed
	velocity = Vector2(current_speed, 0)

func stop_moving():
	current_speed = 0
	velocity = Vector2(current_speed, 0)
	jump_timer.stop()

func set_ui_two():
	ui_select = 'ui_select_two'
	ui_up = 'ui_up_two'
	ui_down = 'ui_down_two'
	ui_right = 'ui_right_two'
	ui_left = 'ui_left_two'

func _physics_process(delta):
	if main.is_game_running:
		check_inputs(delta)
		velocity = Vector2(current_speed, 0).rotated(rotation)
		move_and_slide(velocity)
		if state != CHARACTER_STATE.JUMP:
			if last_position:
				if position.distance_to(last_position) > 8:
					character.extend_trail(last_position)
					last_position = position
			else:
				last_position = position
		else:
			last_position = position

func check_inputs(delta):
	# Ensure this only happens when game is running - maybe handle in character?
	rotation_dir = 0
	if Input.is_action_pressed(ui_select):
		if state != CHARACTER_STATE.JUMP and jump_timeout_timer.time_left == 0:
			state = CHARACTER_STATE.JUMP
			jump_timer.start()
			get_parent().play_jump_sound()
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
	
func on_timer_timeout():
	character.add_trail()
	state = CHARACTER_STATE.DEFAULT
	jump_timeout_timer.start()
