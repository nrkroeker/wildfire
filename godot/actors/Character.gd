extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var current_trail

var trail_scene = preload("res://actors/Trail.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	add_trail()
	pass # Replace with function body.

func add_trail():
	current_trail = trail_scene.instance()
	add_child(current_trail)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
