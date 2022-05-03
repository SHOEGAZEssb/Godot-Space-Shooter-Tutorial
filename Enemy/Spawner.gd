extends Node2D

var preloadedEnemies := [
	preload("res://Enemy/FastEnemy.tscn"),
	preload("res://Enemy/SlowShooter.tscn"),
	preload("res://Enemy/BouncerEnemy.tscn")
]
var plMeteor := preload("res://Meteor/Meteor.tscn")

onready var spawnTimer := $SpawnTimer

var nextSpawnTime: float = 2.0

func _ready():
	randomize()
	spawnTimer.start(nextSpawnTime)
	

func _on_SpawnTimer_timeout():
	var viewRect := get_viewport_rect()
	var xPos := rand_range(viewRect.position.x, viewRect.end.x)
	
	var enemy = null
	if randf() < 0.1:
		enemy = plMeteor.instance()
	else:	
		var enemyPreload = preloadedEnemies[randi() % preloadedEnemies.size()]
		enemy = enemyPreload.instance()

	enemy.position = Vector2(xPos, position.y)
	get_tree().current_scene.add_child(enemy)	
	spawnTimer.start(nextSpawnTime)
