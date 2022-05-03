extends Enemy

export var rotationRate: float = 20.0

func _process(delta):
	rotate(deg2rad(rotationRate) * delta)
