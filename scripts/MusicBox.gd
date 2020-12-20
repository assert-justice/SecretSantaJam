extends Area2D



func _on_MusicBox_body_entered(body):
	if body.is_in_group("player"):
		get_tree().get_nodes_in_group("gameManager")[0].win()
