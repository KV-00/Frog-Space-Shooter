extends KinematicBody2D

var plbullet := preload("res://player/bullet.tscn")
var pltongue := preload("res://player/tongueEnd.tscn")

onready var animatedSprite := $AnimatedSprite
onready var firingPositions := $FiringPositions
onready var fireDelayTimer := $FireDelayTimer
onready var animationPlayer := $AnimationPlayer

export var speed: float = 150
export var fireDelay: float = 0.1
var friction: float = 0.1
var acceleration: float = 0.1
var velocity: Vector2 = Vector2.ZERO
var _tongue = null

func can_shoot():
	return _tongue == null or not _tongue.is_visible()

func _process(_delta: float) -> void:
	# Animate
	if Input.is_action_pressed("move_right") and Input.is_action_pressed("move_left"):
		animatedSprite.play("straight")
	elif Input.is_action_pressed("move_left"):
		animatedSprite.play("left")
	elif Input.is_action_pressed("move_right"):
		animatedSprite.play("right")
	else:
		animatedSprite.play("straight")

	#Check if shooting bullet
	if Input.is_mouse_button_pressed(BUTTON_LEFT) and fireDelayTimer.is_stopped():
		fireDelayTimer.start(fireDelay)
		animationPlayer.play("MelonFlash")
		for child in firingPositions.get_children():
			var bullet := plbullet.instance()
			bullet.global_position = child.global_position
			get_tree().current_scene.add_child(bullet)

	if Input.is_mouse_button_pressed(BUTTON_RIGHT) and can_shoot():
		if _tongue == null:
			_tongue = preload("TongueEnd.tscn").instance()
		for child in firingPositions.get_children():
			var tongue := pltongue.instance()
			tongue.global_position = child.global_position
			get_tree().current_scene.add_child(tongue)

func _physics_process(_delta: float) -> void:
	var input_velocity = Vector2.ZERO
	# Check input for "desired" velocity
	if Input.is_action_pressed("move_right"):
		input_velocity.x += 1
	if Input.is_action_pressed("move_left"):
		input_velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		input_velocity.y += 1
	if Input.is_action_pressed("move_up"):
		input_velocity.y -= 1
	input_velocity = input_velocity.normalized() * speed

	# If there's input, accelerate to the input velocity
	if input_velocity.length() > 0:
		velocity = velocity.linear_interpolate(input_velocity, acceleration)
	else:
		# If there's no input, slow down to (0, 0)
		velocity = velocity.linear_interpolate(Vector2.ZERO, friction)
	velocity = move_and_slide(velocity)


	# Make sure that we are in the screen
	var viewRect := get_viewport_rect()
	position.x = clamp(position.x, 0, viewRect.size.x)
	position.y = clamp(position.y, 0, viewRect.size.y)
