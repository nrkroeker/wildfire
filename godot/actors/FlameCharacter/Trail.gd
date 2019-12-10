extends Node2D
var static_body
var collision_shape

func _ready():
	static_body = StaticBody2D.new()
	static_body.set_collision_layer_bit(1, false)
	static_body.set_collision_layer_bit(2, true)
	static_body.set_collision_mask_bit(1, false)
	static_body.set_collision_mask_bit(2, false)
	static_body.set_collision_mask_bit(3, false)
	static_body.set_collision_mask_bit(4, false)
	add_child(static_body)
	collision_shape = CollisionPolygon2D.new()
	collision_shape.set_build_mode(1)
	static_body.add_child(collision_shape)

func _lengthen(position):
	# Add point to visible line
	$Points.add_point(position)
	# Add point to collision line
	var line = collision_shape.get_polygon()
	line.append(position)
	collision_shape.set_polygon(line)
