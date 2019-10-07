extends Node2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var lastUpdateCounter = 0.1;
var lastValue = GlobalInfo.points;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lastUpdateCounter += delta;
	var size = 1/pow(lastUpdateCounter,3)/20;
	print("size:");
	print(size)
	print("last update:");
	print(lastUpdateCounter);
	print("scale:");
	print(scale)
	scale.x = 0.5+size;
	scale.y = 0.5+size;
	
	if lastValue != GlobalInfo.points:
		lastUpdateCounter = 0.05;
		lastValue = GlobalInfo.points
		
	get_node("GUI/Label").set_text(String(GlobalInfo.points))
	pass