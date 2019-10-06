extends KinematicBody2D

var velocity = Vector2()

var map

export (int) var speed = 200

onready var Sprite := $BaseSprite 


func _ready():
	map = get_node("../TileMaps/ConqueredMap")
	Sprite.play("run")

func get_direction(var map) -> Vector2:
	var leastDist = 1000
	var closestPos = global_position
	for x in GlobalInfo.worldWidth:
		for y in GlobalInfo.worldHeight:
			if map.get_cell(x,y) != -1 and map.get_cell(x,y) == 8 and map.get_parent().index_to_world(x,y).distance_to(global_position) <= leastDist:
				leastDist = map.get_parent().index_to_world(x,y).distance_to(global_position)
				closestPos = map.get_parent().index_to_world(x,y)
				
	if map.get_parent().world_to_index(closestPos.x,closestPos.y).x-map.get_parent().world_to_index(global_position.x,global_position.y).x < 1 and map.get_parent().world_to_index(closestPos.x,closestPos.y).y-map.get_parent().world_to_index(global_position.x,global_position.y).y < 1:
		map.set_cell(map.get_parent().world_to_index(closestPos.x,closestPos.y).x,map.get_parent().world_to_index(closestPos.x,closestPos.y).y,-1)
		print("dude")
	print(map.get_parent().world_to_index(closestPos.x,closestPos.y))


	return (closestPos - global_position).normalized() * speed
	
func _process(delta):
	velocity = move_and_slide(get_direction(map))*delta
	
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true