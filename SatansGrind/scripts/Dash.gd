extends Node2D

onready var CharacterTrail := $CharacterTrail 
onready var Particles2D := $Particles2D 

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func dash():
	print("dash")
	CharacterTrail.emitting = false
	CharacterTrail.emitting = true
	Particles2D.emitting = true
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
