extends Area2D

onready var item_spawner = get_node('/root/Main/ItemSpawner')

func _on_body_entered(body):

	if body.get_name() == 'Flame':
		body.get_parent().add_health()
		item_spawner.remove_heart()
		queue_free()
