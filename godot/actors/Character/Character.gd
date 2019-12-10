extends Node2D

enum CHARACTER_STATE { DEFAULT, JUMP } 

var current_trail
var trail_scene = preload("res://actors/Character/Trail.tscn")
var fire_gradient = preload('res://assets/trails/FireTrail.tres')
var water_gradient = preload('res://assets/trails/WaterTrail.tres')

var max_health = 10
var health = max_health

var gradient = fire_gradient

func _ready():
	add_trail()

func add_trail():
	current_trail = trail_scene.instance()
	current_trail.get_node('Points').set_gradient(gradient)
	add_child(current_trail)

func take_damage():
	if get_node('Flame').state != CHARACTER_STATE.JUMP:
		health -= 1
		print(name, ': ', health)
	if health == 0:
		get_parent().finish_game(name)

func set_gradient_water():
	gradient = water_gradient
	if current_trail:
		current_trail.get_node('Points').set_gradient(water_gradient)

func extend_trail(position):
	current_trail._lengthen(position)
