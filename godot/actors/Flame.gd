extends KinematicBody2D

# Member variables
export (int) var speed = 200
export (float) var rotation_speed = 3
var current_speed = speed
var delta_speed = 10
var min_speed = 100
var max_speed = 700
var velocity = Vector2()
var rotation_dir = 0
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	screen_size = get_viewport_rect().size
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	# Start with a random direction
	rotation_dir = deg2rad(rand_range(0, 360))
	rotate(rotation_dir)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func check_inputs(delta):
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

	
func _physics_process(delta):
	check_inputs(delta)
	velocity = Vector2(current_speed, 0).rotated(rotation)
	move_and_slide(velocity)
	