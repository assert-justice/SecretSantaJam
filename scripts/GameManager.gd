extends Node2D

var scene = null
var scene_res = null
export var startRoom = "TestRoom"
var powers = {}

func _ready():
	scene_res = load('res://rooms/' + startRoom + '.tscn')
	scene = scene_res.instance()
	add_child(scene)
	#add_power("magnet")
	
func _physics_process(delta):
	if Input.is_action_just_released("reset"):
		remove_child(scene)
		scene.queue_free()
		scene = scene_res.instance()
		add_child(scene)
		apply_powers()
		
func add_power(power):
	powers[power] = true
	apply_powers()
	
func apply_powers():
	var dot = get_tree().get_nodes_in_group("dot")[0]
	if "lure" in powers:
		dot.can_lure = true
	if "magnet" in powers:
		dot.can_launch = true

func use_door(room, door):
	print("traveling to room ", room, " door ", door)
	remove_child(scene)
	scene.queue_free()
	scene_res = load('res://rooms/' + room + '.tscn')
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
		apply_powers()
