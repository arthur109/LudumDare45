extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var speed = 300;
var direction = Vector2(1,0)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += direction*speed*delta;
