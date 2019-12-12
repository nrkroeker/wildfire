extends Timer

var heart_item = preload('res://sprites/Item/Heart/Heart.tscn')
var heart_count = 0
var heart_spawn_rate = 60
var max_heart_count = 2
onready var main = get_node('/root/Main')
var window_padding = 50

func _ready():
	connect("timeout",self,"_on_timeout")

func reset():
	heart_count = 0

func _on_timeout():
	if heart_count < max_heart_count:
		var spawn = rand_range(0, 100)
		if spawn <= heart_spawn_rate:
			var item = heart_item.instance()
			var x = rand_range(window_padding, main.screen_size.x - window_padding)
			var y = rand_range(window_padding, main.screen_size.y - window_padding)
			item.position = Vector2(x, y)
			get_parent().add_child(item)
			heart_count += 1

func remove_heart():
	heart_count -= 1