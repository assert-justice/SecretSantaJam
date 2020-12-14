extends KinematicBody2D

export (float) var gravity = 100
export var drag = 20

var velocity = Vector2()

func _physics_process(delta):
	velocity.y += gravity
	if abs(velocity.x) > drag:
		velocity.x -= sign(velocity.x) * drag
	else:
		velocity.x = 0
	velocity = move_and_slide(velocity)

func set_velocity(vel):
	velocity = vel
