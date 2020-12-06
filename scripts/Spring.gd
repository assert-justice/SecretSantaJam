extends Area2D

export var velocity = 2000
var bodies = 0

func set_active():
	var active = bodies > 0
	$Up.visible = not active
	$Down.visible = active

func _on_Spring_body_entered(body):
	body.call("set_velocity", Vector2(0, -velocity))
	bodies += 1
	set_active()

func _on_Spring_body_exited(body):
	bodies -= 1
	set_active()
