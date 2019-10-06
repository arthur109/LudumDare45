extends Sprite

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export var speed = 300;
var move_direction = Vector2(1,0)
var direction = Vector2(1,0)
var damage = 0.1;
var explosion = preload("res://scenes/BulletDeath.tscn");
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	global_position += move_direction*speed*delta;


func _on_Area2D_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("enemies"):
		area.get_parent().take_damage(self);
		
		if get_parent():
			var temp = (explosion.instance())
			temp.global_position = global_position
			get_parent().add_child(temp)
			get_parent().remove_child(self)
