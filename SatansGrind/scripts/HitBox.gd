extends CollisionShape2D

var health = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func take_damage(damage):
	health -= damage
	
func find_next_tile():
	

