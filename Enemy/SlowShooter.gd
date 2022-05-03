extends Enemy
class_name SlowShooter

onready var firingTimer := $FiringTimer

export var fireRate: float = 1.0

func _process(delta):
	if firingTimer.is_stopped():
		fire()
		firingTimer.start(fireRate)
