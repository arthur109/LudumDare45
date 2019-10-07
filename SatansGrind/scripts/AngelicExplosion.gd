extends Node2D



var speed = 0
var timer = 0.001
var velocity
onready var tileSize = get_node("../../../TileMaps").get_cell_size();
var explosion = preload("res://scenes/ExplosionParticles.tscn")
var dead = false
var _position = Vector2()

func explode(direction):
	dead = true
	velocity = direction.normalized() * speed

func _process(delta):
	
	if dead:
		_position = get_parent().global_position
		timer -= delta
		if timer <= 0:
			show_explosion()

func show_explosion():
	print("yo mama es fat ----------------------------------------------------------------")
	var temp = explosion.instance();
	temp.global_position = get_parent().global_position
	get_parent().get_parent().add_child(temp)
	get_parent().remove_child(self)