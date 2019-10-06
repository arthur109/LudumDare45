
extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.
var groundIndexes = [3,4,5]
var wallIndexes = [1,2]
var topIndexes = [0,7];

var bottom;
var top;

const PARTICLE_EFFECT = preload("res://scenes/BuildParticle.tscn")
func _ready() -> void:
	bottom = $LowerLayer
	top = $UpperLayer
	
	for x in range(0,GlobalInfo.worldWidth):
		for y in range(0,GlobalInfo.worldHeight):
			bottom.set_cell(x,y,groundIndexes[randi() % groundIndexes.size()]);
			
func buildWall(var x, var y) -> void:
	
	bottom.set_cell(x,y,wallIndexes[randi() % (wallIndexes.size())]);
	top.set_cell(x,y,topIndexes[randi() % (topIndexes.size())]);
	bottom.update_dirty_quadrants();
	top.update_dirty_quadrants();
	var temp = PARTICLE_EFFECT.instance();
	temp.global_position = get_global_mouse_position();
	get_parent().add_child(temp);
	

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("place_block"):
		
		
		var mouse_pos = get_global_mouse_position()
		
		var tile_pos = (mouse_pos-global_position)/scale/bottom.get_cell_size()
		buildWall(int(tile_pos.x),int(tile_pos.y))
		
func index_to_world(x,y) -> Vector2:
	return Vector2(int(x),int(y))*scale*bottom.get_cell_size+global_position
	