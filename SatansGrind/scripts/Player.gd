extends KinematicBody2D

export (int) var speed = 200
#export (float) var reloadSpeed
#var reload = reloadSpeed
#var playerBullet = preload("res://Scenes/PlayerBullet.tscn")
var velocity = Vector2()
onready var Sprite := $AnimatedSprite 
var damage = 1;


func _process(delta):
	pass
	
func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('right'):
		velocity.x += 1
	if Input.is_action_pressed('left'):
		velocity.x -= 1
	if Input.is_action_pressed('down'):
		velocity.y += 1
	if Input.is_action_pressed('up'):
		velocity.y -= 1
#	if Input.is_action_pressed("shoot") and reload < 0:
#		fire()
	velocity = velocity.normalized() * speed

func _physics_process(delta):
#	reload -= delta
	get_input()
	velocity = move_and_slide(velocity)*delta
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true
		
	if velocity.x != 0 or velocity.y != 0:
		if Sprite.get_animation() != "run":
			Sprite.play("run")
	else:
		if Sprite.get_animation() != "idle":
			Sprite.play("idle")
