extends KinematicBody2D

var velocity = Vector2()
var onBlock
var closestPos = global_position

var map

export (int) var ConqueredTileIndex
export (int) var speed = 200
onready var Sprite := $BaseSprite
onready var Shader := $ColorRect
var health = 5

const FLINCH_TIME = 0.3
var current_flinch = FLINCH_TIME
var damage = 1


func _ready():
	map = get_node("../../TileMaps/ConqueredMap")
	Sprite.play("run")

func take_damage(attacker):
	current_flinch = FLINCH_TIME
	
	var damage_direction = attacker.global_position + Vector2(1,1)
	
	velocity -= (global_position - damage_direction).normalized()*speed * 2
	Sprite.modulate = Color(0.8,0,0)
	health -= attacker.damage
	
	

func get_direction(var map) -> Vector2:
	var leastDist = 1000
	closestPos = global_position
	var notOnGlobalPos = false
	for x in GlobalInfo.worldWidth:
		for y in GlobalInfo.worldHeight:
			if map.get_cell(x,y) != -1 and map.get_cell(x,y) == ConqueredTileIndex  and map.get_parent().index_to_world(x,y).distance_to(global_position) <= leastDist:
				leastDist = map.get_parent().index_to_world(x,y).distance_to(global_position) + map.cell_size.x/2
				closestPos = map.get_parent().index_to_world(x,y) + map.cell_size/2
				notOnGlobalPos = true

	var closestPosX = map.get_parent().world_to_index(closestPos.x,closestPos.y).x
	var closestPosY = map.get_parent().world_to_index(closestPos.x,closestPos.y).y
	var charX = map.get_parent().world_to_index(global_position.x,global_position.y).x
	var charY = map.get_parent().world_to_index(global_position.x,global_position.y).y

	onBlock = closestPosX-charX < 1 and closestPosY-charY < 1 and notOnGlobalPos

	return (closestPos - global_position).normalized() * speed


func process_attack():
	if Sprite.get_animation() != "attack":
		Sprite.play("attack")
	if Sprite.frame == 9 and Sprite.get_animation() == "attack":
		map.set_cell(map.get_parent().world_to_index(closestPos.x,closestPos.y).x,map.get_parent().world_to_index(closestPos.x,closestPos.y).y,-1)
		map.update_dirty_quadrants();
		take_damage(self)




func _process(delta):
	if health > 0:
		velocity = get_direction(map)
		if !onBlock:
			velocity = move_and_slide(velocity)*delta
		else:
			process_attack()

		if (Sprite.get_animation() == "attack" and Sprite.frame == 9) and Sprite.get_animation() != "run":
			Sprite.play("run")

		current_flinch -= delta
		if (current_flinch <= 0):
			Sprite.modulate = Color(1,1,1,1)


		if velocity.x > 0:
			Sprite.flip_h = false
		elif velocity.x < 0:
			Sprite.flip_h = true
	else:
		get_parent().remove_child(self)
