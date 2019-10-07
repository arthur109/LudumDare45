extends KinematicBody2D

export (int) var speed = 200

#export (float) var reloadSpeed
#var reload = reloadSpeed
#var playerBullet = preload("res://Scenes/PlayerBullet.tscn")

var currentAbility = null



var velocity = Vector2()
onready var Sprite := $BaseSprite 
onready var AttackRadius := $AttackRadius
var damage = 1;

onready var Dash := $Dash
onready var Punch := $Punch
onready var Slash := $Slash

func _process(delta):
	pass
	
func can_dash():
	return GlobalInfo.points >= 2
	
func can_slash():
	return GlobalInfo.points >= 4
	
func get_idle():
	if can_dash():
		return "idle_horns"
	else:
		return "idle"
	
func get_run():
	if can_dash():
		return "run_horns"
	else:
		return "run"
	
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
	
var lastIntendedDir = 0	
var intendedDirTimer = 0

func get_closest_enemy_dir(delta):
	var enemies = []
	
	for area in AttackRadius.get_overlapping_areas():
		var parent = area.get_parent()
		if parent.is_in_group("enemies"):
			enemies.append(parent)
	
	var closest = 999999999
	var closestDiff = null
	
	for enemy in enemies:
		var diff = enemy.transform.get_origin() - transform.get_origin()
		var distance = abs(diff.length_squared())
		
		if distance < closest:
			closest = distance
			closestDiff = diff
		
	if closestDiff:
		var enemyDir = rad2deg(closestDiff.angle())
		return enemyDir
	
	return null
	

func get_intended_dir(delta):
	var dirInput = get_dir_input()
	
	var dir = rad2deg(dirInput.angle())
	
	if dirInput.length_squared() > 0 and dir != lastIntendedDir:
		intendedDirTimer -= delta
		
		if intendedDirTimer <= 0 or int (lastIntendedDir) % 90 == 0:
			lastIntendedDir = dir
			intendedDirTimer = 0.05
		
	else:
		intendedDirTimer = 0.05
		
	
	return lastIntendedDir
	
	
func move():
	velocity = move_and_slide(get_dir_input() * speed)
		
	

func _physics_process(delta):
#	reload -= delta
	var dirInput = get_dir_input()
	
	var intendedDir = get_intended_dir(delta)
	var closestEnemyDir = get_closest_enemy_dir(delta)
	
	if currentAbility == null:
		move()
				
	if Input.is_action_pressed('dash') and not currentAbility and can_dash():
		currentAbility = Dash.start(intendedDir)
		
	if Input.is_action_pressed("slash") and not currentAbility and can_slash():
		currentAbility = Slash.start(closestEnemyDir if closestEnemyDir != null else intendedDir)
		
	if Input.is_action_pressed("punch") and not currentAbility:
		currentAbility = Punch.start(closestEnemyDir if closestEnemyDir != null else intendedDir)
		
	if currentAbility:
		if currentAbility.isFinished():
			currentAbility = null
		
	if velocity.x != 0 or velocity.y != 0:
		if Sprite.get_animation() != get_run():
			Sprite.play(get_run())
	else:
		if Sprite.get_animation() != get_idle():
			Sprite.play(get_idle())
		
	if velocity.x > 0:
		Sprite.flip_h = false
	elif velocity.x < 0:
		Sprite.flip_h = true
		


