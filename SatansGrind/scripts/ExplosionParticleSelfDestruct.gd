extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"

export(float) var maxlife = 0.5;
var counter = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter += delta;
	if counter >= maxlife:
		get_parent().remove_child(self)