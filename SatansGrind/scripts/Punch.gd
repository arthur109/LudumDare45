extends Node2D

onready var AnimatedSprite := $AnimatedSprite 
onready var Area2D := $Area2D
onready var Player := get_parent()

export (int) var damage = 1

var cooldown = 0
var timer = 0
var damaged = false
var direction


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
		
	if timer <= 0.1 and damaged == false:
		var numEnemies = 0
		for area in Area2D.get_overlapping_areas():
			var parent = area.get_parent()
			if parent.is_in_group("enemies"):
				parent.take_damage(self)

				numEnemies += 1
				
		get_node("../Camera2D").shake(0.1,20, 10 * numEnemies if numEnemies < 5  else 50);
		
		damaged = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func start(dir):
	if timer <= 0:
		damaged = false
		
		timer = 0.3
		
		self.rotation_degrees = dir + randf() * 20 - 10
		AnimatedSprite.frame = 0
		
		var dirRad = deg2rad(dir)
		Player.velocity = Vector2(cos(dirRad), sin(dirRad)) * Player.speed * 3
		
		direction = Vector2(cos(dirRad), sin(dirRad))
		
		return self
	
	return null
	
func isFinished():
	return timer <= 0
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
