extends Node2D

var current_trail

var trail_scene = preload("res://actors/FlameCharacter/Trail.tscn")

func _ready():
	add_trail()

func add_trail():
	current_trail = trail_scene.instance()
	add_child(current_trail)

func extend_trail(position):
	current_trail._lengthen(position)
	# Add collision line shape segment

