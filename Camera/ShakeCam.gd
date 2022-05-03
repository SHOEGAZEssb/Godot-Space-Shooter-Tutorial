extends Camera2D

export var shakeBaseAmount: float = 1.0

var shakeDampening: float = 0.075
var shakeAmount: float = 0.0

func _ready():
	Signals.connect("on_screen_shake_requested", self, "_on_screen_shake_requested")

func _process(delta):
	if shakeAmount > 0:
		position.x = rand_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		position.y = rand_range(-shakeBaseAmount, shakeBaseAmount) * shakeAmount
		shakeAmount = lerp(shakeAmount, 0.0, shakeDampening)
	else:
		position = Vector2(0,0)
	
func _on_screen_shake_requested(amount: float, dampening: float):
	if amount > shakeAmount:
		shakeAmount = amount
	shakeDampening = dampening
