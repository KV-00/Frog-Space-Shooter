extends Area2D

export var minSpeed: float = 10
export var maxSpeed: float = 20

export var health: int = 3

var speed: float = 0

func _ready() -> void:
	speed = rand_range(minSpeed, maxSpeed)

func _physics_process(delta: float) -> void:
	position.y += speed * delta

func damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
