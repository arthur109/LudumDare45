extends Node2D

onready var CharacterTrail := $CharacterTrail 
onready var Player := get_parent()
const DashTrail = preload("res://scenes/DashTrail.tscn")

var dashTimer = 0
var dashCooldown = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	dashTimer -= delta
	dashCooldown -= delta
	
	if dashTimer > 0:
		Player.move_and_slide(Player.velocity)
	
	
func start(dir):
	if (dashCooldown <= 0):
		dashCooldown = 1
		dashTimer = 0.1
		CharacterTrail.emitting = true
		self.add_child(DashTrail.instance())
		var dirRad = deg2rad(dir)
		
		Player.velocity = Vector2(cos(dirRad), sin(dirRad)) * Player.speed * 10
		
		return self
		
	return null

func isFinished():
	return dashTimer <= 0
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
