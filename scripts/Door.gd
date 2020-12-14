extends Area2D

export var doorName = ''
export var roomName = ''
export var destName = ''
export var wait = 0.1

func _physics_process(delta):
	if wait > 0:
		wait -= delta

func _on_Door_body_entered(body):
	if body.is_in_group('player') and not wait > 0:
		var sceneManager = get_tree().get_root().get_child(0)
		sceneManager.use_door(roomName, destName)
