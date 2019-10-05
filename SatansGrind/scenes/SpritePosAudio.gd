extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	get_viewport().audio_listener_enable_2d = true
	$AudioStreamPlayer2D.play()

func _porcess(delta):
	if self.position.x > 0 - self.texture.get_width():
		move_local_x(-1)
	else:
		self.position.x = get_viewport().get_visible_rect().size.x