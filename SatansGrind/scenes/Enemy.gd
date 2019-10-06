extends KinematicBody2D

var velocity = Vector2()

var map

export (int) var speed = 200

onready var Sprite := $BaseSprite 


func _ready():
	map = get_node("../TileMaps/ConqueredMap")

func get_direction(var map) -> Vector2:
	var leastDist = 1000
	var closestPos
	for x in GlobalInfo.worldWidth:
		for y in GlobalInfo.worldHeight:
			if map.get_cell(x,y) == 8 and map.get_parent().index_to_world(x,y).distance_to(global_position) <= leastDist:
				leastDist = map.get_parent().index_to_world(x,y).distance_to(global_position);
				closestPos = map.get_parent().index_to_world(x,y);
				
	return (closestPos - global_position).normalized() * speed
	
func _process(delta):
	velocity = move_and_slide(get_direction(map))*delta
	print(velocity)
	
	if velocity.x != 0 or velocity.y != 0:
		if Sprite.get_animation() != "run":
			Sprite.play("run")
	else:
		if Sprite.get_animation() != "idle":
			Sprite.play("idle")
		
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true