extends Node2D



var speed = 1
var timer = 0.001
var velocity
var direction
onready var tileSize = get_node("../../../TileMaps").get_cell_size();
var explosion = preload("res://scenes/ExplosionParticles.tscn")
var dead = false
var _position = Vector2()

func explode(_direction):
	dead = true
	direction = _direction
	velocity = direction.normalized() * speed

func _process(delta):
	
	if dead:
		_position = get_parent().global_position
		timer -= delta
		if timer <= 0:
			show_explosion()

func show_explosion():
	var temp = explosion.instance();
	temp.global_position = get_parent().global_position
	if velocity.x != 0:
		print(atan((direction.y)/(direction.x)))
		temp.set_rotation(PI+direction.angle())
	else:
		print("cacaa dooodle ",velocity )
		temp.rotate(PI/2)
	get_parent().get_parent().add_child(temp)
	get_parent().remove_child(self)