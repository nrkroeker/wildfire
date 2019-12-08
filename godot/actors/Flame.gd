extends KinematicBody2D

# Member variables
export (int) var speed = 100
export (float) var rotation_speed = 3
var current_speed = speed
var delta_speed = 10
var min_speed = 50
var max_speed = 200
var velocity = Vector2()
var rotation_dir = 0
var screen_size
var last_position

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	rotation_dir = deg2rad(rand_range(0, 360))
	rotate(rotation_dir)
	
func _process(delta):
	# Check if last position is no longer in the same cell as this one
	if last_position:
		var is_in_last_cell = $"../Map/TileMap"._is_same_cell(position, last_position)
		print(is_in_last_cell)
		if !is_in_last_cell:
			$"../Map/TileMap"._burn_tile(last_position)
			last_position = position
	else:
		last_position = position

func _physics_process(delta):
	_check_inputs(delta)
	velocity = Vector2(current_speed, 0).rotated(rotation)
	move_and_slide(velocity)

# Custom methods

func _check_inputs(delta):
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("ui_up"):
		if (current_speed <= max_speed):
			current_speed += delta_speed
	if Input.is_action_pressed("ui_down"):
		if (current_speed >= min_speed):
			current_speed -= delta_speed
	rotation += rotation_dir * rotation_speed * delta
