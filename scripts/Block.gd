extends StaticBody2D

export var col = "blue"
export var animSpeed = 0.5
var anim = 0
var weights = 0
var enabled = false
var start_scale = Vector2()

func set_active():
	enabled = weights > 0
	#$Sprite.visible = not enabled
	#$CollisionShape2D.disabled = enabled
	
func add_weight():
	weights += 1
	set_active()

func remove_weight():
	weights -= 1
	set_active()

func _ready():
	add_to_group(col)
	add_to_group("block")
	anim = animSpeed
	start_scale = scale

func _physics_process(delta):
	if enabled and anim > 0: # shrinking
		anim -= delta
		if anim > 0:
			scale = start_scale * ease( anim / animSpeed, 4.8)
		else:
			$Sprite.visible = false
			$CollisionShape2D.disabled = true
	elif not enabled and anim < animSpeed:
		$Sprite.visible = true
		$CollisionShape2D.disabled = false
		anim += delta
		scale = start_scale * ease( anim / animSpeed, 4.8)
			
