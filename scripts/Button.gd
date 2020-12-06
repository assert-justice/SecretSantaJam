extends Area2D

export var color = "blue"
var weights = 0

func set_active():
	var active = weights > 0
	$Inactive.visible = not active
	$Active.visible = active
	
func add_weight():
	weights += 1
	set_active()

func remove_weight():
	weights -= 1
	set_active()

func _ready():
	add_to_group(color)

func _on_Button_body_entered(body):
	get_tree().call_group(color, "add_weight")

func _on_Button_body_exited(body):
	get_tree().call_group(color, "remove_weight")
