extends Control

var Chunks = [
	preload("res://DungeonChunk/0.tscn"),
	preload("res://DungeonChunk/1.tscn"),
	preload("res://DungeonChunk/2.tscn"),
]

func _ready():
	randomize()
	for i in range(16):
		for j in range(8):
			var Temp = Chunks[randi() % len(Chunks)].instance()
			Temp.rect_position.x = i * 81
			Temp.rect_position.y = j * 72
			add_child(Temp)
