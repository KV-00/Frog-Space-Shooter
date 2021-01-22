extends Area2D

export var speed: float = 300

func _physics_process(delta: float) -> void:
	position.y -= speed * delta

func _on_bullet_area_entered(area: Area2D) -> void:
	if area.is_in_group("damageable"):
		area.damage(1)
		queue_free()

func _on_VisibilityNotifier2D_screen_exited() -> void:
	queue_free()
