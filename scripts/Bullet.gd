extends Area2D

export var velocity = Vector2(1500, 0)
export var bounce = false

func _physics_process(delta):
	position += transform.x * velocity.x * delta
	position += transform.y * velocity.y * delta
	if position.x > 2100:
		queue_free()

func _on_Bullet_body_entered(body):
	if body.is_in_group("player"):
		pass
	elif body.is_in_group("enemy"):
		pass
	else:
		queue_free()
