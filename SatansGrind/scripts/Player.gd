extends KinematicBody2D

export (int) var speed = 200
export (bool) var canDash = true
#export (float) var reloadSpeed
#var reload = reloadSpeed
#var playerBullet = preload("res://Scenes/PlayerBullet.tscn")
var dashTimer = 0
var dashCooldown = 0

var velocity = Vector2()
onready var Sprite := $BaseSprite 
var damage = 1;

onready var Dash := $Dash

func _process(delta):
	pass
	
func get_dir_input():
	var inputVelocity = Vector2()
	
	if Input.is_action_pressed('right'):
		inputVelocity.x += 1
	if Input.is_action_pressed('left'):
		inputVelocity.x -= 1
	if Input.is_action_pressed('down'):
		inputVelocity.y += 1
	if Input.is_action_pressed('up'):
		inputVelocity.y -= 1
		
	return inputVelocity.normalized()

func _physics_process(delta):
#	reload -= delta
	var dirInput = get_dir_input()
	
	dashCooldown -= delta
	
	if dashTimer == 0 and dashCooldown <= 0 and Input.is_action_pressed('dash') and dirInput.length_squared() > 0:
		dashTimer = 0.1
		velocity = get_dir_input() * speed * 10
		Dash.dash()

		
	if dashTimer > 0:

		move_and_slide(velocity)

		dashTimer -= delta
		if dashTimer <= 0: 
			dashTimer = 0
			dashCooldown = 1
		
	else:
		velocity = move_and_slide(dirInput * speed)*delta
		
		if velocity.x != 0 or velocity.y != 0:
			if Sprite.get_animation() != "run":
				Sprite.play("run")
		else:
			if Sprite.get_animation() != "idle":
				Sprite.play("idle")
		
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true
		
	

