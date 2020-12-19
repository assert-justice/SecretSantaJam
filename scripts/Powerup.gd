extends Area2D

export var power = "magnet"

func _on_Powerup_body_entered(body):
	if body.is_in_group("player"):
		get_tree().get_nodes_in_group("gameManager")[0].add_power(power)
		get_parent().queue_free()
