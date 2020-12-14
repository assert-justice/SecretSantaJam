extends KinematicBody2D

export (Texture) var blueGem
export (Texture) var orangeGem
export (Texture) var yellowGem
export (Texture) var greenGem

export var wanderRange = 300
export var closeEnough = 10
var speed = 150
export var wander_speed = 150
export var travel_speed = 300

var velocity = Vector2()
var target = null
var state = "wander"
var space_state = null

func random_target():
	var angle = randf() * 2 * PI
	var vec = Vector2(cos(angle), sin(angle)) * wanderRange + position
	return vec
	
func get_target():
	var target = null
	var dist = 1000000
	# loop through lights and find the closest one
	for light in get_tree().get_nodes_in_group("light"):
		if light.enabled:
			var probe = space_state.intersect_ray(position, light.position)
			if len(probe) > 0 and not light.is_in_group("dot"):
				continue
			var d = position.distance_to(light.position)
			if d < dist:
				dist = d
				target = light.position
	return target
	
func handle_pushing(_delta):
	if velocity.x != 0:
		var probe = Vector2(sign(velocity.x)* 40, 0)
		var test = space_state.intersect_ray(self.position, self.position + probe, [self])
		if len(test) > 0 and test.collider.is_in_group("box"):
			test.collider.transform[2][0] += velocity.x * _delta

func _physics_process(delta):
	space_state = get_world_2d().direct_space_state
	handle_pushing(delta)
	$Body0.flip_h = velocity.x > 0
	var temp = get_target()
	if temp != null:
		target = temp
		state = "travel"
		speed = travel_speed
	if state == "wander":
		if target == null or position.distance_to(target) < closeEnough:
			target = random_target()
		else:
			velocity = (target - position).normalized() * speed
			
	elif state == "travel":
		if target == null or position.distance_to(target) < closeEnough:
			state = "wander"
			speed = wander_speed
		else:
			velocity = (target - position).normalized() * speed
	
	velocity = move_and_slide(velocity)
	if velocity.length() < speed:
		state = "wander"
		target = random_target()
