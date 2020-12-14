extends Node2D

export var enabled = false
export var aquired = false

func _physics_process(delta):
	# set position to mouse pos
	position = get_viewport().get_mouse_position() * 2
	hold()
		
func toggle():
	if Input.is_action_just_pressed("laser"):
		if not aquired:
			enabled = false
		else:
			enabled = not enabled
		$Sprite.visible = enabled

func hold():
	enabled = aquired and Input.is_action_pressed("laser")
	$Sprite.visible = enabled

func _ready():
	add_to_group("light")
	add_to_group("dot")

