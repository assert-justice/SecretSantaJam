extends Node2D

export var enabled = false
export var aquired = false
var trail = []
export var launch_power = 2000
export var can_launch = false
export var can_lure = false
var spinner = null

func _physics_process(delta):
	# set position to mouse pos
	position = get_viewport().get_mouse_position() * 2
	spinner.rotation_degrees += delta * 300
	hold()
	launch()
	
func launch():
	if not can_launch:
		return
	var snails = get_tree().get_nodes_in_group("snail")
	var target = null
	var dis = 100
	for snail in snails:
		if snail.position.distance_to(position) < dis:
			target = snail
			dis = snail.position.distance_to(position)
	if target == null:
		spinner.visible = false
		return
	spinner.visible = true
	if spinner.get_parent() != null:
		spinner.get_parent().remove_child(spinner)
	target.add_child(spinner)
	spinner.position = Vector2()
	if Input.is_action_just_pressed("grapple"):
		var player = get_tree().get_nodes_in_group("player")[0]
		player.set_velocity( (position - player.position).normalized() * launch_power)
		
func toggle():
	if Input.is_action_just_pressed("laser"):
		if not aquired:
			enabled = false
		else:
			enabled = not enabled
		$Star.visible = enabled

func hold():
	if not can_lure:
		return
	enabled = aquired and Input.is_action_pressed("laser")
	$Star.visible = enabled

func _ready():
	add_to_group("light")
	add_to_group("dot")
	spinner = $Spinner
	remove_child(spinner)

