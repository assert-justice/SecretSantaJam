extends Area2D

export var power = "magnet"
var enabled = true

func _on_Powerup_body_entered(body):
	if enabled and body.is_in_group("player"):
		get_tree().get_nodes_in_group("gameManager")[0].add_power(power)
		$AudioStreamPlayer2D.play()
		get_parent().visible = false
		enabled = false
		
