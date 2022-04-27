extends Node2D

func _physics_process(_delta):
	$Below.position.y = get_parent().rect_size.y - 50
	$Right.position.x = get_parent().rect_size.x - 3.6
