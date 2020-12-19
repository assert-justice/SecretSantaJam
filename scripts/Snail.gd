extends KinematicBody2D

export var speed = 120
export var gravity = 100

var facing = false

var velocity = Vector2()
var space_state = null

func set_velocity(vel):
	velocity = vel

func _physics_process(delta):
	space_state = get_world_2d().direct_space_state
	#var probe = self.position + Vector2.DOWN * 60
	var probe = global_transform.xform(Vector2.DOWN * 40)
	#print(probe - position)
	#var offset = Vector2.RIGHT * 60
	var offset = (global_transform.xform(Vector2.RIGHT) - position) * 60
	var groundLeft = len(space_state.intersect_ray(self.position - offset, probe - offset, [self])) > 0
	var groundRight = len(space_state.intersect_ray(self.position + offset, probe + offset, [self])) > 0
	var wallLeft = len(space_state.intersect_ray(self.position, self.position - offset, [self])) > 0
	var wallRight = len(space_state.intersect_ray(self.position, self.position + offset, [self])) > 0
	
	#print("groundLeft: ", groundLeft, " groundRight: ", groundRight, " wallLeft: ", wallLeft, " wallRight: ", wallRight)
	var vel = Vector2()
	if facing:
		if not groundRight or wallRight:
			facing = false
			#velocity.x = -speed
			vel.x = -speed
		else:
			vel.x = speed
	else:
		if not groundLeft or wallLeft:
			facing = true
			#velocity.x = speed
			vel.x = speed
		else:
			vel.x = -speed
	var hspeed = velocity.y
	#print(global_transform.xform(vel) - position)
	velocity = global_transform.xform(vel) - position
	#print(velocity)
	if groundLeft or groundRight:
		$AnimatedSprite.flip_h = facing
	else:
		pass
		velocity.y += hspeed + gravity
	move_and_slide(velocity)

