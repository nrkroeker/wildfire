extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_tile(position):
	var 	print($"../Map/TileMap".get_cellv(world_to_map(position)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
