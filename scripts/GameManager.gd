extends Node2D

var scene = null
export var startRoom = "TestRoom"

func _ready():
	var scene_res = load('res://rooms/' + startRoom + '.tscn')
	scene = scene_res.instance()
	add_child(scene)

func use_door(room, door):
	print("traveling to room ", room, " door ", door)
	remove_child(scene)
	var scene_res = load('res://rooms/' + room + '.tscn')
	if scene_res == null:
		print(room, "does not exist!")
	else:
		scene = scene_res.instance()
		add_child(scene)
		var doors = get_tree().get_nodes_in_group('door')
		var player = get_tree().get_nodes_in_group('player')[0]
		for d in doors:
			if d.doorName == door:
				player.position = d.position
		print("travel completed")
