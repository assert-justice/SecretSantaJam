extends KinematicBody2D

export (float) var gravity = 100
var velocity = Vector2()

func _physics_process(delta):
	velocity.y += gravity
	velocity = move_and_slide(velocity)

func set_velocity(vel):
	velocity = vel
