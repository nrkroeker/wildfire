extends Node2D
var area
var collision_shape

func _ready():
	area = Area2D.new()
	area.connect("body_entered", self,"handle_area_entered")
	#static_body.add_collision_exception_with(get_parent().get_node('Flame'))
	add_child(area)
	collision_shape = CollisionPolygon2D.new()
	collision_shape.set_build_mode(1)
	area.add_child(collision_shape)

func handle_area_entered(object):
	# print(object.get_parent().get_name())
	# print(get_parent().get_name())
	if object.get_parent().get_name() != get_parent().get_name():
		print(object.get_parent().get_name(), ' collided with ', get_parent().get_name()) 
		object.get_parent().take_damage()
	# do collision stuff

func _lengthen(position):
	# Add point to visible line
	$Points.add_point(position)
	# Add point to collision line
	var line = collision_shape.get_polygon()
	line.append(position)
	collision_shape.set_polygon(line)
