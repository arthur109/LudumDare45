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
	angle = getAngle();
	if(angle):

		var offset =  (randf()*10)-5;
		var direction = Vector2(cos(deg2rad(angle+offset)),sin(deg2rad(angle+offset)))
		$Turret.rotation_degrees = angle;
		$Turret.offset = Vector2(1,1)*pow(1-(shootCounter/shootSpeed),1);
		shootCounter += delta;
		if shootCounter >= shootSpeed:
			var temp = BULLET.instance();
			temp.rotation_degrees = angle + offset;
			temp.move_direction = direction;
			temp.direction = direction.normalized()*0.5;
			get_node("../../Bullets").add_child(temp);
			temp.global_position = global_position
			shootCounter = 0



func getAngle():
	var enemys = get_node("../../Enemies/").get_children();
	var closestDir = Vector2(1,1);
	var closestDistance = 100000;

	for x in enemys:
		if global_position.distance_to(x.global_position) < closestDistance:
			closestDistance = global_position.distance_to(x.global_position);
			closestDir = x.global_position - global_position
			
	if(closestDistance > 1000 or enemys.size() == 0):
		return false

	return rad2deg(closestDir.angle())
