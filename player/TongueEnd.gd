extends KinematicBody2D

var speed: = 50
var target = Vector2()
var velocity = Vector2()
var onetongue = false;

func _ready():
	target = get_global_mouse_position()

func _physics_process(delta):
	velocity = (target - position).normalized() * speed
	# rotation = velocity.angle()
	if (target - position).length() > 5:
		velocity = move_and_slide(velocity)

