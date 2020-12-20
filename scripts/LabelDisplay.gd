extends Area2D

export var muted = false

func _on_LabelDisplay_body_entered(body):
	if body.is_in_group("player"):
		get_parent().visible = true
		if not muted:
			$AudioStreamPlayer2D.play()


func _on_LabelDisplay_body_exited(body):
	if body.is_in_group("player"):
		get_parent().visible = false
