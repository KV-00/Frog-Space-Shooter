extends Area2D

export var minSpeed: float = 10
export var maxSpeed: float = 20

export var life: int = 3

var speed: float = 0

func _ready():
	speed = rand_range(minSpeed, maxSpeed)
	
func _physics_process(delta):
	position.y += speed * delta
	
func damage(amount: int):
	life -=amount
	if life <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
