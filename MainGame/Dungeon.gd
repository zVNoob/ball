extends Control

var Chunks = []
var Buff = []
func _ready():
	var ChunkLoader = Directory.new()
	ChunkLoader.open("res://DungeonChunk")
	ChunkLoader.list_dir_begin()
	var FileName = ChunkLoader.get_next()
	while FileName != "":
		if ChunkLoader.current_is_dir():pass
		else:Chunks.append(load("res://DungeonChunk/"+FileName))
		FileName = ChunkLoader.get_next()
	ChunkLoader.list_dir_end()
	ChunkLoader.open("res://DungeonBuff")
	ChunkLoader.list_dir_begin()
	FileName = ChunkLoader.get_next()
	while FileName != "":
		if ChunkLoader.current_is_dir():pass
		else:
			if FileName.get_extension() == "tscn":
				Buff.append(load("res://DungeonBuff/"+FileName))
		FileName = ChunkLoader.get_next()
	ChunkLoader.list_dir_end()
var Loaded = false
func _process(_delta):
	if !Loaded:
		randomize()
		Loaded = true
		for i in range(rect_size.x/81):
			for j in range(rect_size.y/72):
				var Temp = Chunks[randi() % len(Chunks)].instance()
				Temp.rect_position.x = i * 81
				Temp.rect_position.y = j * 72
				add_child(Temp)
				if randi() % 25 == 5:
					var Buf = Buff[randi() % len(Buff)].instance()
					Buf.position.x = i * 81 + 40.5
					Buf.position.y = j * 72 + 36
					add_child(Buf)
