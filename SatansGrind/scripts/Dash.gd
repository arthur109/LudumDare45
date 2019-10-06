extends Node2D

onready var CharacterTrail := $CharacterTrail 
onready var Area2D := $Area2D
onready var Player := get_parent()
const DashTrail = preload("res://scenes/DashTrail.tscn")

var dashTimer = 0
var dashCooldown = 0

var damage = 1
var direction = Vector2(1,0)

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
		Area2D.monitoring = true
	else:
		Area2D.monitoring = false
	
	
func start(dir):
	if (dashCooldown <= 0):
		dashCooldown = 1
		dashTimer = 0.1
		CharacterTrail.emitting = true
		self.add_child(DashTrail.instance())
		var dirRad = deg2rad(dir)
		
		Player.velocity = Vector2(cos(dirRad), sin(dirRad)) * Player.speed * 10
		direction = Player.velocity / 3000
		
		return self
		
	return null

func isFinished():
	return dashTimer <= 0
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	var parent = area.get_parent()
	if parent.is_in_group("enemies"):
		parent.take_damage(self)
