extends Area2D

var plBulletEffect := preload("res://Bullet/BulletEffect.tscn")

export var speed: float = 500

func _physics_process(delta):
	position.y -= speed * delta


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Bullet_area_entered(area):
	if area.is_in_group("damageable"):
		var bulletEffect := plBulletEffect.instance()
		bulletEffect.position = position
		get_parent().add_child(bulletEffect)
		area.damage(1)
		Signals.emit_signal("on_screen_shake_requested", 1.5, 0.075)
		queue_free()
