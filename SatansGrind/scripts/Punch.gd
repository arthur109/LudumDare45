extends Node2D

onready var AnimatedSprite := $AnimatedSprite 
onready var Area2D := $Area2D
onready var Player := get_parent()

var cooldown = 0
var timer = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

func _process(delta):
	cooldown -= delta
	timer -= delta
	
	if timer > 0.1 and timer < 0.15:
		Player.move_and_slide(Player.velocity)
	else:
		Player.move_and_slide(Player.velocity / 6.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(dir):
	if timer <= 0:
		timer = 0.3
		
		self.rotation_degrees = dir + randf() * 20 - 10
		AnimatedSprite.frame = 0
		
		var dirRad = deg2rad(dir)
		Player.velocity = Vector2(cos(dirRad), sin(dirRad)) * Player.speed * 3
		
		
		
		return self
	
	return null
	
func isFinished():
	return timer <= 0
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
