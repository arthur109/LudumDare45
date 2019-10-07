
extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

# Called when the node enters the scene tree for the first time.

var grass = [0,1,10,11,12,13,2,3,33,33,33,33,33,33,33,33,33]
var grassSpecial = [14,15,16,17,18]
var grassOverlay = [19,20,24,27,32,34,35];
var wall = [21,22,23];
var roof = [25,28,29,30,31,31,31,31,36,37,38]
var wallOverlay = [24,27,20,19]





var bottom;
var top;

onready var  BlockPlacer = get_node("../BlockPlacer")
const PARTICLE_EFFECT = preload("res://scenes/BuildParticle.tscn")
const TURRET = preload("res://scenes/TurretSeed.tscn")
func _ready() -> void:
	bottom = $LowerLayer
	top = $UpperLayer


	for x in range(0,GlobalInfo.worldWidth):
		for y in range(0,GlobalInfo.worldHeight):
			$Floor.set_cell(x,y,chooseRand(grass),(randf()>0.5));
			if(randf()<0.1):
				$FloorOverlay.set_cell(x,y,chooseRand(grassOverlay),randf()>0.5);
			if(randf()<0.01):
				$FloorSpecial.set_cell(x,y,chooseRand(grassSpecial),randf()>0.5);

func buildWall(var x, var y) -> void:

	bottom.set_cell(x,y,chooseRand(wall));
	top.set_cell(x,y,chooseRand(roof));
	
	if(randf() < 0.2):
		$WallOverlay.set_cell(x,y,chooseRand(wallOverlay), randf()>0.5)
	
	bottom.update_dirty_quadrants();
	top.update_dirty_quadrants();
	var temp = PARTICLE_EFFECT.instance();
	temp.global_position = get_global_mouse_position();
	get_parent().add_child(temp);


func _process(delta : float) -> void:
	if Input.is_action_just_pressed("place_block") and BlockPlacer.isInBounds():

		var mouse_pos = get_global_mouse_position()

		var tile_pos = (mouse_pos-global_position)/scale/bottom.get_cell_size()
		buildWall(int(tile_pos.x),int(tile_pos.y))
		
	if Input.is_action_just_pressed("place_turret") and BlockPlacer.isInBounds():


		var temp = TURRET.instance();
		var index = world_to_index(get_global_mouse_position().x,get_global_mouse_position().y)
		temp.global_position = index_to_world(index.x,index.y)
		get_node("../Turrets").add_child(temp);

func index_to_world(x,y) -> Vector2:
	return Vector2(int(x),int(y))*scale*bottom.get_cell_size()+global_position

func world_to_index(x,y) -> Vector2:
	var pos = (Vector2(x,y)-global_position)/scale/bottom.get_cell_size()
	return Vector2(int(pos.x),int(pos.y))

func get_cell_size() -> Vector2:
	return bottom.get_cell_size()*scale;
	
func chooseRand(var array):
	return array[randi() % array.size()]