extends Node2D


var thingToSpawn = preload("res://scenes/Enemy.tscn")
export (float) var reloadSpeed = 5

var _reload = reloadSpeed
export (float) var reloadSpeedIncrement = 3/1000
var spawnRange

func _ready() -> void:
	reloadSpeed = reloadSpeed
	reloadSpeedIncrement = reloadSpeedIncrement
	spawnRange = self.get_children()
	
func _process(delta: float) -> void:
	_reload -= delta
	reloadSpeed -= reloadSpeedIncrement;
	if _reload < 0:
		var enemy = thingToSpawn.instance()
		enemy.global_position = Vector2(rand_range(spawnRange[0].global_position.x, spawnRange[1].global_position.x), rand_range(spawnRange[0].global_position.y,spawnRange[1].global_position.y))
		get_node("../Enemies").add_child(enemy)
		_reload = reloadSpeed
