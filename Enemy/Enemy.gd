extends Area2D
class_name Enemy

var plBullet := preload("res://Bullet/EnemyBullet.tscn")
var plEnemyExplosion := preload("res://Enemy/EnemyExplosion.tscn")

onready var firingPositions := $FiringPositions

export var verticalSpeed: float = 10.0
export var health: int = 5

func _physics_process(delta):
	position.y += verticalSpeed * delta

func fire():
	for pos in firingPositions.get_children():
		var bullet := plBullet.instance()
		bullet.global_position = pos.global_position
		get_tree().current_scene.add_child(bullet)

func damage(amount: int):
	if health <= 0:
		return
	
	health -= amount
	if health <= 0:
		var effect = plEnemyExplosion.instance()
		effect.global_position = global_position
		get_tree().current_scene.add_child(effect)
		Signals.emit_signal("on_score_increment", 1)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_area_entered(area):
	if area is Player:
		area.damage(1)
		queue_free()
