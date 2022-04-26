extends Node2D

func _physics_process(delta):
	$Below.position.y = get_parent().rect_size.y - 60
	$Right.position.x = get_parent().rect_size.x - 3.5
