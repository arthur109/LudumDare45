extends KinematicBody2D

export (int) var speed = 200
export (bool) var canDash = true
#export (float) var reloadSpeed
#var reload = reloadSpeed
#var playerBullet = preload("res://Scenes/PlayerBullet.tscn")

var currentAbility = null



var velocity = Vector2()
onready var Sprite := $BaseSprite 
var damage = 1;

onready var Dash := $Dash
onready var Punch := $Punch

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
	
func get_intended_dir():
	var dirInput = get_dir_input()
	return rad2deg(dirInput.angle()) if dirInput.length_squared() > 0 else 180 if Sprite.flip_h else 0
	
func move():
	velocity = move_and_slide(get_dir_input() * speed)
		
	if velocity.x != 0 or velocity.y != 0:
		if Sprite.get_animation() != "run":
			Sprite.play("run")
	else:
		if Sprite.get_animation() != "idle":
			Sprite.play("idle")

func _physics_process(delta):
#	reload -= delta
	var dirInput = get_dir_input()
	var intendedDir = get_intended_dir()
	
	if currentAbility == null:
		move()
				
	if Input.is_action_pressed('dash') and not currentAbility:
		currentAbility = Dash.start(intendedDir)
		
	if Input.is_action_pressed("punch") and not currentAbility:
		currentAbility = Punch.start(intendedDir)
		
	if currentAbility:
		if currentAbility.isFinished():
			currentAbility = null
		
		
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true
		


