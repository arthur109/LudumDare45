extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var shootSpeed = 0.5;
var shootCounter = 0;
var BULLET = preload("res://scenes/Bullet.tscn");
var angle = 0;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
#	angle += delta*20
	var offset = 45;
	var direction = Vector2(cos(deg2rad(angle+offset)),sin(deg2rad(angle+offset)))
	$Turret.rotation_degrees = angle;
	print((1-(shootCounter/shootSpeed)));
	$Turret.offset = Vector2(1,1)*pow(1-(shootCounter/shootSpeed),1);
	shootCounter += delta;
	if shootCounter >= shootSpeed:
		var temp = BULLET.instance();
		temp.rotation_degrees = angle + offset;
		temp.direction = direction;
		add_child(temp);
		shootCounter = 0 
		
	pass
