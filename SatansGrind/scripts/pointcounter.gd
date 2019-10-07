extends Label

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var lastUpdateCounter = 100;
var lastValue = GlobalInfo.points;
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	lastUpdateCounter += delta;
	var size = 1/pow(lastUpdateCounter,4)/20;
	print(size)
	print(lastUpdateCounter);
	get("custom_fonts/font").set_size(int(32+size));
	print(Position2D);
	
	if lastValue != GlobalInfo.points:
		lastUpdateCounter = 0.01;
		lastValue = GlobalInfo.points
		
	set_text(String(GlobalInfo.points))
	pass
