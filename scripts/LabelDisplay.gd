extends Area2D

func _on_LabelDisplay_body_entered(body):
	if body.is_in_group("player"):
		get_parent().visible = true


func _on_LabelDisplay_body_exited(body):
	if body.is_in_group("player"):
		get_parent().visible = false
