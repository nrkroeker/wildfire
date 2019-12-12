extends Node2D
var area
var collision_shape
var is_active

func _ready():
	is_active = true
	area = Area2D.new()
	area.connect("body_entered", self,"handle_area_entered")
	#static_body.add_collision_exception_with(get_parent().get_node('Flame'))
	add_child(area)
	collision_shape = CollisionPolygon2D.new()
	collision_shape.set_build_mode(1)
	area.add_child(collision_shape)

func _process(delta):
	if !is_active:
		if ($Points.get_point_count() == 0):
			queue_free()
		else:
			$Points.remove_point(0)
	

func handle_area_entered(object):
	if object.get_parent().get_name() != get_parent().get_name():
		print(object.get_parent().get_name(), ' collided with ', get_parent().get_name()) 
		object.get_parent().take_damage()

func lengthen(position):
	# Add point to visible line
	$Points.add_point(position)
	# Add point to collision line
	var line = collision_shape.get_polygon()
	line.append(position)
	collision_shape.set_polygon(line)
	
func clear():
	queue_free()

func set_gradient(gradient):
	$Points.set_gradient(gradient)
	
func set_inactive():
	is_active = false

