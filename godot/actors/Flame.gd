extends KinematicBody2D

# Member variables
export (int) var speed = 200
export (float) var rotation_speed = 3
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
func _process(delta):
	rotation_dir = 0
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	rotation += rotation_dir * rotation_speed * delta

	
func _physics_process(delta):
	velocity = Vector2(speed, 0).rotated(rotation)
	move_and_slide(velocity)
	