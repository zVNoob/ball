extends Control

var Chunks = [
	preload("res://DungeonChunk/0.tscn"),
	preload("res://DungeonChunk/1.tscn"),
	preload("res://DungeonChunk/2.tscn"),
	preload("res://DungeonChunk/3.tscn"),
	preload("res://DungeonChunk/4.tscn"),
	preload("res://DungeonChunk/5.tscn"),
	preload("res://DungeonChunk/6.tscn"),
	preload("res://DungeonChunk/7.tscn"),
	preload("res://DungeonChunk/8.tscn"),
	preload("res://DungeonChunk/9.tscn"),
]
var Loaded = false
func _process(_delta):
	if !Loaded:
		print(rect_size)
		randomize()
		Loaded = true
		for i in range(rect_size.x/81):
			for j in range(rect_size.y/72):
				var Temp = Chunks[randi() % len(Chunks)].instance()
				Temp.rect_position.x = i * 81
				Temp.rect_position.y = j * 72
				add_child(Temp)
