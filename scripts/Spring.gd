extends Area2D

export var velocity = 2000
var bodies = 0

func set_active():
	var active = bodies > 0
	$Up.visible = not active
	$Down.visible = active

func _on_Spring_body_entered(body):
	if body.has_method("set_velocity"):
		var vec = Vector2(0, -velocity)
		vec = global_transform.xform(vec) - position
		body.call("set_velocity", vec)
		bodies += 1
		set_active()

func _on_Spring_body_exited(body):
	bodies -= 1
	set_active()
