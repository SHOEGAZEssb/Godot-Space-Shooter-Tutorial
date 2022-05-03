extends Area2D

var plMeteorEffect := preload("res://Meteor/MeteorEffect.tscn")

export var minSpeed: float = 20
export var maxSpeed: float = 50
export var minRotationRate: float = -20
export var maxRotationRate: float = 20

export var life: int = 20

var speed: float = 0
var rotationRate: float = 0

func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	rotationRate = rand_range(minRotationRate, maxRotationRate)	
	
func _physics_process(delta):
	rotation_degrees += rotationRate * delta
	position.y += speed * delta
	
func damage(amount: int):
	if life <= 0:
		return
	
	life -= amount
	if life <= 0:
		var effect := plMeteorEffect.instance()
		effect.position = position
		get_parent().add_child(effect)
		Signals.emit_signal("on_score_increment", 2)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # Replace with function body.


func _on_Meteor_area_entered(area):
	if area is Player:
		area.damage(1)
		queue_free()
