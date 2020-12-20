extends Node2D

var scene = null
var scene_res = null
export var startRoom = "TestRoom"
var powers = {}

func _ready():
	scene_res = load('res://rooms/' + startRoom + '.tscn')
	#powers["magnet"] = true
	load_scene()
	
func win():
	$MainMusic.stop()
	$Club.play()
	
func load_scene():
	if scene != null:
		remove_child(scene)
		scene.queue_free()
	scene = scene_res.instance()
	add_child(scene)
	apply_powers()
	var powerups = get_tree().get_nodes_in_group("powerup")
	for p in powerups:
		if p.power in powers:
			p.get_parent().queue_free()
	if not $MainMusic.playing:
		$MainMusic.play()
		$Club.stop()
	
func _physics_process(delta):
	if Input.is_action_just_released("reset"):
		load_scene()
		
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
	scene_res = load('res://rooms/' + room + '.tscn')
	if scene_res == null:
		print(room, "does not exist!")
	else:
		load_scene()
		var doors = get_tree().get_nodes_in_group('door')
		var player = get_tree().get_nodes_in_group('player')[0]
		for d in doors:
			if d.doorName == door:
				player.position = d.position
		print("travel completed")
