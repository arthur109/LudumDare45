extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var tileDist = 1.5;
onready var grid = $NinePatchRect
onready var cursor = $cursor
onready var player = $"../Player"
onready var tilemap = $"../TileMaps"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var playerPos = player.global_position - tilemap.get_cell_size()*0.5;
	var index = tilemap.world_to_index(playerPos.x,playerPos.y)
	var mouseIndex = tilemap.world_to_index(get_global_mouse_position().x,get_global_mouse_position().y)
	visible = isInBounds()
	grid.rect_position = tilemap.index_to_world(index.x - tileDist,index.y - tileDist)
	cursor.position = tilemap.index_to_world(mouseIndex.x,mouseIndex.y)
	grid.rect_size = Vector2(16*tileDist*4,16*tileDist*4)
	
	
func isInBounds():
	var playerPos = player.global_position - tilemap.get_cell_size()*0.5;
	var index = tilemap.world_to_index(playerPos.x,playerPos.y)
	var mouseIndex = tilemap.world_to_index(get_global_mouse_position().x,get_global_mouse_position().y)
	return mouseIndex.x >= index.x - tileDist-1 and mouseIndex.y >= index.y - tileDist-1 and mouseIndex.x <= index.x + tileDist+2 and mouseIndex.y <= index.y + tileDist+2;
