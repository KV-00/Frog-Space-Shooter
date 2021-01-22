extends AnimatedSprite

# 0.0 -> top left of screen
# 1.0 -> bottom right of screen
export var diagonalPosition := 0.0

onready var swarm := get_node("/root/Swarm")

func _ready() -> void:

	match swarm.direction:
		"down right":
			flip_h = true
			flip_v = true
		"down left":
			flip_v = true
		"up right":
			flip_h = true

func _process(_delta: float) -> void:
	var width: float = get_viewport_rect().size.x
	var height: float = get_viewport_rect().size.y
	var endPoint: float = min(width, height)

	var xPos: float = 0.0
	var yPos: float = 1.0
	match swarm.direction:
		"down right":
			xPos = diagonalPosition * endPoint
			yPos = diagonalPosition * endPoint
		"down left":
			xPos = width - diagonalPosition * endPoint
			yPos = diagonalPosition * endPoint
		"up right":
			xPos = diagonalPosition * endPoint
			yPos = height - diagonalPosition * endPoint
		"up left":
			xPos = width - diagonalPosition * endPoint
			yPos = height - diagonalPosition * endPoint

	position = Vector2(xPos, yPos)
