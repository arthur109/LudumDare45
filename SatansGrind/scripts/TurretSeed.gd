extends AnimatedSprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var maxCounter = 10
var counter = 0;
var TURRET = preload("res://scenes/Turret.tscn");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	counter += delta;
	if (counter > maxCounter):
		if randf() <= 0.2:
			var temp = TURRET.instance();
			temp.global_position = global_position+Vector2(8*4,8*4); 
			get_parent().add_child(temp);
		get_parent().remove_child(self);
		
	pass
