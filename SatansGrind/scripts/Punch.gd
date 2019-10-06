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
	
	if timer > 0 and timer < 0.06:
		Player.move_and_slide(Player.velocity)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(dir):
	if cooldown <= 0:
		cooldown = 0.2
		timer = 0.06
		
		self.rotation_degrees = dir + randf() * 20 - 10
		AnimatedSprite.frame = 0
		
		var dirRad = deg2rad(dir)
		Player.velocity = Vector2(cos(dirRad), sin(dirRad)) * Player.speed * 0.2
		
		
		
		return self
	
	return null
	
func isFinished():
	return timer <= 0
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
