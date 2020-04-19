extends TileMap

var min_x = 0
var min_y = 0
var max_x = GlobalInfo.worldWidth
var max_y = GlobalInfo.worldHeight

var highlights = []

var expansion_rate = 50
export (int) var conquered_tile_index

func _ready():
	pass
	
func _process(delta):
	for x in (max_x - min_x):
		for y in (max_y - min_y):
			pass
			if self.get_cell(x,y) == conquered_tile_index and randf()*expansion_rate < delta:
				expand(x,y)
	solidify_highlights()
				
func expand(x,y):

	highlights.append(Vector2(x,y+1))
	highlights.append(Vector2(x,y-1))
	highlights.append(Vector2(x+1,y))
	highlights.append(Vector2(x-1,y))

func solidify_highlights():
	for i in highlights:
		var x = i.x
		var y = i.y
		
		self.set_cell(x,y,conquered_tile_index)
		if x <= min_x:
			min_x = x
		elif x >= max_x:
			max_x = x
		if y <= min_y:
			min_y = y
		elif y >= max_y:
			max_y = y
